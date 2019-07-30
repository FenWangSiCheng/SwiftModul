//
//  EmptyDataView.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/4/8.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EmptyDataView: UIView, NibLoadView {

    private var retryClickSubject: PublishSubject<Void> = PublishSubject<Void>()
    
    var retryClickOb: Observable<Void> {
        get {
           return retryClickSubject.asObserver()
        }
    }
    
    @IBOutlet weak var retryButton: UIButton!
    

}
