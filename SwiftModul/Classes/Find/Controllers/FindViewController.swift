//
//  FindViewController.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import EmptyDataSet_Swift
import ReactorKit
import CoreLocation

class FindViewController: BaseViewController, StoryboardView, Refreshable {
    
    var refreshStatus: BehaviorRelay<RefreshStatus> = .init(value: .none)

    typealias Reactor = FindReactor
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        getNetData()
    }
    
    func bind(reactor: FindReactor) {
        
        reactor.state.map { $0.allItemsInfo }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
    
}

extension FindViewController {
    
    fileprivate func setUI() {

        setReactor()
        setTableView()
        setRefresh()
    }

    fileprivate func setReactor() {
        
        reactor = FindReactor(refreshStatus: refreshStatus)
    }

    private func setTableView() {
        
        if #available(iOS 11.0, *) {
            tableView.estimatedRowHeight = 0.01
            tableView.estimatedSectionHeaderHeight = 0.01
            tableView.estimatedSectionFooterHeight = 0.01
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        tableView.rowHeight = 150
    }

    private func setRefresh() {

        refreshStatusBind(to: tableView, headerClosure: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.reactor?.action.onNext(.downRefresh(searchName: nil))
        }, footerClosure: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.reactor?.action.onNext(.upRefresh(searchName: nil))
        }).disposed(by: disposeBag)
    }
    
    fileprivate func dataSource() -> RxTableViewSectionedReloadDataSource<ProductInfoSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ProductInfoSectionModel>(configureCell: { _, tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(FindTableViewCell.self, for: indexPath)
            cell.configureCell(data: model)
            return cell
        })
        return dataSource
    }
}

extension FindViewController {

    fileprivate func getNetData() {

        tableView.mj_header?.beginRefreshing()
    }
}
