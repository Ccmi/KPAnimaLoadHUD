//
//  KPColorDotView.swift
//  KPAnimaLoadHUD
//
//  Created by Kipp Dev on 2017/4/15.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit

class KPColorDotView: UIView {

    fileprivate let rView = UIView();
    fileprivate let gView = UIView();
    fileprivate let bView = UIView();

    init(frame:CGRect, RGBs:[UIColor], size: Int = 20) {
        super.init(frame: frame)

        let minX = Int(frame.width - 100) / 2
        let minY = Int(frame.height - CGFloat(size)) / 2
        let cornerRadius = CGFloat(size) / 2

        if RGBs.count == 3 {
            rView.backgroundColor = RGBs[0]
            gView.backgroundColor = RGBs[1]
            bView.backgroundColor = RGBs[2]

        }else{
            rView.backgroundColor = UIColor.red
            gView.backgroundColor = UIColor.green
            bView.backgroundColor = UIColor.blue


        }

        rView.frame = CGRect(x: minX, y: minY, width: size, height: size)
        gView.frame = CGRect(x: minX, y: minY, width: size, height: size)
        bView.frame = CGRect(x: minX, y: minY, width: size, height: size)

        rView.layer.cornerRadius = cornerRadius
        gView.layer.cornerRadius = cornerRadius
        bView.layer.cornerRadius = cornerRadius

        self.addSubview(rView)
        self.addSubview(gView)
        self.addSubview(bView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func startAnimation() {

        let positionAnim = CAKeyframeAnimation(keyPath: "position.x")
        positionAnim.values = [-5,0,10,40,70,80,75]
        positionAnim.keyTimes = [0,NSNumber(value:5 / 90.0),NSNumber(value:15 / 90.0),NSNumber(value:45 / 90.0),NSNumber(value:75 / 90.0),NSNumber(value:85 / 90.0),1]
        positionAnim.isAdditive = true

        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [ 0.7, 0.9, 1, 0.9, 0.7 ];
        scaleAnim.keyTimes = [0,NSNumber(value:15 / 90.0),NSNumber(value:45 / 90.0),NSNumber(value:75 / 90.0),1]

        let alphaAnim = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.values = [0,1,1,1,0]
        alphaAnim.keyTimes = [0,NSNumber(value:1 / 6.0),NSNumber(value:3 / 6.0),NSNumber(value:5 / 6.0),1]


        let group = CAAnimationGroup()
        group.animations = [positionAnim,scaleAnim,alphaAnim]
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.repeatCount = HUGE
        group.duration = 1.3


        rView.layer.add(group, forKey: "basic1")
        group.timeOffset = 0.43
        gView.layer.add(group, forKey: "basic2")
        group.timeOffset = 0.86
        bView.layer.add(group, forKey: "basic3")
    }


}
