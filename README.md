# Strutter
[![Travis-CI Badge](https://travis-ci.org/Pretz/Strutter.svg?branch=master)](https://travis-ci.org/Pretz/Strutter)
[![Cocoapods](https://img.shields.io/cocoapods/v/Strutter.svg?style=flat)](http://cocoapods.org/pods/Strutter)
[![License](https://img.shields.io/cocoapods/l/Strutter.svg?style=flat)](https://github.com/Pretz/Strutter/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Strutter.svg?style=flat)](http://cocoapods.org/pods/Strutter)

`Strutter` is a Swift µFramework for defining AutoLayout constraints with a few custom infix operators. It uses iOS 9 / OS X 10.11's [`NSLayoutAnchor`][anchor] system for defining these constraints. For now it requires iOS 9 or OS X 10.11, but I would like to add conditional support for [`OALayoutAnchor`][oalayoutanchor] in the future, to add support back to iOS 7.

`Strutter` uses the custom operators `|=|`,  `|>=|`, and `|<=|` to define equal, greater than equal, and less than equal constraints between two `NSLayoutAnchors`. The [Apple documentation][anchor] explains the basics of how NSLayoutAnchor works.

### How To

In iOS 8 aligning the trailing edge of one view with the leading edge of another was this verbose blob:

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

`Strutter` automatically activates constraints. The value of a `Strutter` expression is the created constraint, so it can be deactivated after creation if desired:
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
subv.widthAnchor.constraintEqualToConstant(200)
```

`Strutter` automatically disables the `translatesAutoresizingMaskIntoConstraints` attribute of the left-hand view. It doesn't automatically disable both views so positioning subviews of view controllers and navigation bars works as expected.

Since `Strutter` is just syntactic sugar on top of `NSLayoutAnchor`'s methods, it retains the type safety enforced by NSLayoutAnchor which prevents creating invalid constraints, such as between dimension and location metrics.


[anchor]: https://developer.apple.com/library/prerelease/mac/documentation/AppKit/Reference/NSLayoutAnchor_ClassReference/index.html
[oalayoutanchor]: https://github.com/oarrabi/OALayoutAnchor

### License

`Strutter` is released under the MIT License. Contributions appreciated.