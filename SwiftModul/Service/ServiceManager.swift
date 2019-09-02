//
//  ServiceManager.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation
import Moya

let serviceManager = ServiceManager.shared

class ServiceManager {
    
    internal let networking: Network
    internal init(networking: Network) {
        self.networking = networking
    }
    
    static let shared = ServiceManager(networking: Network.instance)
    
    lazy var findService: FindService = FindService(networking: networking)
    
}
