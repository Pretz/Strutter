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

infix operator |=| { associativity left precedence 90 }
infix operator |>=| { associativity left precedence 80 }
infix operator |<=| { associativity left precedence 80 }

private func install(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
    // Only disable AutoresizineMask on left item, secondItem may need it enabled
    if let v1 = constraint.firstItem as? ViewClass where v1.superview != nil {
        v1.translatesAutoresizingMaskIntoConstraints = false
    }
    constraint.active = true
    return constraint
}

@available(OSX 10.11, iOS 9.0, *)
public func |=|<T: NSLayoutAnchor>(leftAnchor: T, pair: (NSLayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(pair.0, constant: pair.constant))
}


@available(OSX 10.11, iOS 9.0, *)
public func |=|<T: NSLayoutAnchor>(leftAnchor: T, rightAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 9.0, *)
public func |>=|<T: NSLayoutAnchor>(leftAnchor: T, rightAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |>=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 9.0, *)
public func |>=|<T: NSLayoutAnchor>(leftAnchor: T, pair: (NSLayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintGreaterThanOrEqualToAnchor(pair.0, constant: pair.constant))
}

@available(OSX 10.11, iOS 9.0, *)
public func |<=|<T: NSLayoutAnchor>(leftAnchor: T, rightAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return leftAnchor |<=| (rightAnchor, constant: 0)
}

@available(OSX 10.11, iOS 9.0, *)
public func |<=|<T: NSLayoutAnchor>(leftAnchor: T, params: (rightAnchor: NSLayoutAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintLessThanOrEqualToAnchor(params.0, constant: params.constant))
}

@available(OSX 10.11, iOS 9.0, *)
public func |=|<T: NSLayoutDimension>(leftAnchor: T, constant: CGFloat) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToConstant(constant))
}

@available(OSX 10.11, iOS 9.0, *)
public func |=|<T: NSLayoutDimension>(leftAnchor: T, rest: (NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)) -> NSLayoutConstraint {
    return install(leftAnchor.constraintEqualToAnchor(rest.0, multiplier: rest.multiplier, constant: rest.constant))
}

@available(OSX 10.11, iOS 9.0, *)
public func |=|<T: NSLayoutDimension>(leftAnchor: T, rest: (NSLayoutDimension,  constant: CGFloat)) -> NSLayoutConstraint {
    return leftAnchor |=| (rest.0, 1, rest.constant)
}