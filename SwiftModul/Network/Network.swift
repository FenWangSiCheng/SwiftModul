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
    
    public func request<T: Decodable>(target: NetworkTarget) -> Single<ResponseModel
        <T>> {
            return provider.rx
                .request(target)
                .filterStatusCode()
                .map(ResponseModel<T>.self)
    }
}

extension Network {
    
    func getAllProducts(page: Int) -> Single<[ProductInfoModel]> {
        return request(target: .getAllProducts(page: page)).map {$0.data}
    }
}
