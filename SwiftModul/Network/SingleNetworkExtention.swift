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
import ObjectMapper

typealias SingleActionHandler = () -> Void

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    public func sendOnly() -> Single<Bool> {
        return self.mapJSON().flatMap { (_) -> Single<Bool> in
            return Single.just(true)
        }
    }

    public func mapObject<T: Mappable>(type: T.Type) -> Single<T> {

        return self.mapJSON().flatMap { response -> Single<T> in
            guard let json = response as? [String: Any] else {
                return Single.error(NetworkError.incorrectDataReturned)
            }
            guard let object = Mapper<T>().map(JSONObject: json) else {
                return Single.error(NetworkError.incorrectDataReturned)
            }
            return Single.just(object)
        }

    }

    public func mapObjects<T: Mappable>(type: T.Type) -> Single<[T]> {

        return self.mapJSON().flatMap { response -> Single<[T]> in
            guard let json = response as? [String: Any] else {
                return Single.error(NetworkError.incorrectDataReturned)
            }
            guard let data = json["message"] else {
                return Single.error(NetworkError.incorrectDataReturned)
            }
            guard let object = Mapper<T>().mapArray(JSONObject: data) else {
                return Single.error(NetworkError.incorrectDataReturned)
            }
            return Single.just(object)
        }
    }

    public func filterStatusCode() -> Single<Element> {
        return flatMap({ (response) -> Single<Element> in
            return Single.just(try response.filterStatusCode())
        })
    }

    public func cacheData(target: NetworkTarget) -> Single<Element> {

        return self.flatMap { (respose) -> Single<Element> in
                CacheToolFactory.dataCacheTool.setObject(respose.data, forKey: target.baseURL.absoluteString + target.path)
                return self
            }.catchError {error in
                let data = CacheToolFactory.dataCacheTool.objectSync(forKey: target.baseURL.absoluteString + target.path)
                if data == nil {
                    return Single.error(error)
                } else {
                    return Single.just(Response(statusCode: 200, data: data!))
                }
        }
    }
}
