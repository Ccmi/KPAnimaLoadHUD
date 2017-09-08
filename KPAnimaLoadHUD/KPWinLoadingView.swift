//
//  KPWinLoadingView.swift
//  KPAnimaLoadHUD
//
//  Created by Kipp Dev on 2017/4/16.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit

class KPWinLoadingView: UIView {

    fileprivate var viewArray = [UIView]()

    init(frame:CGRect,colors:Array<UIColor>) {
        let size = 4
        let frame = changeSize(frame: frame, size: size)
        let minX = Int(frame.width - 220) / 2
        let minY = Int(frame.height - CGFloat(size)) / 2
        let cornerRadius = CGFloat(size) / 2
        super.init(frame: frame)

        for index in 0..<5 {
            let view = UIView(frame: CGRect(x: minX, y: minY, width: size, height: size))
            view.backgroundColor = colors.count > 5 ? colors[index] : colors.first
            view.layer.cornerRadius = cornerRadius
            self.addSubview(view)
            viewArray.append(view)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {

        let positionAnim = CAKeyframeAnimation(keyPath: "position.x")
        positionAnim.values = [0,100,120,220]
        positionAnim.keyTimes = [0,NSNumber(value: 0.35),NSNumber(value: 0.65),1]
        positionAnim.duration = 2.4
        positionAnim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                                        CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
                                        CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        positionAnim.isAdditive = true


        let alphaAnim = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.values = [0,1,1,1,0]
        alphaAnim.keyTimes = [0,NSNumber(value: 0.5 / 6.0), NSNumber(value: 3 / 6.0), NSNumber(value: 5.5 / 6.0), 1 ]
        alphaAnim.duration = 2.4
        alphaAnim.fillMode = kCAFillModeForwards
        alphaAnim.isRemovedOnCompletion = false

        let group = CAAnimationGroup()
        group.animations = [positionAnim,alphaAnim]
        group.duration = 3.2
        group.repeatCount = HUGE


        for view:UIView in viewArray {
            view.layer.add(group, forKey: "")
            group.timeOffset += 0.2
        }
        
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
