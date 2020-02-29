//
//  String + Integer access.swift
//  String Integer Access
//
//  Created by Ben Leggiero on 2020-02-27.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//



public extension String {
    
    /// Simple sugar for `myString.index(myString.startIndex, offsetBy: characterIndex)`
    ///
    /// - Parameter characterIndex: The index of a character in this string
    /// - Returns: An index offset by `characterIndex` from the start of the string

    @inline(__always)
    func index(_ characterIndex: Int) -> Index {
        self.index(startIndex, offsetBy: characterIndex)
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: characterIndex)]`
    ///
    /// - Parameter characterIndex: A valid index of a character in the string. Must be less than `endIndex`.
    /// - Returns: The character at the given index in this string
    @inlinable
    subscript(_ characterIndex: Int) -> Element {
        self[index(characterIndex)]
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ... myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `startIndex` (inclusive) and `endIndex` (exclusive).
    /// - Returns: The characters at the given indices in this string
    @inlinable
    subscript(_ range: ClosedRange<Int>) -> SubSequence {
        self[ClosedRange(uncheckedBounds: (lower: index(range.lowerBound), upper: index(range.upperBound)))]
    }
    
    
    /// Simply sugar for `myString[myString.index(myString.startIndex, offsetBy: lower) ..< myString.index(myString.startIndex, offsetBy: upper)]`
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string. Must be contained
    ///                    within `startIndex` (inclusive) and `endIndex` (inclusive).
    /// - Returns: The characters at the given indices in this string
    @inlinable
    subscript(_ range: Range<Int>) -> SubSequence {
        self[Range(uncheckedBounds: (lower: index(range.lowerBound), upper: index(range.upperBound)))]
    }
}
