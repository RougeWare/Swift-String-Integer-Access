//
//  StringIntegerAccess + SafeCollectionAccess.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import SafeCollectionAccess
import StringIntegerAccess



public extension StringProtocol
    where Self: RandomAccessCollection
{
    /// Determines whether this collection has an item at the given character index
    ///
    /// - Parameter characterIndex: An index which might be in this string
    /// - Returns: `true` iff `index` points to a character that’s in this string
    func contains(index characterIndex: Int) -> Bool {
        self.index(orNil: characterIndex).map(self.contains(index:)) ?? false
    }
    
    
    /// A non-crashing form of `myString.index(characterOffset)`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString.index(7)
    /// myString.index(orNil: 7)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString.index(42) // crashes
    /// myString.index(orNil: 42) // returns nil
    /// ```
    ///
    /// - Parameter characterOffset: The index of a character in this string, as an offset from the first index
    /// - Returns: An index offset by `characterIndex` from the start of the string, or `nil` if that's outside this string
    @inlinable
    func index(orNil characterOffset: Int) -> Index? {
        guard
            characterOffset >= 0,
            characterOffset < count
            else
        {
            return nil
        }
        
        let prospective = self.index(startIndex, offsetBy: characterOffset)
        
        return self.indices.contains(prospective)
            ? prospective
            : nil
    }
    
    
    /// A non-crashing form of `myString.index(beforeOrNil: characterIndex)`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString.index(before: myString.index(myString.startIndex, offsetBy: 2))
    /// myString.index(beforeOrNil: 2)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString.index(before: 42) // crashes
    /// myString.index(beforeOrNil: 42) // returns nil
    /// ```
    ///
    /// - Parameter characterOffset: The index after a character in this string, as an offset from the first index
    /// - Returns: An index offset by `characterIndex` from the start of the string, or `nil` if the index is out of the string
    @inlinable
    func index(beforeOrNil characterOffset: Int) -> Index? {
        guard
            characterOffset > 0,
            characterOffset <= count
            else
        {
            // Looking for the index before the given one, so less than the min index (0) is invalid, as is greater
            // than greatest index + 1 (count)
            return nil
        }
        
        let prospective = self.index(before: self.index(startIndex, offsetBy: characterOffset))
        
        return self.indices.contains(prospective) // Sanity check
            ? prospective
            : nil
    }
    
    
    /// A non-crashing form of `myString[characterIndex]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[orNil: myString.index(myString.startIndex, offsetBy: 2)]
    /// myString[orNil: 2]
    /// ```
    ///
    /// However, this version doesn't require as much boilerplate and won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[myString.index(myString.startIndex, offsetBy: 42)] // crashes
    /// myString.index(orNil: 42).compactMap { myString[orNil: $0] } // nil
    /// myString[42] // crashes
    /// myString[orNil: 42] // returns nil
    /// ```
    ///
    /// - Parameter characterIndex: A valid index of a character in the string. Must be greater than or equal to `0`
    ///                             and less than `count`.
    /// - Returns: The character at the given index in this string, or `nil` if the index is out of the string
    @inlinable
    subscript(orNil characterIndex: Int) -> Element? {
        guard let index = self.index(orNil: characterIndex) else {
            return nil
        }
        
        return self[orNil: index]
    }
    
    
    /// A non-crashing form of `myString[lower...upper]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[myString.index(myString.startIndex, offsetBy: 3) ... myString.index(myString.startIndex, offsetBy: 4)]
    /// myString[3...4]
    /// myString[orNil: myString.index(myString.startIndex, offsetBy: 3) ... myString.index(myString.startIndex, offsetBy: 4)]
    /// myString[orNil: 3...4]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[myString.index(myString.startIndex, offsetBy: 7) ... myString.index(myString.startIndex, offsetBy: 42)] // crashes
    /// myString[7...42] // crashes
    /// myString[orNil: 7...42] // returns nil
    /// ```
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `0` (inclusive) and `count` (exclusive).
    /// - Returns: The characters at the given index-range in this string, or `nil` if either index is out of the string
    @inlinable
    subscript(orNil range: ClosedRange<Int>) -> SubSequence? {
        guard
            let lowerIndex = self.index(orNil: range.lowerBound),
            let upperIndex = self.index(orNil: range.upperBound)
            else
        {
            return nil
        }
        
        return self[orNil: lowerIndex ... upperIndex]
    }
    
    
    /// A non-crashing form of `myString[lower..<upper]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[myString.index(myString.startIndex, offsetBy: 3) ..< myString.index(myString.startIndex, offsetBy: 5)]
    /// myString[3..<5]
    /// myString[orNil: myString.index(myString.startIndex, offsetBy: 3) ..< myString.index(myString.startIndex, offsetBy: 5)]
    /// myString[orNil: 3..<5]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[myString.index(myString.startIndex, offsetBy: 7) ..< myString.index(myString.startIndex, offsetBy: 42)] // crashes
    /// myString[7..<42] // crashes
    /// myString[orNil: 7..<42] // returns nil
    /// ```
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `0` (inclusive) and `count` (inclusive).
    /// - Returns: The characters at the given index-range in this string, or `nil` if either index is out of the string
    @inlinable
    subscript(orNil range: Range<Int>) -> SubSequence? {
        
        guard !range.isEmpty else {
            // An empty range is the same as a character accessor at the lower bound, but returning a single-character
            // Substring instead of a Character
            
            guard let lowerIndex = self.index(orNil: range.lowerBound) else {
                // ... unless it's completely out of range, then just return `nil`
                return nil
            }
            
            return self[orNil: lowerIndex ..< lowerIndex]
        }
        
        // Now that the single-character case is out of the way, get the lower and before-upper indices
        
        guard
            let lowerIndex = self.index(orNil: range.lowerBound),
            let beforeUpperIndex = self.index(beforeOrNil: range.upperBound)
            else
        {
            return nil
        }
        
        // self[m ..< n] == self[m ... n-1]
        return self[orNil: lowerIndex ... beforeUpperIndex]
    }
    
    
    /// A non-crashing form of `myString[lower...]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[3...]
    /// myString[orNil: 3...]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[myString.index(myString.startIndex, offsetBy: 7) ...] // crashes
    /// myString[7...] // crashes
    /// myString[orNil: 7...] // returns nil
    /// ```
    ///
    /// - Parameter range: A range of a valid lower character index through the end of the string. Must be equal to or
    ///                    greater than `0`
    /// - Returns: The characters at the given index-range in this string, or `nil` if the index is out of the string
    @inlinable
    subscript(orNil range: PartialRangeFrom<Int>) -> SubSequence? {
        
        guard range.lowerBound != count else {
            return self[endIndex...]
        }
        
        guard let lowerIndex = self.index(orNil: range.lowerBound) else {
            return nil
        }
        
        return self[orNil: lowerIndex...]
    }
    
    
    /// A non-crashing form of `myString[..<lower]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[..<5]
    /// myString[orNil: ..<5]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[..<myString.index(myString.startIndex, offsetBy: 42)] // crashes
    /// myString[..<42] // crashes
    /// myString[orNil: ..<42] // returns nil
    /// ```
    ///
    /// - Parameter range: A range of the start of the string to a valid upper character index in the string. Must be
    ///                    less than or equal to than `count`.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the index is out of the string
    @inlinable
    subscript(orNil range: PartialRangeUpTo<Int>) -> SubSequence? {
        
        guard range.upperBound != count else {
            // self[orNil: ..<self.count] == self[..<self.count] == self[...]
            return self[...]
        }
        
        guard let upperIndex = self.index(orNil: range.upperBound) else {
            return nil
        }
        
        return self[orNil: ..<upperIndex]
    }
    
    
    /// A non-crashing form of `myString[..<lower]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[...4]
    /// myString[orNil: ...4]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[...myString.index(myString.startIndex, offsetBy: 42)] // crashes
    /// myString[...42] // crashes
    /// myString[orNil: ...42] // returns nil
    /// ```
    ///
    /// - Parameter range: A range of the start of the string through a valid upper character index in the string. Must
    ///                    be less than to than `count`.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the index is out of the string
    @inlinable
    subscript(orNil range: PartialRangeThrough<Int>) -> SubSequence? {
        guard let upperIndex = self.index(orNil: range.upperBound) else {
            return nil
        }
        
        return self[orNil: ...upperIndex]
    }
}



