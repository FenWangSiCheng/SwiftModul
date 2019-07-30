//
//  NetworkTarget.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import Moya

struct SkyAPI {
    static let key = "6797dd903ae2d9eb365d8add3474aeb1"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}

public enum NetworkTarget {
     case getTestList
     case getSkyData(latitude: Double, longitude: Double)
}

extension NetworkTarget: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .getTestList:
            return URL.init(string: "http://qf.56.com")!
        case .getSkyData:
            return SkyAPI.authenticatedURL
        }
        
    }
    
    public var path: String {
        switch self {
        case .getTestList:
            return "/home/v4/moreAnchor.ios"
        case let .getSkyData(latitude: latitude, longitude: longitue):
            return "\(latitude),\(longitue)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTestList:
            return .get
        case .getSkyData:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getTestList:
           return "".data(using: String.Encoding.utf8)!
        case .getSkyData:
            let data = """
            {
                "longitude" : 100,
                "latitude" : 52,
                "currently" : {
                    "temperature" : 23,
                    "humidity" : 0.91,
                    "icon" : "snow",
                    "time" : 1507180335,
                    "summary" : "Light Snow"
                },
                "daily": {
                    "data": [
                        {
                            "time": 1507180335,
                            "icon": "clear-day",
                            "temperatureLow": 66,
                            "temperatureHigh": 82,
                            "humidity": 0.25
                        }
                    ]
                }
            }
            """.data(using: .utf8)!
            return data
        }
        
    }
    
    public  var task: Task {
        switch self {
        case .getTestList:
            return .requestParameters(parameters: ["type": 0, "size": 48, "index": 0], encoding: URLEncoding.default)
        case .getSkyData:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
         return nil
    }

}
