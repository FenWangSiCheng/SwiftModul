//
//  NSObjectExtention.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/9/2.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
