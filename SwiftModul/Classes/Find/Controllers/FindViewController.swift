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

class FindViewController: BaseViewController, Refreshable, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    let refreshStatus = BehaviorSubject(value: RefreshStatus.none)

    var dataSource: RxTableViewSectionedReloadDataSource<TestSectionModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension FindViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 150
    }
}
