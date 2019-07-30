//
//  NetworkError.swift
//  
//
//  Created by wangsicheng on 2017/9/11.
//  Copyright © 2017年 Fenrir Inc. Chengdu. All rights reserved.
//

import Foundation
import Moya

enum NetworkError: Error, Equatable {

    // Unknown
    case unknown

    // Not connected to Internet
    case notConnectionToInternet

    // Cannot connect to server (DNS Failed,Timeout,etc.)
    case notReachedServer

    // Incorrect data returned from the server
    case incorrectDataReturned

    // 403 401 - Authentication failed
    case authenticationFailed

    // 503 - Server maintenance
    case serverMaintenance

    // 500 - Server error
    case serverError

    // 404 - Not found
    case notFound

    case response(message: String)

    init(error: Error) {
        if let moyaError = error as? MoyaError {
            switch moyaError {
            case .jsonMapping:
                self = .incorrectDataReturned
            case .statusCode(let response):
                switch response.statusCode {
                case 500...502, 504...505:
                    self = .serverError
                case 503:
                    self = .serverMaintenance
                case 404:
                    self = .notFound
                case 401:
                    self = .authenticationFailed
                default: self = .unknown
                }
            case .underlying(let nsError as NSError, _):
                switch nsError.code {
                case 500...502, 504...505:
                    self = .serverError
                case 503:
                    self = .serverMaintenance
                case 404:
                    self = .notFound
                case 401, 403:
                    self = .authenticationFailed
                default: self = .unknown
                }
            default:
                self = .response(message: moyaError.errorDescription!)
            }
        } else if let netWorkError = error as? NetworkError {
            self = netWorkError
        } else {
            self = .unknown
        }
    }
}
