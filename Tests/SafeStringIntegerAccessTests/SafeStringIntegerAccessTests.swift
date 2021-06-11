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
    
    // MARK: - `.index(orNil:)`
    
    func testIndexOrNil() {
        XCTAssertEqual("Hello".index(orNil: 0), "Hello".startIndex)
        XCTAssertEqual("Hello".index(orNil: 1), "Hello".index("Hello".startIndex, offsetBy: 1))
        XCTAssertEqual("Hello".index(orNil: 2), "Hello".index("Hello".startIndex, offsetBy: 2))
        XCTAssertEqual("Hello".index(orNil: 3), "Hello".index("Hello".startIndex, offsetBy: 3))
        XCTAssertEqual("Hello".index(orNil: 4), "Hello".index("Hello".startIndex, offsetBy: 4))
        
        XCTAssertNil("Hello".index(orNil: -20))
        XCTAssertNil("Hello".index(orNil: -2))
        XCTAssertNil("Hello".index(orNil: -1))
        XCTAssertNil("Hello".index(orNil: 5))
        XCTAssertNil("Hello".index(orNil: 6))
        XCTAssertNil("Hello".index(orNil: 20))
    }
    
    
    // MARK: - `.index(beforeOrNil:)`
    
    func testIndexBeforeOrNil() {
        XCTAssertEqual("Hello".index(beforeOrNil: 1), "Hello".startIndex)
        XCTAssertEqual("Hello".index(beforeOrNil: 1), "Hello".index(before: "Hello".index("Hello".startIndex, offsetBy: 1)))
        XCTAssertEqual("Hello".index(beforeOrNil: 2), "Hello".index(before: "Hello".index("Hello".startIndex, offsetBy: 2)))
        XCTAssertEqual("Hello".index(beforeOrNil: 3), "Hello".index(before: "Hello".index("Hello".startIndex, offsetBy: 3)))
        XCTAssertEqual("Hello".index(beforeOrNil: 4), "Hello".index(before: "Hello".index("Hello".startIndex, offsetBy: 4)))
        XCTAssertEqual("Hello".index(beforeOrNil: 5), "Hello".index(before: "Hello".index("Hello".startIndex, offsetBy: 5)))
        
        XCTAssertNil("Hello".index(beforeOrNil: -20))
        XCTAssertNil("Hello".index(beforeOrNil: -2))
        XCTAssertNil("Hello".index(beforeOrNil: -1))
        XCTAssertNil("Hello".index(beforeOrNil: 0))
        XCTAssertNil("Hello".index(beforeOrNil: 6))
        XCTAssertNil("Hello".index(beforeOrNil: 7))
        XCTAssertNil("Hello".index(beforeOrNil: 20))
    }
    
    
    // MARK: - `.contains(index:)`
    
    func testContainsIndex() {
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
    
    
    // MARK: - `[orNil: Int]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: 5] = "!"
            XCTAssertEqual(helloWorld, "Hello! World!")
            
            helloWorld[orNil: 99] = "?"
            XCTAssertEqual(helloWorld, "Hello! World!")
        }
    }
    
    
    // MARK: - `[orNil: Int...Int]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: 7...11] = "Mars"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: -2...2] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: 2...20] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: 90...99] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
        }
    }
    
    
    // MARK: - `[orNil: Int..<Int]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: 7..<12] = "Mars"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: -2..<2] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: 2..<20] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: 90..<99] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
        }
    }
    
    
    // MARK: - `[orNil: Int...]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: 7...] = "Mars!"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: (-2)...] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: 90...] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
        }
    }
    
    
    // MARK: - `[orNil: ..<Int]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: ..<5] = "Wassup"
            XCTAssertEqual(helloWorld, "Wassup, World!")
            
            helloWorld[orNil: ..<(-2)] = "???"
            XCTAssertEqual(helloWorld, "Wassup, World!")
            
            helloWorld[orNil: ..<20] = "???"
            XCTAssertEqual(helloWorld, "Wassup, World!")
            
            helloWorld[orNil: ..<99] = "???"
            XCTAssertEqual(helloWorld, "Wassup, World!")
        }
    }
    
    
    // MARK: - `[orNil: ...Int]`
    
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
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: ...4] = "Hey"
            XCTAssertEqual(helloWorld, "Hey, World!")
            
            helloWorld[orNil: ...(-2)] = "???"
            XCTAssertEqual(helloWorld, "Hey, World!")
            
            helloWorld[orNil: ...20] = "???"
            XCTAssertEqual(helloWorld, "Hey, World!")
            
            helloWorld[orNil: ...99] = "???"
            XCTAssertEqual(helloWorld, "Hey, World!")
        }
    }
    
    
    // MARK: - `[orNil: NSRange]`
    
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
        
        XCTAssertNil("Hello 🇺🇸 America"[orNil: NSRange(location: 4, length: 12)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 0, length: 33)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 8, length: 33)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: -1, length: 8)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 8, length: 99)])
        XCTAssertNil("Faith 🛐 family 👨‍👨‍👦‍👦 and apple pie 🥧"[orNil: NSRange(location: 50, length: 99)])
        
        
        // MARK: • Mutation
        
        mutationTest { helloWorld in
            helloWorld[orNil: NSRange(location: 7, length: 5)] = "Mars"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: NSRange(location: -2, length: 2)] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: NSRange(location: 2, length: 20)] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
            
            helloWorld[orNil: NSRange(location: 90, length: 99)] = "???"
            XCTAssertEqual(helloWorld, "Hello, Mars!")
        }
    }
    
    
    // MARK: -
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    static var allTests = [
        ("testIndexOrNil", testIndexOrNil),
        ("testIndexBeforeOrNil", testIndexBeforeOrNil),
        ("testContainsIndex", testContainsIndex),
        ("testGetCharacterWithIntSubscriptOrNil", testGetCharacterWithIntSubscriptOrNil),
        ("testGetSubstringWithIntClosedRangeSubscriptOrNil", testGetSubstringWithIntClosedRangeSubscriptOrNil),
        ("testGetSubstringWithIntRangeSubscriptOrNil", testGetSubstringWithIntRangeSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeFromSubscriptOrNil", testGetSubstringWithIntPartialRangeFromSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeUpToSubscriptOrNil", testGetSubstringWithIntPartialRangeUpToSubscriptOrNil),
        ("testGetSubstringWithIntPartialRangeUpThroughSubscriptOrNil", testGetSubstringWithIntPartialRangeUpThroughSubscriptOrNil),
        ("testGetSubstringWithNSRangeSubscriptOrNil", testGetSubstringWithNSRangeSubscriptOrNil),
    ]
}



internal let helloWorld = "Hello, World!"

internal func mutationTest(do test: (inout String) -> Void) {
    var copy = helloWorld
    test(&copy)
}
