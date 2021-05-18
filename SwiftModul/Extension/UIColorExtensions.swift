//
//  UIColor-Extension.swift
// 
//
//  Created by kaito on 2016/12/4.
//  Copyright © 2016年 kaito. All rights reserved.
//

import UIKit

extension UIColor {

    public convenience init(re: CGFloat, gr: CGFloat, bl: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: re / 255.0, green: gr / 255.0, blue: bl / 255.0, alpha: alpha)
    }

    public convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
    public class func randomColor() -> UIColor {
        return UIColor(re: CGFloat(arc4random_uniform(256)), gr: CGFloat(arc4random_uniform(256)), bl: CGFloat(arc4random_uniform(256)))
    }
}
