//
//  UIViewController+Extension.swift
//  FireProtectionClient
//  Created by wangsicheng on 2018/01/31.
//  Copyright © 2018年 Fenrir Chengdu Inc. All rights reserved.
//

import UIKit

extension UIViewController {

    var isModal: Bool {
        if let navi = navigationController {
            return navi.viewControllers.count == 1
        }
        return parent == nil
    }

    func dissmissOrPopViewController() {
        if isModal {
            navigationController != nil ? navigationController?.dismiss(animated: true, completion: nil) : dismiss(animated: true, completion: nil)
            return
        }
        navigationController?.popViewController(animated: true)
    }

}
