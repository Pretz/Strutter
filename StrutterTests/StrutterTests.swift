//
//  StrutterTests.swift
//  StrutterTests
//
//  Created by Alex Pretzlav on 10/2/15.
//  Copyright © 2015 pretzlav. All rights reserved.
//

import XCTest
#if os(iOS)
    import UIKit
    typealias ViewClass = UIView
    #else
    import Cocoa
    typealias ViewClass = NSView
#endif

#if OALayout
    import Strutter_OALayout
    import OALayoutAnchor
    func topAnchor(v: UIView) -> OALayoutAnchor {
        return v.oa_topAnchor
    }
    func heightAnchor(v: UIView) -> OALayoutDimension {
        return v.oa_heightAnchor
    }
#else
    import Strutter
    @available(iOS 9.0, *)
    func topAnchor(v: ViewClass) -> NSLayoutAnchor {
        return v.topAnchor
    }
    @available(iOS 9.0, *)
    func heightAnchor(v: ViewClass) -> NSLayoutDimension {
        return v.heightAnchor
    }
#endif

class StrutterTests: XCTestCase {

    let superview = ViewClass()
    let v1 = ViewClass()
    let v2 = ViewClass()

    override func setUp() {
        super.setUp()
        superview.addSubview(v1)
        superview.addSubview(v2)
    }

    func assertEqualConstraints(c1: NSLayoutConstraint, c2: NSLayoutConstraint, file: String = __FILE__, line: UInt = __LINE__) {
        XCTAssertEqual(c1.firstItem as? NSObject, c2.firstItem as? NSObject, file: file, line: line)
        XCTAssertEqual(c1.firstAttribute, c2.firstAttribute,
            "Incorrect attributes: \(c1.firstAttribute.name) and \(c2.firstAttribute.name)", file: file, line: line)
        XCTAssertEqual(c1.relation, c2.relation,
            "Incorrect relation: \(c1.relation.name) and \(c2.relation.name)", file: file, line: line)
        XCTAssertEqual(c1.secondItem as? NSObject, c2.secondItem as? NSObject, file: file, line: line)
        XCTAssertEqual(c1.secondAttribute, c2.secondAttribute,
            "Incorrect attributes: \(c1.secondAttribute.name) and \(c2.secondAttribute.name)", file: file, line: line)
        XCTAssertEqual(c1.constant, c2.constant, file: file, line: line)
        XCTAssertEqual(c1.multiplier, c2.multiplier, file: file, line: line)
    }
    
    func testInsideSuperview() {
        assertEqualConstraints(topAnchor(v1) |=| topAnchor(superview),
            c2: topAnchor(v1).constraintEqualToAnchor(topAnchor(superview)))
        XCTAssertFalse(v1.translatesAutoresizingMaskIntoConstraints)
    }

    func testConstant() {
        assertEqualConstraints(topAnchor(v1) |=| (topAnchor(superview), constant: -20),
            c2: topAnchor(v1).constraintEqualToAnchor(topAnchor(superview), constant: -20))
    }

    func testLessThan() {
        assertEqualConstraints(topAnchor(v1) |<=| topAnchor(superview),
            c2: topAnchor(v1).constraintLessThanOrEqualToAnchor(topAnchor(superview)))
    }

    func testLessThanConstant() {
        assertEqualConstraints(topAnchor(v1) |<=| (topAnchor(superview), -20),
            c2: topAnchor(v1).constraintLessThanOrEqualToAnchor(topAnchor(superview), constant: -20))
    }

    func testGreaterThan() {
        assertEqualConstraints(topAnchor(v1) |>=| topAnchor(superview),
            c2: topAnchor(v1).constraintGreaterThanOrEqualToAnchor(topAnchor(superview)))
    }

    func testGreaterThanConstant() {
        assertEqualConstraints(topAnchor(v1) |>=| (topAnchor(superview), 20),
            c2: topAnchor(v1).constraintGreaterThanOrEqualToAnchor(topAnchor(superview), constant: 20))
    }

    func testFixedValue() {
        assertEqualConstraints(heightAnchor(v1) |=| 200,
            c2: heightAnchor(v1).constraintEqualToConstant(200))
    }

    func testMultiplierAndConstant() {
        assertEqualConstraints(heightAnchor(v1) |=| (heightAnchor(superview), multiplier: 2, constant: -20),
            c2: heightAnchor(v1).constraintEqualToAnchor(heightAnchor(superview), multiplier: 2, constant: -20))
    }

    func testDimensionWithConstant() {
        assertEqualConstraints(heightAnchor(v1) |=| (heightAnchor(superview), 20),
            c2: heightAnchor(v1).constraintEqualToAnchor(heightAnchor(superview), constant: 20))
    }
}

extension NSLayoutRelation {
    var name: String {
        switch self {
        case .Equal:
            return "Equal"
        case .GreaterThanOrEqual:
            return "GreaterThanOrEqual"
        case .LessThanOrEqual:
            return "LessThanOrEqual"
        }
    }
}

#if os(iOS)
    extension NSLayoutAttribute {
        var name: String {
            switch self {
            case .Left:
                return "Left"
            case .Right:
                return "Right"
            case .Top:
                return "Top"
            case .Bottom:
                return "Bottom"
            case .Leading:
                return "Leading"
            case .Trailing:
                return "Trailing"
            case .Width:
                return "Width"
            case .Height:
                return "Height"
            case .CenterX:
                return "CenterX"
            case .CenterY:
                return "CenterY"
            case .Baseline:
                return "Baseline"
            case .FirstBaseline:
                return "FirstBaseline"
            case .NotAnAttribute:
                return "NotAnAttribute"
            case .LeftMargin:
                return "LeftMargin"
            case .RightMargin:
                return "RightMargin"
            case .TopMargin:
                return "TopMargin"
            case .BottomMargin:
                return "BottomMargin"
            case .LeadingMargin:
                return "LeadingMargin"
            case .TrailingMargin:
                return "TrailingMargin"
            case .CenterXWithinMargins:
                return "CenterXWithinMargins"
            case .CenterYWithinMargins:
                return "CenterYWithinMargins"
            }
        }
    }
    #else
    extension NSLayoutAttribute {
        var name: String {
            switch self {
            case .Left:
                return "Left"
            case .Right:
                return "Right"
            case .Top:
                return "Top"
            case .Bottom:
                return "Bottom"
            case .Leading:
                return "Leading"
            case .Trailing:
                return "Trailing"
            case .Width:
                return "Width"
            case .Height:
                return "Height"
            case .CenterX:
                return "CenterX"
            case .CenterY:
                return "CenterY"
            case .Baseline:
                return "Baseline"
            case .FirstBaseline:
                return "FirstBaseline"
            case .NotAnAttribute:
                return "NotAnAttribute"
            }
        }
    }
#endif
