//
//  SingleNetworkExtention.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import RxSwift
import Moya

typealias SingleActionHandler = () -> Void

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    public func sendOnly() -> Single<Bool> {
        return self.mapJSON().flatMap { (_) -> Single<Bool> in
            return Single.just(true)
        }
    }
    
    public func filterStatusCode() -> Single<Element> {
        return flatMap({ (response) -> Single<Element> in
            return Single.just(try response.filterStatusCode())
        })
    }

    public func parse<T: Decodable>(_ type: T.Type) -> Single<T> {
        return map(T.self)
    }

    public func cacheData(_ target: NetworkTarget) -> Single<Element> {
        
        return self.flatMap { (respose) -> Single<Element> in
            UserDefaults.standard[target.baseURL.absoluteString + target.path] = respose.data
            return self
            }.catchError {error in
                let data = UserDefaults.standard.object(Data.self, with: target.baseURL.absoluteString + target.path)
                if data == nil {
                    return Single.error(error)
                } else {
                    return Single.just(Response(statusCode: 200, data: data!))
                }
        }
    }
}
