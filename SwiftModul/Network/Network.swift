//
//  Network.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public class Network {
    
    private var provider: MoyaProvider<NetworkTarget>!

    public static let instance = Network(provider: MoyaProvider<NetworkTarget>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                                                                                                                             logOptions: .verbose))]))
    
    init(provider: MoyaProvider<NetworkTarget>) {
        self.provider = provider
    }
    
    public func request<T>(_ target: NetworkTarget, isCache: Bool = false) -> Single<ResponseModel<T>> {
        if isCache {
            return provider.rx
                .request(target)
                .cacheData(target)
                .filterStatusCode()
                .parse(ResponseModel<T>.self)
        } else {
            return provider.rx
                .request(target)
                .filterStatusCode()
                .parse(ResponseModel<T>.self)
        }

    }
}

extension Network {
    
    func getAllProducts(parameters: [String: Any]) -> Single<[ProductInfoModel]> {
        return request(.getAllProducts(parameters: parameters)).map { $0.data }
    }
}

public struct ResponseModel<T: Decodable>: Decodable {
    let data: T
}
