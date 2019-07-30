//
//  Array-Extension.swift
//  PeiPeiPay
//
//  Created by 潘振华 on 2018/8/27.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }

    subscript (safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
}
