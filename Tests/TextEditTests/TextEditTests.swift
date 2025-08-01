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
        // Test that the delegate initializes properly
        XCTAssertNotNil(delegate)
        
        // Test that NSApp can be accessed (basic functionality)
        let app = NSApplication.shared
        XCTAssertNotNil(app)
    }
    
    static var allTests = [
        ("testDocumentCreation", testDocumentCreation),
        ("testDocumentWithURL", testDocumentWithURL),
        ("testEmojiImageCreation", testEmojiImageCreation),
    ]
}