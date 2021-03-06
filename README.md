[![Tested on GitHub Actions](https://github.com/RougeWare/Swift-String-Integer-Access/actions/workflows/swift.yml/badge.svg)](https://github.com/RougeWare/Swift-String-Integer-Access/actions/workflows/swift.yml) [![](https://www.codefactor.io/repository/github/rougeware/swift-string-integer-access/badge)](https://www.codefactor.io/repository/github/rougeware/swift-string-integer-access)

[![Swift 5](https://img.shields.io/badge/swift-5-brightgreen.svg?logo=swift&logoColor=white)](https://swift.org) [![swift package manager 5.2 is supported](https://img.shields.io/badge/swift%20package%20manager-5.2-brightgreen.svg)](https://swift.org/package-manager) [![Supports macOS, iOS, tvOS, watchOS, Linux, & Windows](https://img.shields.io/badge/macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux%20%7C%20Windows-grey.svg)](./Package.swift) 
[![](https://img.shields.io/github/release-date/rougeware/swift-string-integer-access?label=latest%20release)](https://github.com/RougeWare/Swift-String-Integer-Access/releases/latest)



# Swift String Integer Access #

I hate how Swift `String`s don't let you access their characters with `Int`s. This package changes this:

```swift
someString[someString.index(someString.startIndex, offsetBy: 2) ... someString.index(someString.startIndex, offsetBy: 5)]
```

to this:

```swift
import StringIntegerAccess

var someString = "Hello, World!"

someString[1...4] // "ello"
someString[7..<12] = "Mars" // "Hello, Mars!"
```


## Safety ##

If you prefer, you can also have the peace-of-mind that whatever integers you pass, it won't crash! Starting in version `2.0.0`, you can now use `[orNil:]` subscripts, which will return the same values as the regular ones, but if you give them out-of-range indices, they return `nil` instead of crashing: 

```swift
import SafeStringIntegerAccess

var someString = "Hello, World"

someString[orNil: 3..<5] == "lo"
someString[orNil: 3..<5] == someString[3..<5]
someString[orNil: 42..<99] == nil 
someString[orNil: -10 ..< -5] == nil 


someString[orNil: 7...]   = "Mars!"      // "Hello, Mars!"
someString[orNil: 999...] = "Boundaries" // "Hello, Mars!"
```

Even better, this also implicitly imports `StringIntegerAccess`, so you don't have to double-up the imports!


## Performance ##

This is **exactly as performant** as the long forms that it shortens. That said, the long form is often not very performant. As pointed out by [Rob Napier on StackOverflow](https://stackoverflow.com/a/46163365/3939277), since Swift `String` elements are Unicode characters, and since Unicode characters are an indeterminate number of codepoints long, and since the storage backing `String`s is comprised of UTF-8 codepoints, there's no simple way to know how big a character is, so you can't just jump to anywhere in a string without reading everything before it first. In order to figure out "character _n_" you have to start at the beginning and decode everything, which is O(n).

> So you write code like this, that feels very "safe":
>
> ```swift
> for index in 0..<string.count {
>     print(string[index])
> }
> ```
> But secretly this is O(n^2) which is really surprising because it sure looks like O(n). You might say "well, my string is only 20 characters long, so who cares," but we use strings for lots of things, including multi-megabyte `NSTextStorage`. (And this expands dramatically in Swift versus some other languages because Swift includes generic algorithms whose performance promises rely on the fact that subscripting is O(1).)

You can also learn more about why this was done [in my StackOverflow question about why emoji like `👩‍👩‍👧‍👦` are treated so strangely in Swift `String`s](https://stackoverflow.com/a/43619038/3939277):

> ```swift
> "\u{1112}\u{1161}\u{11AB}".contains("\u{1112}") // false
> ```

This is something you should be aware of anyway, if you're parsing big strings. It's just worth pointing out, here, that this sugar only sweetens the interface to a sour backend. If you're reading in and using lots of data, you should be using the `Data` type, [which has `Int` subscripts already](https://developer.apple.com/documentation/foundation/data#2850612).
