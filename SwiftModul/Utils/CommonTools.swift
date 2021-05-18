//
//  CommonTools.swift
//  PeiPeiPay
//
//  Created by fenrir-cd on 2018/8/22.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

class CommonTools: NSObject {
    public static let shareInstance: CommonTools = CommonTools()
    public func getWidth(text: String, height: CGFloat, font: CGFloat) ->
        CGFloat {
            let text = text as NSString
            let size = CGSize(width: CGFloat(Int.max), height: height)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)]
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
            let rect = text.boundingRect(with: size, options: options, attributes: attributes, context: nil)
            return rect.size.width
    }
    public func getHeight(text: String, width: CGFloat, font: CGFloat) -> CGFloat {
        let text = text as NSString
        let size = CGSize(width: width, height: CGFloat(Int.max))
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)]
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = text.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        return rect.size.height
    }
    public func addlineToLabelText(text: String) -> NSMutableAttributedString {
        let originalPricestr = NSMutableAttributedString(string: text)
        let attribute = NSAttributedString.Key.strikethroughStyle
        let range = NSRange(location: 0, length: originalPricestr.length)
        originalPricestr.addAttribute(attribute, value: NSNumber(value: 1), range: range)
        return originalPricestr
    }
    public func loadDataFromBundle(ofName name: String, ext: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: name, withExtension: ext) {
            return try? Data(contentsOf: url)
        }
        return nil
    }
}
