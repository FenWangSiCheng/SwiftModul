//
//  NetworkTarget.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 wangsicheng. All rights reserved.
//

import UIKit
import Moya

public enum NetworkTarget {
    case getAllProducts(page: Int)
}

extension NetworkTarget: TargetType {
    
    public var baseURL: URL {
        return URL.init(string: APIConst.basePath)!
    }
    
    public var path: String {
        switch self {
        case .getAllProducts:
            return APIConst.getAllProducts
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAllProducts:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getAllProducts:
            let data = CommonTools.shareInstance.loadDataFromBundle(ofName: "AllProductInfo", ext: "json") ?? "".data(using: .utf8)!
            return data
        }
    }
    
    public  var task: Task {
        switch self {
        case let .getAllProducts(page):
            return .requestParameters(parameters: [APIConst.page: page],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
}
