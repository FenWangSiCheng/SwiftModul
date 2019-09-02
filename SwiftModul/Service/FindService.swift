//
//  FindService.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation
import RxSwift

class FindService {
    
    let networking: Network!
    
    init(networking: Network) {
        self.networking = networking
    }
    
    public func getAllProducts(page: Int) -> Single<[ProductInfoModel]> {
        return networking.getAllProducts(page: page)
    }
}
