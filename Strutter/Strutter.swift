//
//  Strutter.swift
//  Strutter
//
//  Created by Alex Pretzlav on 10/2/15.
//  Copyright © 2015 pretzlav. All rights reserved.
//

#if os(iOS)
    import UIKit
    typealias ViewClass = UIView
    #else
    import Cocoa
    typealias ViewClass = NSView
#endif

#if OALayout
    import OALayoutAnchor
    public typealias LayoutAnchor = OALayoutAnchor
    public typealias LayoutDimension = OALayoutDimension
    #else
    public typealias LayoutAnchor = NSLayoutAnchor
    public typealias LayoutDimension = NSLayoutDimension
#endif

infix operator |=| { associativity left precedence 90 }
infix operator |>=| { associativity left precedence 80 }
infix operator |<=| { associativity left precedence 80 }

private func install(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
    // Only disable AutoresizineMask on left item, secondItem may need it enabled
    if let v1 = constraint.firstItem as? ViewClass where v1.superview != nil {
        v1.translatesAutoresizingMaskIntoConstraints = false
    }
    activate(constraint)
    return constraint
}

private func activate(constraint: NSLayoutConstraint) {
    #if OALayout
        constraint.oa_active = true
    #else
        constraint.active = true
    #endif
}

/**
 All Strutter's infix operators create and activate constraints between two `NSLayoutAnchor`s.
 Strutter additionally sets `translatesAutoresizingMaskIntoConstraints` to `false` for the
 first item, provided the first item is a view class with a superview. This was chosen
 as it most closely matches the common case of added a subview, and then constraining it
 to its parent view. In that case, ensure the subview is always referenced on the left.
 */


/**
 Creates and activates a constraint that defines leftAnchor's attribute as equal to rightAnchor's attribute plus a constant offset.

 - parameter leftAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.
 - parameter constant:   The offset constant for this relationship.

 - returns: The new constraint.
 */
public func |=|(leftAnchor: LayoutAnchor, rest: (rightAnchor: LayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(rest.rightAnchor, constant: rest.constant))
}

/**
 Creates and activates a constraint that defines leftAnchor's attribute as equal to rightAnchor's attribute.

 - parameter leftAnchor:  A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.

 - returns: The new constraint.
 */
public func |=|(leftAnchor: LayoutAnchor, rightAnchor: LayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |=| (rightAnchor, constant: 0)
}

/**
 Creates and activates a constraint that defines leftAnchor's attribute as greater than or equal to rightAnchor's attribute.

 - parameter leftAnchor:  A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.

 - returns: The new constraint.
 */
public func |>=|(leftAnchor: LayoutAnchor, rightAnchor: LayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |>=| (rightAnchor, constant: 0)
}

/**
 Creates and activates a constraint that defines leftAnchor's attribute as greater than or equal to rightAnchor's attribute plus a constant offset.

 - parameter leftAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.
 - parameter constant:  The offset constant for this relationship.

 - returns: The new constraint.
 */
public func |>=|(leftAnchor: LayoutAnchor, rest: (rightAnchor: LayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintGreaterThanOrEqualToAnchor(rest.rightAnchor, constant: rest.constant))
}

/**
 Creates and activates a constraint that defines leftAnchor's attribute as less than or equal to rightAnchor's attribute.

 - parameter leftAnchor:  A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.

 - returns: The new constraint.
 */
public func |<=|(leftAnchor: LayoutAnchor, rightAnchor: LayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |<=| (rightAnchor, constant: 0)
}

/**
 Creates and activates a constraint that defines leftAnchor's attribute as less than or equal to rightAnchor's attribute plus a constant offset.

 - parameter leftAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter rightAnchor: A layout anchor from a `UIView`, `NSView`, or `UILayoutGuide` object of the same type.
 - parameter constant:  The offset constant for this relationship.

 - returns: The new constraint.
 */
public func |<=|(leftAnchor: LayoutAnchor, rest: (rightAnchor: LayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintLessThanOrEqualToAnchor(rest.rightAnchor, constant: rest.constant))
}

/**
 Creates and activates a constraint that sets a constant size for the attribute associated with a dimension anchor.

 - parameter leftDimension:  A dimension anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter constant:  A constant representing the size of the attribute associated with the dimension anchor.

 - returns: The new constraint.
 */
public func |=|(leftDimension: LayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    return install(leftDimension.constraintEqualToConstant(constant))
}

/**
  Creates and activates a constraint that defines a size attribute as equal to another size attribute multiplied by a constant plus an offset.

 - parameter leftAnchor: A dimension anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - paramater rightAnchor: A dimension anchor of same type from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter multiplier: The multiplier constant for the constraint.
 - parameter constant:   The offset constant for this relationship.

 - returns: The new constraint.
 */
public func |=|(leftAnchor: LayoutDimension, rest: (rightAnchor: LayoutDimension, multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(rest.rightAnchor, multiplier: rest.multiplier, constant: rest.constant))
}

/**
 Creates and activates a constraint that defines a size attribute as equal to another size attribute plus a constant offset.

 - parameter leftAnchor: A dimension anchor from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - paramater rightAnchor: A dimension anchor of same type from a `UIView`, `NSView`, or `UILayoutGuide` object.
 - parameter constant:   The offset constant for this relationship.

 - returns: The new constraint.
 */
public func |=|(leftAnchor: LayoutDimension, rest: (rightAnchor: LayoutDimension,  constant: CGFloat)) -> NSLayoutConstraint {
    return leftAnchor |=| (rest.rightAnchor, 1, rest.constant)
}