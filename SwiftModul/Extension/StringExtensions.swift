//
//  String-Extension.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/26.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation
import CryptoKit

extension String {

    func md5() -> String {
        if let data = self.data(using: .utf8) {
            return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
        } else {
            return ""
        }
    }
}
