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
        let rect = text.boundingRect(with: CGSize(width: CGFloat(Int.max), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: font)], context: nil)
        return rect.size.width
    }
    
    public func getHeight(text: String, width: CGFloat, font: CGFloat) -> CGFloat {
        let text = text as NSString
        let rect = text.boundingRect(with: CGSize(width: width, height: CGFloat(Int.max)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: font)], context: nil)
        return rect.size.height
    }
    
    public func addlineToLabelText(text: String) -> NSMutableAttributedString {
        
        let originalPricestr = NSMutableAttributedString(string: text)
        originalPricestr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: 1), range: NSRange(location: 0, length: originalPricestr.length))
        return originalPricestr
    }

}
