//
//  FindReactor.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/8/30.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class FindReactor: Reactor {

    var page: Int = 1

    enum Action {
        case downRefresh(searchName: String?)
    }

    enum Mutation {
        case setAllItemsInfo([ProductInfoSectionModel])
    }

    struct State {
        var allItemsInfo: [ProductInfoSectionModel]
    }

    let initialState: State

    init() {
        self.initialState = State(
            allItemsInfo: []
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .downRefresh(searchName: _):
            return serviceManager.findService
                .getAllProducts(page: page)
                .asObservable()
                .map { self.transformUIData(allItemsInfos: $0) }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAllItemsInfo(let allItemsInfo):
            state.allItemsInfo = allItemsInfo
        }
        return state
    }
}

extension FindReactor {

    fileprivate func transformUIData(allItemsInfos: [ProductInfoModel]) -> Mutation {
        let data =  allItemsInfos.map { (allItemsInfo) -> ProductInfoModelUI in
            var item = ProductInfoModelUI()
            item.imageUrl = allItemsInfo.imageUrl
            item.name = allItemsInfo.name
            item.info = allItemsInfo.note
            item.salePrice = "售价:\(allItemsInfo.salePrice ?? 0)"
            item.repertory = "库存:\(allItemsInfo.count ?? 0)"
            item.originalPrice = CommonTools.shareInstance.addlineToLabelText(text: "原价:\(allItemsInfo.costPrice ?? 0)")
            return item
        }
        return Mutation.setAllItemsInfo([ProductInfoSectionModel(data: data, header: "商品")])
    }
}
