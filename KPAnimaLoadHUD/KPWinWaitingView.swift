//
//  KPWinWaitingView.swift
//  LoadingAnimation
//
//  Created by Kipp Dev on 2017/4/16.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit

class KPWinWaitingView: UIView {

    var viewArray = [UIView]()
    let r = 15
    init(frame:CGRect,colors:Array<UIColor>) {
        let size = 5
        let frame = changeSize(frame: frame, size: size)
        super.init(frame: frame)

        let minX = Int(frame.width - 5) / 2
        let minY = Int(frame.height - CGFloat(size)) / 2

        let cornerRadius = CGFloat(size) / 2



        for index in 0..<5 {
            let view = UIView()
            view.frame = CGRect(x: CGFloat(minX), y: CGFloat(minY), width: CGFloat(size), height: CGFloat(size))
            view.backgroundColor = colors.count > 5 ? colors[index] : colors.first
            view.layer.cornerRadius = cornerRadius

            print(view.layer.anchorPoint)
            self.addSubview(view)

            viewArray.append(view)


        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {

        let rotationAnim = CAKeyframeAnimation(keyPath: "position")

        let path = CGMutablePath()

        let center = CGPoint.zero

        path.addArc(center: center, radius: 20, startAngle: .pi / 2, endAngle: .pi * 2 + .pi / 2, clockwise: false)

        path.closeSubpath()

        rotationAnim.path = path

        rotationAnim.isAdditive = true
        rotationAnim.repeatCount = 2
        rotationAnim.keyTimes = [0,
                                 NSNumber(value: 1 / 7.0),
                                 NSNumber(value: 4.5 / 7.0),
                                 NSNumber(value: 6 / 7.0),
                                 1]
        rotationAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            ]

        rotationAnim.duration = 2
        rotationAnim.isRemovedOnCompletion = false

        let alphaAnim = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.values = [0,1,1,1,0]
        alphaAnim.keyTimes = [0,NSNumber(value:1 / 48.0),NSNumber(value:35 / 48.0),NSNumber(value:47 / 48.0),1]

        alphaAnim.fillMode = kCAFillModeForwards
        alphaAnim.duration = 4

        let group = CAAnimationGroup()
        group.animations = [rotationAnim,alphaAnim]
        group.duration = 5
        group.repeatCount = HUGE

        for view:UIView in viewArray {
            view.layer.add(group, forKey: "")
            group.timeOffset += 0.18
        }
        
    }
    
    
}
