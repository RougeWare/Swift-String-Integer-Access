//
//  SafeStringIntegerAccessTests.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-05-21.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import XCTest
import SafeStringIntegerAccess



final class SafeStringIntegerAccessTests: XCTestCase {
    
    func testContainsIndexOrNil() {
        XCTAssertTrue("Hello".contains(index: 0))
        XCTAssertTrue("Hello".contains(index: 1))
        XCTAssertTrue("Hello".contains(index: 2))
        XCTAssertTrue("Hello".contains(index: 3))
        XCTAssertTrue("Hello".contains(index: 4))
        
        XCTAssertFalse("Hello".contains(index:  5))
        XCTAssertFalse("Hello".contains(index:  99))
        XCTAssertFalse("Hello".contains(index: -1))
        XCTAssertFalse("Hello".contains(index: -99))
    }
    
    
    func testGetCharacterWithIntSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: 0], "Hello, World!"[0]) // This just checks that importing `SafeStringIntegerAccess` also implicitly imports `stringIntegerAccess`
        XCTAssertEqual("Hello, World!"[orNil: 0], "H")
        XCTAssertEqual("Hello, World!"[orNil: 1], "e")
        XCTAssertEqual("Hello, World!"[orNil: 12], "!")
        XCTAssertEqual("Hello, World!"[orNil: 11], "d")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 6], "🇺🇸")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 15], "👨‍👨‍👦‍👦")
        
        XCTAssertNil("Hello, World!"[orNil: -1])
        XCTAssertNil("Hello, World!"[orNil: 13])
        XCTAssertNil("Hello, World!"[orNil: -99])
        XCTAssertNil("Hello, World!"[orNil: 99])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: 15])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 32])
    }
    
    
    func testGetSubstringWithIntClosedRangeSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: 0...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[orNil: 0...1], "He")
        XCTAssertEqual("Hello, World!"[orNil: 1...5], "ello,")
        XCTAssertEqual("Hello, World!"[orNil: 12...12], "!")
        XCTAssertEqual("Hello, World!"[orNil: 11...12], "d!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 3...9], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 0...14], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8...25], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0...31], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        XCTAssertNil("Hello, World!"[orNil: -1...12])
        XCTAssertNil("Hello, World!"[orNil: 0...13])
        XCTAssertNil("Hello, World!"[orNil: -99...12])
        XCTAssertNil("Hello, World!"[orNil: 0...99])
        XCTAssertNil("Hello, World!"[orNil: -99...99])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: 4...15])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0...32])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8...32])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: -1...8])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8...99])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 50...99])
    }
    
    
    func testGetSubstringWithIntRangeSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: 0..<13], "Hello, World!")
        XCTAssertEqual("Hello, World!"[orNil: 0..<1], "H")
        XCTAssertEqual("Hello, World!"[orNil: 1..<5], "ello")
        XCTAssertEqual("Hello, World!"[orNil: 5..<5], "")
        XCTAssertEqual("Hello, World!"[orNil: 12..<12], "")
        XCTAssertEqual("Hello, World!"[orNil: 11..<12], "d")
        XCTAssertEqual("Hello, World!"[orNil: 11..<13], "d!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 3..<10], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 0..<15], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8..<26], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0..<32], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        XCTAssertNil("Hello, World!"[orNil: -1..<13])
        XCTAssertNil("Hello, World!"[orNil: 0..<14])
        XCTAssertNil("Hello, World!"[orNil: -99..<12])
        XCTAssertNil("Hello, World!"[orNil: 0..<99])
        XCTAssertNil("Hello, World!"[orNil: -99..<99])
        XCTAssertNil("Hello, World!"[orNil: -10 ..< -5])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: 4..<16])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0..<33])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8..<33])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: -1..<8])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8..<99])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 50..<99])
    }
    
    
    func testGetSubstringWithIntPartialRangeFromSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: 0...], "Hello, World!")
        XCTAssertEqual("Hello, World!"[orNil: 1...], "ello, World!")
        XCTAssertEqual("Hello, World!"[orNil: 11...], "d!")
        XCTAssertEqual("Hello, World!"[orNil: 11...], "Hello, World!"[11...])
        XCTAssertEqual("Hello, World!"[orNil: 12...], "!")
        XCTAssertEqual("Hello, World!"[orNil: 13...], "")
        XCTAssertEqual("Hello, World!"[orNil: 13...], "Hello, World!"[13...])
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 3...], "lo 🇺🇸 America")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: 0...], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8...], "family 👨‍👨‍👦‍👦 and apple pie 🥧")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0...], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        XCTAssertNil("Hello, World!"[orNil: ( 99)...])
        XCTAssertNil("Hello, World!"[orNil: ( 14)...])
        XCTAssertNil("Hello, World!"[orNil: (-1 )...])
        XCTAssertNil("Hello, World!"[orNil: (-99)...])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: 16...])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: (33)...])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: (-1)...])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: (50)...])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: (99)...])
    }
    
    
    func testGetSubstringWithIntPartialRangeUpToSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: ..<1], "H")
        XCTAssertEqual("Hello, World!"[orNil: ..<5], "Hello")
        XCTAssertEqual("Hello, World!"[orNil: ..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[orNil: ..<12], "Hello, World")
        XCTAssertEqual("Hello, World!"[orNil: ..<13], "Hello, World!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: ..<10], "Hello 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: ..<15], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<26], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<32], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        XCTAssertNil("Hello, World!"[orNil: ..<( 99)])
        XCTAssertNil("Hello, World!"[orNil: ..<( 14)])
        XCTAssertNil("Hello, World!"[orNil: ..<(-1 )])
        XCTAssertNil("Hello, World!"[orNil: ..<(-99)])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: ..<16])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<( 33)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<(-1 )])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<( 99)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ..<(-99)])
    }
    
    
    func testGetSubstringWithIntPartialRangeUpThroughSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: ...1], "He")
        XCTAssertEqual("Hello, World!"[orNil: ...5], "Hello,")
        XCTAssertEqual("Hello, World!"[orNil: ...12], "Hello, World!")
        XCTAssertEqual("Hello, World!"[orNil: ...12], "Hello, World!")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: ...9], "Hello 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: ...14], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...25], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...31], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        XCTAssertNil("Hello, World!"[orNil: ...( 99)])
        XCTAssertNil("Hello, World!"[orNil: ...( 13)])
        XCTAssertNil("Hello, World!"[orNil: ...(-1 )])
        XCTAssertNil("Hello, World!"[orNil: ...(-99)])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: ...15])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...( 32)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...(-1 )])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...( 99)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: ...(-99)])
    }
    
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func testGetSubstringWithNSRangeSubscriptOrNil() {
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 0, length: 13)], "Hello, World!")
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 0, length: 1)], "H")
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 1, length: 4)], "ello")
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 12, length: 0)], "")
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 11, length: 1)], "d")
        XCTAssertEqual("Hello, World!"[orNil: NSRange(location: 11, length: 2)], "d!")
        XCTAssertEqual("Hello, World!"[orNil: NSRange()], "")
        
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: NSRange(location: 3, length: 7)], "lo 🇺🇸 Am")
        XCTAssertEqual("Hello 🇺🇸 America"[orNil: NSRange(location: 0, length: 15)], "Hello 🇺🇸 America")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 8, length: 18)], "family 👨‍👨‍👦‍👦 and apple")
        XCTAssertEqual("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 0, length: 32)], "Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧")
        
        
        XCTAssertNil("Hello, World!"[orNil: NSRange(location: 5, length: -5)])
        XCTAssertNil("Hello, World!"[orNil: NSRange(location: 11, length: 999)])
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: 4..<16])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 0..<33])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8..<33])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: -1..<8])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 8..<99])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: 50..<99])
    }
    
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    static var allTests = [
        ("testContainsIndexOrNil", testContainsIndexOrNil),
        ("testGetCharacterWithIntSubscriptOrNil", testGetCharacterWithIntSubscriptOrNil),
        ("testGetSubstringWithIntClosedRangeSubscriptOrNil", testGetSubstringWithIntClosedRangeSubscriptOrNil),
        ("testGetSubstringWithIntRangeSubscriptOrNil", testGetSubstringWithIntRangeSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeFromSubscriptOrNil", testGetSubstringWithIntPartialRangeFromSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeUpToSubscriptOrNil", testGetSubstringWithIntPartialRangeUpToSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeUpThroughSubscriptOrNil", testGetSubstringWithIntPartialRangeUpThroughSubscriptOrNil),
        ("testGetSubstringWithNSRangeSubscriptOrNil", testGetSubstringWithNSRangeSubscriptOrNil),
    ]
}
