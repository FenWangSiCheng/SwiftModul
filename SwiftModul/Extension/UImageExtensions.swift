//
//  UImage-Extension.swift
//  SwiftModul
//
//  Created by fenrir-cd on 2018/5/29.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

extension UIImage {

    /// 根据名字生成不渲染图片
    ///
    /// - Parameter name: 图片名
    /// - Returns: 图片
    public class func originImageWithName(name: String) -> UIImage? {
        return UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
    }

    /// 绘制园图
    ///
    /// - Returns: 图片
    public func circleImage() -> UIImage? {

        let size = self.size
        let drawWH = size.width < size.height ? size.width : size.height

        UIGraphicsBeginImageContext(CGSize(width: drawWH, height: drawWH))
        let context = UIGraphicsGetCurrentContext()
        let clipRect = CGRect(x: 0, y: 0, width: drawWH, height: drawWH)
        context?.addEllipse(in: clipRect)
        context?.clip()
        self.draw(at: CGPoint(x: size.width, y: size.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage

    }

    class func weatherIcon(of name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind":
            return UIImage(named: "wind")
        case "cloudy":
            return UIImage(named: "cloudy")
        case "partly-cloudy-day":
            return UIImage(named: "partly-cloudy-day")
        case "partly-cloudy-night":
            return UIImage(named: "partly-cloudy-night")
        default:
            return UIImage(named: "clear-day")
        }
    }
}
