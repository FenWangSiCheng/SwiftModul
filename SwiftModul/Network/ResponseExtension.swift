//
//  ResponseExtension.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import Moya

extension Response {
    public func filterStatusCode() throws -> Response {
        switch statusCode {
        case 200...299:
            return self
        case 500...502, 504...505:
            throw NetworkError.serverError
        case 503:
            throw NetworkError.serverMaintenance
        case 404:
            throw NetworkError.notFound
        case 401:
            throw NetworkError.authenticationFailed
        default:
            throw NetworkError.unknown
        }
    }
}
