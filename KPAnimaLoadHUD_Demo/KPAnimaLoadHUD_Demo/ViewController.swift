//
//  ViewController.swift
//  KPAnimaLoadHUD_Demo
//
//  Created by Kipp Dev on 2017/9/8.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bool = false
    var i = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        let img = UIImageView(frame: view.frame)
        img.image = UIImage(named: "1.jpg")
        //        view.addSubview(img)
        KPAnimaLoadHUD.shared().blurStyle = .dark
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bool = !bool
        if bool {

            switch i {
            case 1:
                KPAnimaLoadHUD.Show(inView: view, style: .ColorDot)
                i+=1
            case 2:
                KPAnimaLoadHUD.Show(inView: view, style: .WinLoading)
                i+=1
            case 3:
                KPAnimaLoadHUD.Show(inView: view, style: .WinWaiting)
                i = 1
            default:
                break
            }
        }else {
            KPAnimaLoadHUD.hide()
        }
    }

    @objc func touch() {
        print(1111)
    }



}

