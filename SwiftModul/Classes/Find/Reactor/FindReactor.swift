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

let productInfolimitCount: Int = 10

final class FindReactor: Reactor {
    
    var page: Int = 0
    
    enum Action {
        case downRefresh(searchName: String?)
        case upRefresh(searchName: String?)
    }
    
    enum Mutation {
        case setAllItemsInfo([ProductInfoSectionModel])
        case appendItemsInfo([ProductInfoSectionModel])
    }
    
    struct State {
        var allItemsInfo: [ProductInfoSectionModel]
        var refreshStatus: BehaviorRelay<RefreshStatus>
    }
    
    let initialState: State
    
    init(refreshStatus: BehaviorRelay<RefreshStatus> ) {
        self.initialState = State(
            allItemsInfo: [],
            refreshStatus: refreshStatus
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .downRefresh(searchName: _):
            guard !isRefreshing() else {
                return Observable.empty()
            }
            page = 0
            currentState.refreshStatus.accept(.beingHeaderRefresh)
            return serviceManager.findService
                .getAllProducts(page: page)
                .asObservable()
                .map { [unowned self] (result) in
                    self.currentState.refreshStatus.accept(.endHeaderRefresh)
                    if result.count >= productInfolimitCount {
                        self.currentState.refreshStatus.accept(.endFooterRefresh)
                    }
                    return self.transformUIData(allItemsInfos: result)
                }
                .catchError({[unowned self] (_) -> Observable<FindReactor.Mutation> in
                    self.currentState.refreshStatus.accept(.endHeaderRefresh)
                    return Observable.empty()
                })
        case .upRefresh(searchName: _):
            guard !isRefreshing() else {
                return Observable.empty()
            }
            page += 1
            currentState.refreshStatus.accept(.beingFooterRefresh)
            return serviceManager.findService
                .getAllProducts(page: page)
                .asObservable()
                .map { [unowned self] (result) in
                    result.count < productInfolimitCount ? self.currentState.refreshStatus.accept(.noMoreData): self.currentState.refreshStatus.accept(.endFooterRefresh)
                    return self.transformUIData(allItemsInfos: result, isUpRefresh: true)
                }
                .catchError({ [unowned self]  (_) -> Observable<FindReactor.Mutation> in
                    self.currentState.refreshStatus.accept(.endFooterRefresh)
                    return Observable.empty()
                })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAllItemsInfo(let allItemsInfo):
            state.allItemsInfo = allItemsInfo
        case .appendItemsInfo(let allItemsInfo):
            state.allItemsInfo.append(contentsOf: allItemsInfo)
        }
        return state
    }
}

extension FindReactor {
    
    fileprivate func transformUIData(allItemsInfos: [ProductInfoModel], isUpRefresh: Bool = false) -> Mutation {
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
        return isUpRefresh ? Mutation.appendItemsInfo([ProductInfoSectionModel(data: data, header: "商品")]) : Mutation.setAllItemsInfo([ProductInfoSectionModel(data: data, header: "商品")])
    }
}

extension FindReactor {
    
    fileprivate func isRefreshing() -> Bool {

        return currentState.refreshStatus.value == .beingHeaderRefresh || currentState.refreshStatus.value == .beingFooterRefresh
    }
}
