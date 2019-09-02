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

public class Network {

    private var provider: MoyaProvider<NetworkTarget>!

    public static let instance = Network(provider: MoyaProvider<NetworkTarget>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: { (data) -> (Data) in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    })]))

    init(provider: MoyaProvider<NetworkTarget>) {
        self.provider = provider
    }

    public func request(target: NetworkTarget) -> Single<Response> {
        return provider.rx
            .request(target)
            .filterStatusCode()
    }
}

extension Network {

    func getAllProducts(page: Int) -> Single<[ProductInfoModel]> {
        return request(target: .getAllProducts(page: page))
            .mapObjects(type: ProductInfoModel.self)
    }
}
