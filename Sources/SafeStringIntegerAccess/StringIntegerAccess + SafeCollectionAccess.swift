//
//  StringIntegerAccess + SafeCollectionAccess.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import SafeCollectionAccess
import StringIntegerAccess
import RangeTools



// MARK: - Querying

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
}



// MARK: - Converting indices

public extension StringProtocol
where Self: RandomAccessCollection
{
    // MARK: Single index
    
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
    func index(orNil characterOffset: Int, allowEndIndex: Bool = false) -> Index? {
        guard
            characterOffset >= 0,
            allowEndIndex ? (characterOffset <= count) : (characterOffset < count)
        else
        {
            return nil
        }
        
        let prospective = self.index(startIndex, offsetBy: characterOffset)
        
        if allowEndIndex {
            return self.endIndex == prospective
                || self.indices.contains(prospective)
                ? prospective
                : nil
        }
        else {
            return self.indices.contains(prospective)
                ? prospective
                : nil
        }
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
    
    
    // MARK: Index range
    
    /// A generic implementation of the below `range(orNil:)` functions
    @inline(__always)
    fileprivate func _range<IntRange, IndexRange>(orNil integerRange: IntRange) -> IndexRange?
    where IntRange: RangeWithLowerAndUpperBound,
          IntRange.Bound == Int,
          IndexRange : RangeWhichCanBeInitializedWithBothLowerAndUpperBounds,
          IndexRange.Bound == Index
    {
        guard let lower = index(orNil: integerRange.lowerBound),
              let upper = index(orNil: integerRange.upperBound,
                                allowEndIndex: !IntRange.upperBoundIsInclusive)
        else {
            return nil
        }
        
        return .init(lowerBound: lower, upperBound: upper)
    }
    
    
    /// A generic implementation of the below `range(orNil:)` functions
    @inline(__always)
    fileprivate func _range<IntRange, IndexRange>(orNil integerRange: IntRange) -> IndexRange?
    where IntRange: RangeWithLowerBound,
          IntRange.Bound == Int,
          IndexRange : RangeWhichCanBeInitializedWithOnlyLowerBound,
          IndexRange.Bound == Index
    {
        index(orNil: integerRange.lowerBound,
              allowEndIndex: true) // Any range with only a lower index, AFAIK, can place that lower index at the end index for an empty slice. Might have to change this if there's ever a range with an exclusive lower bound
            .map(IndexRange.init)
    }
    
    
    /// A generic implementation of the below `range(orNil:)` functions
    @inline(__always)
    fileprivate func _range<IntRange, IndexRange>(orNil integerRange: IntRange) -> IndexRange?
    where IntRange: RangeWithUpperBound,
          IntRange.Bound == Int,
          IndexRange : RangeWhichCanBeInitializedWithOnlyUpperBound,
          IndexRange.Bound == Index
    {
        index(orNil: integerRange.upperBound,
              allowEndIndex: !IntRange.upperBoundIsInclusive)
            .map(IndexRange.init)
    }
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(2...5)
    /// myString.range(orNil: 2...5)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(2...999) // Crashes
    /// myString.range(orNil: 2...999) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: ClosedRange<Int>) -> ClosedRange<Index>? { _range(orNil: integerRange) }
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(2..<6)
    /// myString.range(orNil: 2..<6)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(2..<999) // Crashes
    /// myString.range(orNil: 2..<999) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: Range<Int>) -> Range<Index>? { _range(orNil: integerRange) }
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(7...)
    /// myString.range(orNil: 7...)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(999...) // Crashes
    /// myString.range(orNil: 999...) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: PartialRangeFrom<Int>) -> PartialRangeFrom<Index>? { _range(orNil: integerRange) }
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(..<5)
    /// myString.range(orNil: ..<5)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(..<999) // Crashes
    /// myString.range(orNil: ..<999) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: PartialRangeUpTo<Int>) -> PartialRangeUpTo<Index>? { _range(orNil: integerRange) }
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(...5)
    /// myString.range(orNil: ...5)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(...999) // Crashes
    /// myString.range(orNil: ...999) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: PartialRangeThrough<Int>) -> PartialRangeThrough<Index>? { _range(orNil: integerRange) }
}



// MARK: - Access & Mutation

public extension StringProtocol
where Self: RandomAccessCollection
{
    // MARK: Single index
    
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
        self.index(orNil: characterIndex).flatMap { self[$0] }
    }
    
    
    /// A non-crashing form of `myString[characterIndex]`
    ///
    /// These are equivalent:
    /// ```
    /// let myString = "Hello, World!"
    /// myString[orNil: myString.index(myString.startIndex, offsetBy: 9)] = "e"
    /// myString[orNil: 9] = "e"
    /// ```
    ///
    /// However, this version doesn't require as much boilerplate and won't crash:
    /// ```
    /// let myString = "Hi"
    /// myString[myString.index(myString.startIndex, offsetBy: 42)] = "e" // crashes
    /// myString[42] = "e" // crashes
    /// myString[orNil: 42] = "e" // Does nothing
    /// ```
    ///
    /// - Parameter characterIndex: A valid index of a character in the string. Must be greater than or equal to `0`
    ///                             and less than `count`.
    /// - Returns: The character at the given index in this string, or `nil` if the index is out of the string
    @inlinable
    subscript(orNil characterIndex: Int) -> Element?
    where Self: RangeReplaceableCollection
    {
        get { self.index(orNil: characterIndex).flatMap { self[$0] } }
        set { self.index(orNil: characterIndex).flatMap { index in
            if let newValue = newValue {
                self[characterIndex] = newValue
            }
            else {
                self.remove(at: index)
            }
        } }
    }
    
    
    // MARK: Index range
    
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
        self.range(orNil: range).flatMap { self[orNil: $0] }
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
    subscript(orNil range: ClosedRange<Int>) -> SubSequence?
    where Self: RangeReplaceableCollection
    {
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
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
        self.range(orNil: range).flatMap { self[orNil: $0] }
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
    subscript(orNil range: Range<Int>) -> SubSequence?
    where Self: RangeReplaceableCollection
    {
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
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
        self.range(orNil: range).flatMap { self[orNil: $0] }
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
    subscript(orNil range: PartialRangeFrom<Int>) -> SubSequence?
    where Self: RangeReplaceableCollection
    {
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
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
        self.range(orNil: range).flatMap { self[orNil: $0] }
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
    subscript(orNil range: PartialRangeUpTo<Int>) -> SubSequence?
    where Self: RangeReplaceableCollection
    {
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
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
        self.range(orNil: range).flatMap { self[orNil: $0] }
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
    subscript(orNil range: PartialRangeThrough<Int>) -> SubSequence?
    where Self: RangeReplaceableCollection
    {
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
    }
}



#if canImport(ObjectiveC) // NSRange seems to only exist on platforms where there's Obj-C
import Foundation



public extension StringProtocol
where Self: RandomAccessCollection
{
    
    
    /// A non-crashing form of `myString.range(integerRange)`
    ///
    /// These are equivalent:
    /// ```swift
    /// let myString = "Hello, World!"
    /// myString.range(...5)
    /// myString.range(orNil: ...5)
    /// ```
    ///
    /// However, this version won't crash:
    /// ```swift
    /// let myString = "Hi"
    /// myString.range(...999) // Crashes
    /// myString.range(orNil: ...999) // Returns nil
    /// ```
    ///
    /// - Parameter integerRange: The range of characters in this string, as offset from the first index
    /// - Returns: A range of characters at `integerRange`, as deterined by the start of the string, or `nil` if the range extends outside the string
    @inline(__always)
    func range(orNil integerRange: NSRange) -> Range<Index>? {
        guard integerRange.length >= 0 else { return nil }
        return _range(orNil: integerRange)
    }
    
    
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
        get { self.range(orNil: range).flatMap { self[orNil: $0] } }
        set { self.range(orNil: range).flatMap { replaceCharacters(in: $0, with: newValue ?? "") } }
    }
}
#endif
