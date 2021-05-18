//
//  Const.swift
//  SwiftModul
//
//  Created by fenrir-cd on 2018/7/25.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

let iphoneXR = kScreenH == 896 ? true : false
let iphoneX =  kScreenH == 812 ? true : false
let iphone8P = kScreenH == 736 ? true : false
let iphone8 = kScreenH == 667 ? true : false
let iphone5 = kScreenH == 568 ? true : false
let iphone4 = kScreenH == 480 ? true : false

let navigationBarHeight: CGFloat = iphoneX || iphoneXR ? 88 : 64
let tabbarHeight: CGFloat = iphoneX || iphoneXR ? 83 : 49
let statusBarHeight: CGFloat = iphoneX || iphoneXR ? 44 : 20

struct AssetsImageNames {

    static let placeHodelName = "tabbar_download_h"
}

public enum DateMode: Int {
    case text
    case digit

    var format: String {
        return self == .text ? "E, dd MMMM" : "EEEEE, MM/dd"
    }
}

public enum TemperatureMode: Int {
    case celsius
    case fahrenheit
}

struct APIConst {

    static let basePath = "http://yume.fenrir-inc.cn:7112/api/v2"
    static let getAllProducts = "/items/all"

    // parameters
    static let page = "page"

}

// MARK: - operator
infix operator ???: NilCoalescingPrecedence

public func ???<T> (optional: T?, defaultValue: @autoclosure () -> String)
    -> String {
    switch optional {
    case let value?:
        return String(describing: value)
    case nil:
        return defaultValue()
    }
}
