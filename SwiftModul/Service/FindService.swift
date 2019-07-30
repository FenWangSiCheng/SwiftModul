//
//  FindService.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation
import RxSwift

protocol FindServiceType {

    func getTestModel() -> Single<TestModelArrayModel>
}

class FindService: FindServiceType {

    let networking: Network!

    init(networking: Network) {
        self.networking = networking
    }

    func getTestModel() -> PrimitiveSequence<SingleTrait, TestModelArrayModel> {

        return networking.request(target: .getTestList).showStatus().cacheData(target: .getTestList).mapObject(type: TestModelArrayModel.self)

    }
}
