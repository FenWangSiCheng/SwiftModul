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

    func indices(of item: Element) -> [Index] {
        return indices.filter { self[$0] == item }
    }

}

extension Array {
    subscript (safe index: Int) -> Element? {
        guard (startIndex..<endIndex).contains(index) else {
            return nil
        }
        return self[index]
    }
}
