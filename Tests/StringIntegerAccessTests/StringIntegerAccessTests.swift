import XCTest
import StringIntegerAccess



final class StringIntegerAccessTests: XCTestCase {
    func testGetCharacterWithIntSubscript() {
        XCTAssertEqual("Hello, World!"[0], "H")
        XCTAssertEqual("Hello, World!"[1], "e")
        XCTAssertEqual("Hello, World!"[12], "!")
        XCTAssertEqual("Hello, World!"[11], "d")
        
        XCTAssertEqual("Hello 🇺🇸 America"[6], "🇺🇸")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[15], "👨‍👨‍👦‍👦")
    }
    
    
    func testGetSubstringWithIntClosedRangeSubscript() {
        XCTAssertEqual("Hello, World!"[0...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[0...1], "He")
        XCTAssertEqual("Hello, World!"[1...5], "ello,")
        XCTAssertEqual("Hello, World!"[12...12], "!")
        XCTAssertEqual("Hello, World!"[11...12], "d!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[3...9], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[0...14], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[8...25], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[0...31], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    
    
    func testGetSubstringWithIntRangeSubscript() {
        XCTAssertEqual("Hello, World!"[0..<13], "Hello, World!")
        XCTAssertEqual("Hello, World!"[0..<1], "H")
        XCTAssertEqual("Hello, World!"[1..<5], "ello")
        XCTAssertEqual("Hello, World!"[12..<12], "")
        XCTAssertEqual("Hello, World!"[11..<12], "d")
        XCTAssertEqual("Hello, World!"[11..<13], "d!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[3..<10], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[0..<15], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[8..<26], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[0..<32], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    

    func testGetSubstringWithIntPartialRangeFromSubscript() {
        XCTAssertEqual("Hello, World!"[0...], "Hello, World!")
        XCTAssertEqual("Hello, World!"[1...], "ello, World!")
        XCTAssertEqual("Hello, World!"[11...], "d!")
        XCTAssertEqual("Hello, World!"[11...], "d!")
        XCTAssertEqual("Hello, World!"[12...], "!")
        XCTAssertEqual("Hello, World!"[13...], "")
        
        XCTAssertEqual("Hello 🇺🇸 America"[3...], "lo 🇺🇸 America")
        XCTAssertEqual("Hello 🇺🇸 America"[0...], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[8...], "family 👨‍👨‍👦‍👦 and apple pie 🥧")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[0...], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    
    
    func testGetSubstringWithIntPartialRangeUpToSubscript() {
        XCTAssertEqual("Hello, World!"[..<1], "H")
        XCTAssertEqual("Hello, World!"[..<5], "Hello")
        XCTAssertEqual("Hello, World!"[..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[..<13], "Hello, World!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[..<10], "Hello 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[..<15], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[..<26], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[..<32], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    
    
    func testGetSubstringWithIntPartialRangeUpThroughSubscript() {
        XCTAssertEqual("Hello, World!"[...1], "He")
        XCTAssertEqual("Hello, World!"[...5], "Hello,")
        XCTAssertEqual("Hello, World!"[...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[...12], "Hello, World!")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[...25], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[...31], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func testGetSubstringWithNSRangeSubscript() {
        XCTAssertEqual("Hello, World!"[NSRange(location: 0, length: 13)], "Hello, World!")
        XCTAssertEqual("Hello, World!"[NSRange(location: 0, length: 1)], "H")
        XCTAssertEqual("Hello, World!"[NSRange(location: 1, length: 4)], "ello")
        XCTAssertEqual("Hello, World!"[NSRange(location: 12, length: 0)], "")
        XCTAssertEqual("Hello, World!"[NSRange(location: 11, length: 1)], "d")
        XCTAssertEqual("Hello, World!"[NSRange(location: 11, length: 2)], "d!")
        XCTAssertEqual("Hello, World!"[NSRange()], "")
        
        XCTAssertEqual("Hello 🇺🇸 America"[NSRange(location: 3, length: 7)], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[NSRange(location: 0, length: 15)], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[NSRange(location: 8, length: 18)], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[NSRange(location: 0, length: 32)], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
    }
    

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    static var allTests = [
        ("testGetCharacterWithIntSubscript", testGetCharacterWithIntSubscript),
        ("testGetSubstringWithIntClosedRangeSubscript", testGetSubstringWithIntClosedRangeSubscript),
        ("testGetSubstringWithIntRangeSubscript", testGetSubstringWithIntRangeSubscript),
        ("testGetSubstringWithIntPartialRangeFromSubscript", testGetSubstringWithIntPartialRangeFromSubscript),
        ("testGetSubstringWithIntPartialRangeUpToSubscript", testGetSubstringWithIntPartialRangeUpToSubscript),
        ("testGetSubstringWithIntPartialRangeUpThroughSubscript", testGetSubstringWithIntPartialRangeUpThroughSubscript),
        ("testGetSubstringWithNSRangeSubscript", testGetSubstringWithNSRangeSubscript),
    ]
}
