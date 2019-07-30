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

struct PreferenceNames {

    static let maxCacheSize = PreferenceName<String>(rawValue: "MaxCacheSize")!
    static let isMan = PreferenceName<Bool>(rawValue: "IsMan")!
}

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

public struct UserDefaultsKeys {
    static let dateMode = PreferenceName<Int>(rawValue: "dateMode")!
    static let temperatureMode = PreferenceName<Int>(rawValue: "temperatureMode")!
    static let locations = PreferenceName<Int>(rawValue: "locations")!
}
