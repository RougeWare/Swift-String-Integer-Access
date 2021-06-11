//
//  String + Integer access.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-02-27.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import RangeTools



// MARK: - Converting indices

public extension StringProtocol {
    
    // MARK: index
    
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
    
    
    /// Simple sugar for `myString.index(before: myString.index(myString.startIndex, offsetBy: characterIndex))`
    ///
    /// These are equivalent:
    /// ```
    /// myString.index(before: myString.index(myString.startIndex, offsetBy: characterIndex))
    /// myString.index(before: characterIndex)
    /// ```
    ///
    /// - Parameter characterOffset: The index after a character in this string, as an offset from the first index
    /// - Returns: An index offset by `characterIndex` from the start of the string
    @inline(__always)
    func index(before characterOffset: Int) -> Index {
        self.index(before: self.index(characterOffset))
    }
    
    
    // MARK: range
    
    /// Simple sugar for `ClosedRange(uncheckedBounds: (lower: myString.index(myString.startIndex, offsetBy: integerRange.lowerBound), upper: myString.index(myString.startIndex, offsetBy: integerRange.upperBound)))`
    ///
    /// These are equivalent:
    /// ```
    /// ClosedRange(uncheckedBounds: (lower: myString.index(myString.startIndex, offsetBy: 2), upper: myString.index(myString.startIndex, offsetBy: 5)))
    /// myString.range(2...5)
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: ClosedRange<Int>) -> ClosedRange<Index> {
        .init(uncheckedBounds: (lower: index(integerRange.lowerBound), upper: index(integerRange.upperBound)))
    }
    
    
    /// Simple sugar for `Range(uncheckedBounds: (lower: myString.index(myString.startIndex, offsetBy: integerRange.lowerBound), upper: myString.index(myString.startIndex, offsetBy: integerRange.upperBound)))`
    ///
    /// These are equivalent:
    /// ```
    /// Range(uncheckedBounds: (lower: myString.index(myString.startIndex, offsetBy: 2), upper: myString.index(myString.startIndex, offsetBy: 5)))
    /// myString.range(2..<5)
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: Range<Int>) -> Range<Index> {
        .init(uncheckedBounds: (lower: index(integerRange.lowerBound), upper: index(integerRange.upperBound)))
    }
    
    
    /// Simple sugar for `PartialRangeFrom(myString.index(myString.startIndex, offsetBy: integerRange.lowerBound))`
    ///
    /// These are equivalent:
    /// ```
    /// PartialRangeFrom(myString.index(myString.startIndex, offsetBy: 2))
    /// myString.range(2...)
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: PartialRangeFrom<Int>) -> PartialRangeFrom<Index> {
        .init(index(integerRange.lowerBound))
    }
    
    
    /// Simple sugar for `PartialRangeUpTo(myString.index(myString.startIndex, offsetBy: integerRange.upperBound))`
    ///
    /// These are equivalent:
    /// ```
    /// PartialRangeUpTo(myString.index(myString.startIndex, offsetBy: 3))
    /// myString.range(..<3)
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: PartialRangeUpTo<Int>) -> PartialRangeUpTo<Index> {
        .init(index(integerRange.upperBound))
    }
    
    
    /// Simple sugar for `PartialRangeThrough(myString.index(myString.startIndex, offsetBy: integerRange.upperBound))`
    ///
    /// These are equivalent:
    /// ```
    /// PartialRangeThrough(myString.index(myString.startIndex, offsetBy: 7))
    /// myString.range(...7)
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: PartialRangeThrough<Int>) -> PartialRangeThrough<Index> {
        .init(index(integerRange.upperBound))
    }
}



// MARK: - Accessing & Mutating

public extension StringProtocol {
    
    // MARK: index
    
    mutating func replaceCharacters<IndexRange, Replacement: StringProtocol>(
        in range: IndexRange,
        with replacement: Replacement)
    where IndexRange: RangeExpression,
          IndexRange.Bound == Index
    {
        self = .init(stringLiteral: replacingCharacters(in: range, with: replacement))
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: characterIndex)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: characterIndex)] = "F"
    /// myString[characterIndex] = "F"
    /// ```
    ///
    /// - Parameter characterIndex: A valid index of a character in the string. Must be greater than or equal to `0`
    ///                             and less than `count`.
    /// - Returns: The character at the given index in this string
    @inlinable
    subscript(_ characterIndex: Int) -> Element {
        get { self[index(characterIndex)] }
        set { replaceCharacters(in: range(characterIndex...characterIndex), with: "\(newValue)") }
    }
    
    
    // MARK: range
    
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
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
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
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ...]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: 7) ...] = "World!"
    /// myString[7...] = "World!"
    /// ```
    ///
    /// - Parameter range: A range of a valid lower character index through the end of the string. Must be equal to or
    ///                    greater than `0`
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
    }
    
    
    /// Simply sugar for `myString[..< myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[..< myString.index(myString.startIndex, offsetBy: 5)] = "Hello"
    /// myString[..<5] = "Hello"
    /// ```
    ///
    /// - Parameter range: A range of the start of the string to a valid upper character index in the string. Must be
    ///                    less than or equal to than `count`.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence {
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
    }
    
    
    /// Simply sugar for `myString[... myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// These are equivalent:
    /// ```
    /// myString[... myString.index(myString.startIndex, offsetBy: 4)] = "Hello"
    /// myString[...4] = "Hello"
    /// ```
    ///
    /// - Parameter range: A range of the start of the string through a valid upper character index in the string. Must
    ///                    be less than to than `count`.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence {
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
    }
}



#if canImport(ObjectiveC) // NSRange seems to only exist on platforms where there's Obj-C
import Foundation



public extension StringProtocol {
    
    /// Creates a `Range` relative to this string out of the given `NSRange`
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string
    @inline(__always)
    func range(_ integerRange: NSRange) -> Range<Index> {
        guard let swiftRange = Range<Int>(integerRange) else {
            return startIndex..<startIndex
        }
        
        return self.range(swiftRange)
    }
    
    
    /// Allows you to subscript a string with a `NSRange`
    ///
    /// These are equivalent:
    /// ```
    /// myString[myString.index(myString.startIndex, offsetBy: nsRange.lowerBound) ..< myString.index(myString.startIndex, offsetBy: nsRange.upperBound)]
    /// myString[nsRange]
    /// ```
    ///
    /// - Parameter range: A range of valid indices of characters in the string. `location` must be less than `count`
    ///                    (exclusive), and `length` must be less than `count` (inclusive). If `length` is longer than
    ///                    `count`, or if `location` pushes the upper bound outside this string, or if `length` is
    ///                    negative, this crashes.
    /// - Returns: The characters at the given index-range in this string
    @inlinable
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    subscript(_ range: NSRange) -> SubSequence {
        get { self[self.range(range)] }
        set { replaceCharacters(in: self.range(range), with: newValue) }
    }
}
#endif



// MARK: - Conformance to RandomAccessCollection

extension String: RandomAccessCollection {}
extension Substring: RandomAccessCollection {}
