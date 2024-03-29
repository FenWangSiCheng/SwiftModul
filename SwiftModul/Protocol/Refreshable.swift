//
//  Refreshable.swift
//  FireProtectionClient
//
//  Created by wangsicheng on 2018/5/16.
//  Copyright © 2018年 Fenrir Chengdu Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

protocol Refreshable {
    var refreshStatus: BehaviorRelay<RefreshStatus> { get }
}

extension Refreshable {
    func refreshStatusBind(to scrollView: UIScrollView, headerClosure header: (() -> Void)? = nil, footerClosure footer: (() -> Void)? = nil) -> Disposable {
        if let header = header {
            scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: header)
        }
        if let footer = footer {
            scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: footer)
        }
        return refreshStatus.subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                scrollView.mj_header?.beginRefreshing()
            case .endHeaderRefresh:
                scrollView.mj_header?.endRefreshing()
            case .beingFooterRefresh:
                scrollView.mj_footer?.beginRefreshing()
            case .endFooterRefresh:
                scrollView.mj_footer?.isHidden = false
                scrollView.mj_footer?.endRefreshing()
            case .noMoreData:
                scrollView.mj_footer?.endRefreshingWithNoMoreData()
            case .none:
                scrollView.mj_footer?.isHidden = true
            }
        })
    }
}
