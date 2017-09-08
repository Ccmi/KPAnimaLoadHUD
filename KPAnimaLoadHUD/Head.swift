//
//  Head.swift
//  KPLoadingHUD
//
//  Created by Kipp Dev on 2017/9/7.
//  Copyright © 2017年 Kipp. All rights reserved.
//

import UIKit


public func changeSize(frame:CGRect,size:Int) -> CGRect {
    return CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height + CGFloat(size))
}
