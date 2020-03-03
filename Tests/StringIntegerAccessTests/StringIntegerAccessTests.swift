import XCTest
@testable import StringIntegerAccess

final class StringIntegerAccessTests: XCTestCase {
    func testGetCharacterWithIntSubscript() {
        XCTAssertEqual("Hello, World!"[0], "H")
        XCTAssertEqual("Hello, World!"[1], "e")
        XCTAssertEqual("Hello, World!"[12], "!")
        XCTAssertEqual("Hello, World!"[11], "d")
    }
    
    
    func testGetSubstringWithIntClosedRangeSubscript() {
        XCTAssertEqual("Hello, World!"[0...1], "He")
        XCTAssertEqual("Hello, World!"[1...5], "ello,")
        XCTAssertEqual("Hello, World!"[12...12], "!")
        XCTAssertEqual("Hello, World!"[11...12], "d!")
    }
    
    
    func testGetSubstringWithIntRangeSubscript() {
        XCTAssertEqual("Hello, World!"[0..<1], "H")
        XCTAssertEqual("Hello, World!"[1..<5], "ello")
        XCTAssertEqual("Hello, World!"[12..<12], "")
        XCTAssertEqual("Hello, World!"[11..<12], "d")
        XCTAssertEqual("Hello, World!"[11..<13], "d!")
    }
    

    func testGetSubstringWithIntPartialRangeFromSubscript() {
        XCTAssertEqual("Hello, World!"[0...], "Hello, World!")
        XCTAssertEqual("Hello, World!"[1...], "ello, World!")
        XCTAssertEqual("Hello, World!"[11...], "d!")
        XCTAssertEqual("Hello, World!"[11...], "d!")
        XCTAssertEqual("Hello, World!"[12...], "!")
        XCTAssertEqual("Hello, World!"[13...], "")
    }
    
    
    func testGetSubstringWithIntPartialRangeUpToSubscript() {
        XCTAssertEqual("Hello, World!"[..<1], "H")
        XCTAssertEqual("Hello, World!"[..<5], "Hello")
        XCTAssertEqual("Hello, World!"[..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[..<13], "Hello, World!")
    }
    
    
    func testGetSubstringWithIntPartialRangeUpThroughSubscript() {
        XCTAssertEqual("Hello, World!"[...1], "He")
        XCTAssertEqual("Hello, World!"[...5], "Hello,")
        XCTAssertEqual("Hello, World!"[...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[...12], "Hello, World!")
    }
    

    static var allTests = [
        ("testGetCharacterWithIntSubscript", testGetCharacterWithIntSubscript),
        ("testGetSubstringWithIntClosedRangeSubscript", testGetSubstringWithIntClosedRangeSubscript),
        ("testGetSubstringWithIntRangeSubscript", testGetSubstringWithIntRangeSubscript),
        ("testGetSubstringWithIntPartialRangeFromSubscript", testGetSubstringWithIntPartialRangeFromSubscript),
        ("testGetSubstringWithIntPartialRangeUpThroughSubscript", testGetSubstringWithIntPartialRangeUpThroughSubscript),
    ]
}
