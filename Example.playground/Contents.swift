//: Playground - noun: a place where people can play

import UIKit
import Strutter

let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
let subv = UIView()
v.backgroundColor = UIColor.whiteColor()
subv.backgroundColor = UIColor.blueColor()
v.addSubview(subv)

subv.widthAnchor |=| 20
subv.heightAnchor |=| 30
subv.centerXAnchor |=| v.centerXAnchor
subv.topAnchor |=| (v.topAnchor, 10)

let subv2 = UIView()
subv2.backgroundColor = UIColor.greenColor()
v.addSubview(subv2)

let subv3 = UIView()
subv3.backgroundColor = UIColor.orangeColor()
v.addSubview(subv3)

subv2.widthAnchor |=| subv.widthAnchor
subv2.widthAnchor |=| subv3.widthAnchor
subv2.heightAnchor |=| subv.heightAnchor
subv2.heightAnchor |=| subv3.heightAnchor
subv2.leftAnchor |=| subv.leftAnchor
subv2.leftAnchor |=| subv3.leftAnchor

subv2.topAnchor |=| (subv.bottomAnchor, constant: 10)
subv3.topAnchor |=| (subv2.bottomAnchor, constant: 10)

v.layoutIfNeeded()
v
