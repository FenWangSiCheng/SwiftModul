//
//  MomentsRepo.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift
import Network

protocol FindRepoType {
    var allProducts: ReplaySubject<[ProductInfoModel]> { get }
    func getAllProducts(page: Int) -> Single<[ProductInfoModel]> 
}

struct FindRepo: FindRepoType {
    static let shared: FindRepo = {
        return FindRepo()
    }()
    private(set) var allProducts: ReplaySubject<[ProductInfoModel]> = .create(bufferSize: 1)
    public func getAllProducts(page: Int) -> Single<[ProductInfoModel]> {
        return Network.instance.request(.getAllProducts(parameters: ["page": page])).map { $0.data }
    }
}
