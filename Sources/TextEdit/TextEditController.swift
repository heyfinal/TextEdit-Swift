import AppKit
import Foundation

class TextEditController: NSViewController {
    
    private var scrollView: NSScrollView!
    private var textView: NSTextView!
    
    private var currentDocument: Document?
    private var isShowingLineNumbers = false
    private var currentFontSize: CGFloat = 14.0
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 1200, height: 800))
        setupTextEditor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        createNewDocument()
    }
    
    private func setupTextEditor() {
        // Create scroll view
        scrollView = NSScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = false
        scrollView.borderType = .noBorder
        
        // Configure scroll view appearance for dark mode
        scrollView.backgroundColor = NSColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        scrollView.drawsBackground = true
        
        // Create text view
        let contentSize = scrollView.contentSize
        textView = NSTextView(frame: NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
        textView.minSize = NSSize(width: 0, height: contentSize.height)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.widthTracksTextView = true
        textView.textContainer?.containerSize = NSSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
        
        // Configure text view appearance
        textView.backgroundColor = NSColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        textView.textColor = NSColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        textView.insertionPointColor = NSColor(red: 0.3, green: 0.7, blue: 1.0, alpha: 1.0)
        textView.selectedTextAttributes = [
            .backgroundColor: NSColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 0.3),
            .foregroundColor: NSColor.white
        ]
        
        // Set font
        updateFont()
        
        // Add text view to scroll view
        scrollView.documentView = textView
        
        // Add scroll view to main view
        view.addSubview(scrollView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupAppearance() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0).cgColor
        
        // Configure scroll view appearance
        if let scroller = scrollView.verticalScroller {
            scroller.appearance = NSAppearance(named: .darkAqua)
        }
        if let scroller = scrollView.horizontalScroller {
            scroller.appearance = NSAppearance(named: .darkAqua)
        }
    }
    
    private func updateFont() {
        let font = NSFont.monospacedSystemFont(ofSize: currentFontSize, weight: .regular)
        textView.font = font
        
        // Update line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.defaultParagraphStyle = paragraphStyle
    }
    
    private func createNewDocument() {
        currentDocument = Document()
        textView.string = """
        # Welcome to TextEdit 🧠
        
        A modern, dark-themed text editor for macOS built with Swift and AppKit.
        
        Features:
        • Native macOS dark mode integration
        • Rounded window corners
        • Syntax-aware text editing
        • Line numbers (⌘L to toggle)
        • Word wrap (⌘⇧W to toggle)
        • Zoom in/out (⌘+/⌘-)
        
        Start typing to begin editing...
        """
        
        textView.setSelectedRange(NSRange(location: textView.string.count, length: 0))
    }
    
    // MARK: - Menu Actions
    
    @objc func newDocument() {
        let alert = NSAlert()
        alert.messageText = "Create New Document"
        alert.informativeText = "Any unsaved changes will be lost. Continue?"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "New Document")
        alert.addButton(withTitle: "Cancel")
        
        if alert.runModal() == .alertFirstButtonReturn {
            createNewDocument()
        }
    }
    
    @objc func openDocument() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.plainText, .text]
        
        if openPanel.runModal() == .OK {
            guard let url = openPanel.url else { return }
            
            do {
                let content = try String(contentsOf: url, encoding: .utf8)
                textView.string = content
                currentDocument = Document(url: url)
                updateWindowTitle()
            } catch {
                showError("Failed to open file: \\(error.localizedDescription)")
            }
        }
    }
    
    @objc func saveDocument() {
        if let url = currentDocument?.url {
            saveToURL(url)
        } else {
            saveDocumentAs()
        }
    }
    
    @objc func saveDocumentAs() {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.plainText]
        savePanel.nameFieldStringValue = "Untitled.txt"
        
        if savePanel.runModal() == .OK {
            guard let url = savePanel.url else { return }
            saveToURL(url)
            currentDocument?.url = url
            updateWindowTitle()
        }
    }
    
    private func saveToURL(_ url: URL) {
        do {
            try textView.string.write(to: url, atomically: true, encoding: .utf8)
            currentDocument?.hasUnsavedChanges = false
        } catch {
            showError("Failed to save file: \\(error.localizedDescription)")
        }
    }
    
    @objc func toggleLineNumbers() {
        isShowingLineNumbers.toggle()
        
        if isShowingLineNumbers {
            let lineNumberView = LineNumberRulerView(scrollView: scrollView)
            scrollView.verticalRulerView = lineNumberView
            scrollView.hasVerticalRuler = true
            scrollView.rulersVisible = true
        } else {
            scrollView.hasVerticalRuler = false
            scrollView.rulersVisible = false
        }
    }
    
    @objc func toggleWordWrap() {
        let container = textView.textContainer!
        
        if textView.textContainer?.widthTracksTextView == true {
            // Disable word wrap
            textView.isHorizontallyResizable = true
            container.widthTracksTextView = false
            container.containerSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            scrollView.hasHorizontalScroller = true
        } else {
            // Enable word wrap
            textView.isHorizontallyResizable = false
            container.widthTracksTextView = true
            container.containerSize = NSSize(width: scrollView.contentSize.width, height: CGFloat.greatestFiniteMagnitude)
            scrollView.hasHorizontalScroller = false
        }
        
        textView.needsDisplay = true
    }
    
    @objc func zoomIn() {
        currentFontSize = min(currentFontSize + 2, 72)
        updateFont()
    }
    
    @objc func zoomOut() {
        currentFontSize = max(currentFontSize - 2, 8)
        updateFont()
    }
    
    @objc func resetZoom() {
        currentFontSize = 14.0
        updateFont()
    }
    
    private func updateWindowTitle() {
        let title = currentDocument?.url?.lastPathComponent ?? "Untitled"
        view.window?.title = title
    }
    
    private func showError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "Error"
        alert.informativeText = message
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - Supporting Classes

class Document {
    var url: URL?
    var hasUnsavedChanges = false
    
    init(url: URL? = nil) {
        self.url = url
    }
}

class LineNumberRulerView: NSRulerView {
    init(scrollView: NSScrollView) {
        super.init(scrollView: scrollView, orientation: .verticalRuler)
        setupAppearance()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        ruleThickness = 50
        // Note: NSRulerView doesn't have backgroundColor property directly
        // The appearance will be handled by the parent scroll view
    }
    
    override func drawHashMarksAndLabels(in rect: NSRect) {
        guard let textView = clientView as? NSTextView else { return }
        
        let content = textView.string
        let lines = content.components(separatedBy: .newlines)
        let font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        ]
        
        let _ = textView.visibleRange()
        let visibleRect = textView.visibleRect
        
        for (lineNumber, _) in lines.enumerated() {
            let lineString = "\\(lineNumber + 1)"
            let stringSize = lineString.size(withAttributes: attributes)
            
            let y = CGFloat(lineNumber) * (font.pointSize + 4) + visibleRect.origin.y
            let drawRect = NSRect(
                x: ruleThickness - stringSize.width - 5,
                y: y,
                width: stringSize.width,
                height: stringSize.height
            )
            
            if rect.intersects(drawRect) {
                lineString.draw(in: drawRect, withAttributes: attributes)
            }
        }
    }
}

extension NSTextView {
    func visibleRange() -> NSRange {
        let container = textContainer!
        let layoutManager = self.layoutManager!
        let visibleRect = self.visibleRect
        
        let glyphRange = layoutManager.glyphRange(forBoundingRect: visibleRect, in: container)
        return layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
    }
}