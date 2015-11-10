# Strutter
[![Travis-CI Badge](https://travis-ci.org/Pretz/Strutter.svg?branch=master)](https://travis-ci.org/Pretz/Strutter)
[![Cocoapods](https://img.shields.io/cocoapods/v/Strutter.svg?style=flat)](http://cocoapods.org/pods/Strutter)
[![License](https://img.shields.io/cocoapods/l/Strutter.svg?style=flat)](https://github.com/Pretz/Strutter/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Strutter.svg?style=flat)](http://cocoapods.org/pods/Strutter)

`Strutter` is a Swift µFramework for defining AutoLayout constraints with a few custom infix operators. It uses iOS 9 / OS X 10.11's [`NSLayoutAnchor`][anchor] system for defining these constraints. 

For backwards compatibility, there is a subspec called `OALayoutAnchor` and an alternate framework called `Strutter iOS OALayout` which uses [OALayoutAnchor](https://github.com/oarrabi/OALayoutAnchor) instead of `NSLayoutAnchor`. This version works on iOS 8.

`Strutter` uses the custom operators `|=|`,  `|>=|`, and `|<=|` to define equal, greater than equal, and less than equal constraints between two `NSLayoutAnchors`. The [Apple documentation][anchor] explains the basics of how NSLayoutAnchor works.

`Strutter` automatically activates constraints and disables the `translatesAutoresizingMaskIntoConstraints` attribute of the left-hand view. It doesn't automatically disable both views so positioning subviews of view controllers and navigation bars works as expected.

Since `Strutter` is just syntactic sugar on top of `NSLayoutAnchor`'s methods, it retains the type safety enforced by NSLayoutAnchor which prevents creating invalid constraints, such as between dimension and location metrics.

### Installation

Strutter supports [Cocoapods](https://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

#### CocoaPods

Add the following to your Podfile
```ruby
platform :ios, '9.0'
use_frameworks!

pod 'Strutter'
```
or, if you're using iOS 8:
```ruby
platform :ios, '8.0'
use_frameworks!

# Temporary, needed for Xcode 7 compatibility
pod "OALayoutAnchor", git: "https://github.com/Pretz/OALayoutAnchor.git"
pod 'Strutter/OALayoutAnchor'
```

Then run `pod install`

#### Carthage

Add to your `Cartfile`
```
github "Pretz/Strutter"
```

Run `carthage update` to build the frameworks and drag the built `Strutter.framework` into your Xcode project. The `OALayoutAnchor` variant is not supported with Carthage, as `OALayoutAnchor` does not yet support Carthage.

### How To

This verbose blob aligns the trailing edge of one view with the leading edge of another on iOS 8:

```swift
NSLayoutConstraint(item: view1,
    attribute: .Trailing,
    relatedBy: .Equal,
    toItem: view2,
    attribute: .Leading,
    multiplier: 1,
    constant: 0).active = true
```

Using layout anchors shortens this to the following:

```swift
view1.trailingAnchor.constraintEqualToAnchor(view2.leadingAnchor).active = true
```

`Strutter` shortens this futher to
```swift
view1.trailingAnchor |=| view2.leadingAnchor
```

The value of a `Strutter` expression is the created constraint, so it can be deactivated after creation if desired:
```swift
let constraint = view1.trailingAnchor |=| view2.leadingAnchor
constraint.active = false
```

#### Constants and Multipliers

`Strutter` allows specifying a constant and/or multiplier via tuples:
```swift
subview.topAnchor |=| (superview.topAnchor, 10)
```
is equivalent to
```swift
subview.topAnchor.constraintEqualToAnchor(
    superview.topAnchor, constant: 10).active = true
// or
NSLayoutConstraint(item: subview, 
    attribute: .Top, 
    relatedBy: .Equal, 
    toItem: superview, 
    attribute: .Top, 
    multiplier: 1, 
    constant: 10).active = true
```

and

```swift
subv.heightAnchor |=| (v.heightAnchor, multiplier: 2, constant: -20)
```
is equivalent to
```swift
subv.heightAnchor.constraintEqualToAnchor(
    v.heightAnchor, multiplier: 2, constant: -20)
```

#### Inequalities

To define less-than and greater-than attributes:
```swift
subv.heightAnchor |<=| v.heightAnchor
```
Is the same as
```swift
subv.heightAnchor.constraintLessThanOrEqualToAnchor(v.heightAnchor)
```

#### Fixed Values

Lastly, `Strutter` allows constraining to constant values for dimension axes:
```swift
subv.heightAnchor |=| 200
```
is equivalent to
```swift
subv.heightAnchor.constraintEqualToConstant(200)
```

[anchor]: https://developer.apple.com/library/prerelease/mac/documentation/AppKit/Reference/NSLayoutAnchor_ClassReference/index.html
[oalayoutanchor]: https://github.com/oarrabi/OALayoutAnchor

### Playground

Take a look at [the playground](https://github.com/Pretz/Strutter/blob/master/Example.playground/Contents.swift), which demonstrates basic `Strutter` syntax. To use it, open the Strutter.xcworkspace project, build the `Strutter iOS` scheme with a target of an iPhone 5s simulator or newer, and select `Example.playground` in the project navigator.

### License

`Strutter` is released under the MIT License. Contributions appreciated.