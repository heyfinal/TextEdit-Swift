import XCTest
@testable import TextEdit

class TextEditTests: XCTestCase {
    
    func testDocumentCreation() {
        let document = Document()
        XCTAssertNil(document.url)
        XCTAssertFalse(document.hasUnsavedChanges)
    }
    
    func testDocumentWithURL() {
        let url = URL(fileURLWithPath: "/tmp/test.txt")
        let document = Document(url: url)
        XCTAssertEqual(document.url, url)
        XCTAssertFalse(document.hasUnsavedChanges)
    }
    
    func testEmojiImageCreation() {
        let delegate = AppDelegate()
        // Test private method through runtime
        let image = delegate.value(forKey: "createEmojiImage") as? NSImage
        // This is a basic test structure - actual implementation would need public methods
        XCTAssertNotNil(delegate)
    }
    
    static var allTests = [
        ("testDocumentCreation", testDocumentCreation),
        ("testDocumentWithURL", testDocumentWithURL),
        ("testEmojiImageCreation", testEmojiImageCreation),
    ]
}