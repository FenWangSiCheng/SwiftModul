//
//  ServiceManager.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import Foundation
import Moya

internal struct Config {
    private static func isUITesting() -> Bool {
        print(ProcessInfo.processInfo.arguments)
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }

    static var netWork: Network = {

        if isUITesting() {
            let json = ProcessInfo.processInfo.environment["FakeJSON"]
            if let json = json {
                let data = json.data(using: .utf8)!
                let endpointClosure = { (target: NetworkTarget) -> Endpoint in
                    let url = URL(target: target).absoluteString
                    return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, data)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
                }
                let provider = MoyaProvider<NetworkTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                return Network(provider: provider)
            } else {
                return Network.instance
            }
        } else {
            return Network.instance
        }
    }()
}

let serviceManager = ServiceManager.shared

class ServiceManager {

    internal let networking: Network
    internal init(networking: Network) {
        self.networking = networking
    }

    static let shared = ServiceManager(networking: Config.netWork)

    lazy var findService: FindService = FindService(networking: networking)

}