#if canImport(ObjectiveC) // NSRange seems to only exist on platforms where there's Obj-C
import Foundation



public extension StringProtocol where Self: RandomAccessCollection {
    
    /// A non-crashing form of `myString[NSRange(location: lowerCharacterIndex, length: numberOfCharacters)]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[NSRange(location: 3, length: 2)]
    /// myString[orNil: NSRange(location: 3, length: 2)]
    /// ```
    ///
    /// However, this version won't crash:
    /// ```
    /// let myString = ";)"
    /// myString[NSRange(location: 42, length: 7)] // crashes
    /// myString[orNil: NSRange(location: 42, length: 7)] // nil
    /// ```
    ///
    /// - Parameter range: A range of valid indices of characters in the string. `location` must be less than `count`
    ///                    (exclusive), and `length` must be less than `count` (inclusive). If `length` is longer than
    ///                    `count`, or if `location` pushes the upper bound outside this string, or if `length` is
    ///                    negative, this returns `nil`.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the index is out of the string
    @inlinable
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    subscript(orNil range: NSRange) -> SubSequence? {
        guard
            range.length >= 0,
            contains(index: range.lowerBound),
            contains(index: range.upperBound)
                || range.upperBound == count
            else
        {
            return nil
        }
        
        return self[range]
    }
}
#endif
