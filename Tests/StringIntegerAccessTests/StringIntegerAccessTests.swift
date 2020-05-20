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
        XCTAssertEqual("Hello, World!"[0...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[0...1], "He")
        XCTAssertEqual("Hello, World!"[1...5], "ello,")
        XCTAssertEqual("Hello, World!"[12...12], "!")
        XCTAssertEqual("Hello, World!"[11...12], "d!")
    }
    
    
    func testGetSubstringWithIntRangeSubscript() {
        XCTAssertEqual("Hello, World!"[0..<13], "Hello, World!")
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
    
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func testGetSubstringWithNSRangeSubscript() {
        XCTAssertEqual("Hello, World!"[NSRange(location: 0, length: 13)], "Hello, World!")
        XCTAssertEqual("Hello, World!"[NSRange(location: 0, length: 1)], "H")
        XCTAssertEqual("Hello, World!"[NSRange(location: 1, length: 4)], "ello")
        XCTAssertEqual("Hello, World!"[NSRange(location: 12, length: 0)], "")
        XCTAssertEqual("Hello, World!"[NSRange(location: 11, length: 1)], "d")
        XCTAssertEqual("Hello, World!"[NSRange(location: 11, length: 2)], "d!")
        XCTAssertNil("Hello, World!"[NSRange(location: 5, length: -5)])
        XCTAssertNil("Hello, World!"[NSRange(location: 11, length: 999)])
    }
    

    static var allTests = [
        ("testGetCharacterWithIntSubscript", testGetCharacterWithIntSubscript),
        ("testGetSubstringWithIntClosedRangeSubscript", testGetSubstringWithIntClosedRangeSubscript),
        ("testGetSubstringWithIntRangeSubscript", testGetSubstringWithIntRangeSubscript),
        ("testGetSubstringWithIntPartialRangeFromSubscript", testGetSubstringWithIntPartialRangeFromSubscript),
        ("testGetSubstringWithIntPartialRangeUpThroughSubscript", testGetSubstringWithIntPartialRangeUpThroughSubscript),
    ]
}
