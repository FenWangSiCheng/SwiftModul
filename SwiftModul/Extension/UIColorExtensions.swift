//
//  UIColor-Extension.swift
// 
//
//  Created by kaito on 2016/12/4.
//  Copyright © 2016年 kaito. All rights reserved.
//

import UIKit

extension UIColor {

    //RGB颜色
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    //颜色16进制
    public  convenience init?(hex: String, alpha: CGFloat = 1.0) {

        // 0xff0000
        // 1.判断字符串的长度是否符合
        guard hex.count >= 6 else {
            return nil
        }

        // 2.将字符串转成大写
        var tempHex = hex.uppercased()

        // 3.判断开头: 0x/#/##
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }

        // 4.分别取出RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)

        // 5.将十六进制转成数字 emoji表情
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)

        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }

    //随机色
    public class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
