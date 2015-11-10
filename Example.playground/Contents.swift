//: Playground - noun: a place where people can play

import UIKit
import Strutter

let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
let subv = UIView()
v.backgroundColor = .whiteColor()
subv.backgroundColor = .blueColor()
v.addSubview(subv)

let subv2 = UIView()
subv2.backgroundColor = .greenColor()
v.addSubview(subv2)

let subv3 = UIView()
subv3.backgroundColor = .orangeColor()
v.addSubview(subv3)

subv.widthAnchor |=| 20
subv.heightAnchor |=| 30
subv.centerXAnchor |=| v.centerXAnchor
subv.topAnchor |=| (v.topAnchor, 10)

subv2.widthAnchor |=| subv.widthAnchor
subv3.widthAnchor |=| subv.widthAnchor

subv2.heightAnchor |=| subv.heightAnchor
subv3.heightAnchor |=| subv.heightAnchor

subv2.leftAnchor |=| subv.leftAnchor
subv3.leftAnchor |=| subv.leftAnchor

subv2.topAnchor |=| (subv.bottomAnchor, constant: 10)
subv3.topAnchor |=| (subv2.bottomAnchor, constant: 10)

v.layoutIfNeeded()
v
