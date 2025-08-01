import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var textEditController: TextEditController!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupApplication()
        createMainWindow()
        setupMenus()
    }
    
    private func setupApplication() {
        // Set app icon to brain emoji
        if let emojiImage = createEmojiImage("🧠", size: 1024) {
            NSApp.applicationIconImage = emojiImage
        }
        
        // Force dark mode appearance
        NSApp.appearance = NSAppearance(named: .darkAqua)
    }
    
    private func createMainWindow() {
        // Create main window with dark styling
        let contentRect = NSRect(x: 200, y: 200, width: 1200, height: 800)
        
        window = NSWindow(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        // Configure window for dark mode
        window.titlebarAppearsTransparent = true
        window.backgroundColor = NSColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        window.title = "TextEdit"
        window.center()
        
        // Set window appearance
        window.appearance = NSAppearance(named: .darkAqua)
        
        // Make window rounded
        window.contentView?.wantsLayer = true
        window.contentView?.layer?.cornerRadius = 12
        window.contentView?.layer?.masksToBounds = true
        
        // Add traffic light button styling
        if let titlebarView = window.standardWindowButton(.closeButton)?.superview {
            titlebarView.wantsLayer = true
            titlebarView.layer?.backgroundColor = NSColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.0).cgColor
        }
        
        // Create and set content controller
        textEditController = TextEditController()
        window.contentViewController = textEditController
        
        window.makeKeyAndOrderFront(nil)
    }
    
    private func setupMenus() {
        let mainMenu = NSMenu()
        
        // App menu
        let appMenuItem = NSMenuItem()
        let appMenu = NSMenu()
        appMenu.addItem(NSMenuItem(title: "About TextEdit", action: #selector(showAbout), keyEquivalent: ""))
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(NSMenuItem(title: "Hide TextEdit", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h"))
        let hideOthersItem = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h")
        hideOthersItem.keyEquivalentModifierMask = [.command, .option]
        appMenu.addItem(hideOthersItem)
        appMenu.addItem(NSMenuItem(title: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: ""))
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(NSMenuItem(title: "Quit TextEdit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        appMenuItem.submenu = appMenu
        mainMenu.addItem(appMenuItem)
        
        // File menu
        let fileMenuItem = NSMenuItem()
        let fileMenu = NSMenu(title: "File")
        fileMenu.addItem(NSMenuItem(title: "New", action: #selector(textEditController.newDocument), keyEquivalent: "n"))
        fileMenu.addItem(NSMenuItem(title: "Open...", action: #selector(textEditController.openDocument), keyEquivalent: "o"))
        fileMenu.addItem(NSMenuItem.separator())
        fileMenu.addItem(NSMenuItem(title: "Save", action: #selector(textEditController.saveDocument), keyEquivalent: "s"))
        fileMenu.addItem(NSMenuItem(title: "Save As...", action: #selector(textEditController.saveDocumentAs), keyEquivalent: "S"))
        fileMenu.addItem(NSMenuItem.separator())
        fileMenu.addItem(NSMenuItem(title: "Close", action: #selector(NSWindow.performClose(_:)), keyEquivalent: "w"))
        fileMenuItem.submenu = fileMenu
        mainMenu.addItem(fileMenuItem)
        
        // Edit menu
        let editMenuItem = NSMenuItem()
        let editMenu = NSMenu(title: "Edit")
        editMenu.addItem(NSMenuItem(title: "Undo", action: Selector(("undo:")), keyEquivalent: "z"))
        editMenu.addItem(NSMenuItem(title: "Redo", action: Selector(("redo:")), keyEquivalent: "Z"))
        editMenu.addItem(NSMenuItem.separator())
        editMenu.addItem(NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x"))
        editMenu.addItem(NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c"))
        editMenu.addItem(NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v"))
        editMenu.addItem(NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a"))
        editMenuItem.submenu = editMenu
        mainMenu.addItem(editMenuItem)
        
        // View menu
        let viewMenuItem = NSMenuItem()
        let viewMenu = NSMenu(title: "View")
        viewMenu.addItem(NSMenuItem(title: "Show Line Numbers", action: #selector(textEditController.toggleLineNumbers), keyEquivalent: "l"))
        viewMenu.addItem(NSMenuItem(title: "Word Wrap", action: #selector(textEditController.toggleWordWrap), keyEquivalent: "W"))
        viewMenu.addItem(NSMenuItem.separator())
        viewMenu.addItem(NSMenuItem(title: "Zoom In", action: #selector(textEditController.zoomIn), keyEquivalent: "+"))
        viewMenu.addItem(NSMenuItem(title: "Zoom Out", action: #selector(textEditController.zoomOut), keyEquivalent: "-"))
        viewMenu.addItem(NSMenuItem(title: "Reset Zoom", action: #selector(textEditController.resetZoom), keyEquivalent: "0"))
        viewMenuItem.submenu = viewMenu
        mainMenu.addItem(viewMenuItem)
        
        NSApp.mainMenu = mainMenu
    }
    
    @objc private func showAbout() {
        let alert = NSAlert()
        alert.messageText = "TextEdit"
        alert.informativeText = "A modern dark mode text editor for macOS\n\n🧠 Built with Swift and AppKit\nVersion 1.0"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    private func createEmojiImage(_ emoji: String, size: CGFloat) -> NSImage? {
        let font = NSFont.systemFont(ofSize: size * 0.8)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.textColor
        ]
        
        let attributedString = NSAttributedString(string: emoji, attributes: attributes)
        let stringSize = attributedString.size()
        
        let image = NSImage(size: NSSize(width: size, height: size))
        image.lockFocus()
        
        let drawingRect = NSRect(
            x: (size - stringSize.width) / 2,
            y: (size - stringSize.height) / 2,
            width: stringSize.width,
            height: stringSize.height
        )
        
        attributedString.draw(in: drawingRect)
        image.unlockFocus()
        
        return image
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        // Cleanup if needed
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

// Helper extension for method chaining
extension NSObject {
    @discardableResult
    func also(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}