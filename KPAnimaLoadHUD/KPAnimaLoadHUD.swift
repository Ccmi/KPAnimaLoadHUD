//
//  KPAnimaLoadHUD.swift
//  KPAnimaLoadHUD
//
//  Created by Kipp Dev on 2017/9/7.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit


 enum LoadingStyle{
    case ColorDot
    case WinWaiting
    case WinLoading
}

class KPAnimaLoadHUD: UIView {

    open var blurStyle:UIBlurEffectStyle = UIBlurEffectStyle.light {
        didSet {
            self.setBlurStyle()
        }
    }

    fileprivate static let instance = KPAnimaLoadHUD.shared()
    fileprivate let ScreenWidth = UIScreen.main.bounds.width
    fileprivate let ScreenHeight = UIScreen.main.bounds.height
    fileprivate var timer:Timer!
    fileprivate var hud:UIVisualEffectView!
    fileprivate var colors = [UIColor]()
    //    fileprivate var hud: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareBlurView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension KPAnimaLoadHUD {

    class func shared() -> KPAnimaLoadHUD {
        struct Static {
            static let hud = KPAnimaLoadHUD()
        }
        return Static.hud
    }

    class func Show(inView: UIView, style:LoadingStyle, colors: Array<UIColor> = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)], delay:Int = 0) {
        hide()
        inView.addSubview(instance)
        inView.bringSubview(toFront: instance)
        instance.colors = colors
        UIView.animate(withDuration: 0.2) {
            instance.alpha = 1
        }

        assert(instance.colors.count > 0, "Need a color value！")
        switch style {
        case .ColorDot:
            instance.prepareColorDotHud()
        case .WinLoading:
            instance.prepareWinLoadingHud()
        case .WinWaiting:
            instance.prepareWinWaitingHud()
        }

        if delay != 0 {
            let time = Double(delay)

            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                hide()
            }
        }
    }

    class func hide() {
        guard instance.subviews.count != 0 else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            instance.alpha = 0.2
        }) { (bool) in
            instance.removeFromSuperview()
            _ = instance.hud.contentView.subviews.map{
                $0.removeFromSuperview()
            }
            _ = instance.subviews.map{
                $0.removeFromSuperview()
            }
        }
    }
}

extension KPAnimaLoadHUD {

    fileprivate func prepareColorDotHud() {

        hud.bounds = CGRect(x: 0, y: 0, width: 120, height: 100)
        hud.center = self.center
        hud.layer.cornerRadius = 5
        self.addSubview(hud)
        
        if colors.count < 3 {
            colors = Array(repeating: colors.first!, count: 3)
        }

        let ani = KPColorDotView(frame:CGRect(x: 0, y: 0, width:hud.frame.width , height: hud.frame.height) , RGBs: colors)
        hud.contentView.addSubview(ani)
        ani.startAnimation()

    }

    fileprivate func  prepareWinLoadingHud() {

        hud.bounds = CGRect(x: 0, y: 0, width: 240, height: 100)
        hud.center = self.center
        hud.layer.cornerRadius = 5
        self.addSubview(hud)
        let ani = KPWinLoadingView(frame: CGRect(x: 0, y: 0, width:hud.frame.width , height: hud.frame.height), colors: colors)
        hud.contentView.addSubview(ani)
        ani.startAnimation()
    }

    fileprivate func prepareWinWaitingHud() {

        hud.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        hud.center = self.center
        hud.layer.cornerRadius = 5
        self.addSubview(hud)
        let ani = KPWinWaitingView(frame: CGRect(x: 0, y: 0, width:hud.frame.width  , height: hud.frame.height), colors: colors)
        hud.contentView.addSubview(ani)
        ani.startAnimation()
    }
    
}

extension KPAnimaLoadHUD {
    
    fileprivate func prepareBlurView() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        hud = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        hud.clipsToBounds = true


    }

    fileprivate func setBlurStyle() {
        hud.effect = UIBlurEffect(style: blurStyle)
    }
}


