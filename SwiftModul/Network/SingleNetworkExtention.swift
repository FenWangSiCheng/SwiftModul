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
    
     public func mapObject<T: Codable>(type: T.Type) -> Single<T> {

           return self.mapJSON().flatMap { response -> Single<T> in
               guard let json = response as? [String: Any] else {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
               guard let dataDic = json["data"] else {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
               do {
                   let data = try JSONSerialization.data(withJSONObject: dataDic, options: [])

                   let object = try JSONDecoder().decode(type, from: data)
                   return Single.just(object)
               } catch {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
           }

       }

       public func mapObjects<T: Codable>(type: T.Type) -> Single<[T]> {

           return self.mapJSON().flatMap { response -> Single<[T]> in
               guard let json = response as? [String: Any] else {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
               guard let dataArray = json["data"]  else {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
               do {
                   let data = try JSONSerialization.data(withJSONObject: dataArray, options: [])
                   let object = try JSONDecoder().decode([T].self, from: data)
                   return Single.just(object)
               } catch {
                   return Single.error(NetworkError.incorrectDataReturned)
               }
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
