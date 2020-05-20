//
//  String + Integer access.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-02-27.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//



public extension StringProtocol {
    
    /// Simple sugar for `myString.index(myString.startIndex, offsetBy: characterIndex)`
    ///
    /// These are equivalent:
    /// ```
    /// myString.index(myString.startIndex, offsetBy: characterIndex)
    /// myString.index(characterIndex)
    /// ```
    ///
    /// - Parameter characterOffset: The index of a character in this string, as an offset from the first index
    /// - Returns: An index offset by `characterIndex` from the start of the string
    @inline(__always)
    func index(_ characterOffset: Int) -> Index {
        self.index(startIndex, offsetBy: characterOffset)
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: characterIndex)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: characterIndex)]
    /// myString[characterIndex]
    /// ```
    ///
    /// - Parameter characterIndex: A valid index of a character in the string. Must be greater than or equal to `0`
    ///                             and less than `count`.
    /// - Returns: The character at the given index in this string
    @inlinable
    subscript(_ characterIndex: Int) -> Element {
        self[index(characterIndex)]
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ... myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: lower) ... myString.index(myString.startIndex, offsetBy: upper)]
    /// myString[lower...upper]
    /// ```
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `0` (inclusive) and `count` (exclusive).
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: ClosedRange<Int>) -> SubSequence {
        self[ClosedRange(uncheckedBounds: (lower: index(range.lowerBound), upper: index(range.upperBound)))]
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ..< myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: lower) ..< myString.index(myString.startIndex, offsetBy: upper)]
    /// myString[lower..<upper]
    /// ```
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `0` (inclusive) and `count` (inclusive).
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: Range<Int>) -> SubSequence {
        self[Range(uncheckedBounds: (lower: index(range.lowerBound), upper: index(range.upperBound)))]
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ...]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: lower) ...]
    /// myString[lower...]
    /// ```
    ///
    /// - Parameter range: A range of a valid lower character index through the end of the string. Must be equal to or
    ///                    greater than `0`
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
        self[PartialRangeFrom(index(range.lowerBound))]
    }
    
    
    /// Simply sugar for `myString[..< myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[..< myString.index(myString.startIndex, offsetBy: upper)]
    /// myString[..<upper]
    /// ```
    ///
    /// - Parameter range: A range of the start of the string to a valid upper character index in the string. Must be
    ///                    less than or equal to than `count`.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence {
        self[PartialRangeUpTo(index(range.upperBound))]
    }
    
    
    /// Simply sugar for `myString[... myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[... myString.index(myString.startIndex, offsetBy: upper)]
    /// myString[...upper]
    /// ```
    ///
    /// - Parameter range: A range of the start of the string through a valid upper character index in the string. Must
    ///                    be less than to than `count`.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence {
        self[PartialRangeThrough(index(range.upperBound))]
    }
}



#if canImport(ObjectiveC) // NSRange seems to only exist on platforms where there's Obj-C
import Foundation



public extension StringProtocol {
    
    /// Allows you to subscript a string with a `NSRange`
    ///
    /// These are equivalent:
    /// ```
    /// let mySubstring: Substring?
    /// if range.length >= 0,
    ///     let range = Range(nsRange, in: myString)
    /// {
    ///     mySubstring = myString[range]
    /// }
    /// else {
    ///     mySubstring = nil
    /// }
    /// ```
    /// ```
    /// let mySubstring = myString[nsRange]
    /// ```
    ///
    /// - Parameter range: A range of valid indices of characters in the string. `location` must be less than `count`
    ///                    (exclusive), and `length` must be less than `count` (inclusive). If `length` is longer than
    ///                    `count`, or if `location` pushes the upper bound outside this string, or if `length` is
    ///                    negative, this returns `nil`.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    subscript(_ range: NSRange) -> SubSequence? {
        return range.length < 0
            ? nil
            : Range(range, in: self).map { self[$0] }
    }
}
#endif
