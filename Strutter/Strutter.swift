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

private func activate(constraint: NSLayoutConstraint) {
#if OALayout
    constraint.oa_active = true
    #else
    if #available(OSX 10.11, iOS 8.0, *) {
        constraint.active = true
    }
#endif
}

private func install(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
    // Only disable AutoresizineMask on left item, secondItem may need it enabled
    if let v1 = constraint.firstItem as? ViewClass where v1.superview != nil {
        v1.translatesAutoresizingMaskIntoConstraints = false
    }
    activate(constraint)
    return constraint
}

@available(OSX 10.11, iOS 8.0, *)
public func |=|<T: LayoutAnchor>(leftAnchor: T, pair: (T, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(pair.0, constant: pair.constant))
}


@available(OSX 10.11, iOS 8.0, *)
public func |=|<T: LayoutAnchor>(leftAnchor: T, rightAnchor: T) -> NSLayoutConstraint {
    return leftAnchor |=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 8.0, *)
public func |>=|<T: LayoutAnchor>(leftAnchor: T, rightAnchor: T) -> NSLayoutConstraint {
    return leftAnchor |>=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 8.0, *)
public func |>=|<T: LayoutAnchor>(leftAnchor: T, pair: (T, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintGreaterThanOrEqualToAnchor(pair.0, constant: pair.constant))
}

@available(OSX 10.11, iOS 8.0, *)
public func |<=|<T: LayoutAnchor>(leftAnchor: T, rightAnchor: T) -> NSLayoutConstraint {
    return leftAnchor |<=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 8.0, *)
public func |<=|<T: LayoutAnchor>(leftAnchor: T, params: (rightAnchor: T, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintLessThanOrEqualToAnchor(params.0, constant: params.constant))
}

@available(OSX 10.11, iOS 8.0, *)
public func |=|<T: LayoutDimension>(leftAnchor: T, constant: CGFloat) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToConstant(constant))
}

@available(OSX 10.11, iOS 8.0, *)
public func |=|<T: LayoutDimension>(leftAnchor: T, rest: (T, multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(rest.0, multiplier: rest.multiplier, constant: rest.constant))
}

@available(OSX 10.11, iOS 8.0, *)
public func |=|<T: LayoutDimension>(leftAnchor: T, rest: (T,  constant: CGFloat)) -> NSLayoutConstraint {
    return leftAnchor |=| (rest.0, 1, rest.constant)
}