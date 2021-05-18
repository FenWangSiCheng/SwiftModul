//
//  BaseNavigationController.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/5/29.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gester = self.interactivePopGestureRecognizer
        let panGester = UIPanGestureRecognizer(target: gester?.delegate, action: NSSelectorFromString("handleNavigationTransition:"))
        gester?.view?.addGestureRecognizer(panGester)
        gester?.delaysTouchesBegan = true
        panGester.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.children.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(back))
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)

    }

    @objc
    private func back() {
        self.popViewController(animated: true)
    }

}

extension BaseNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        if self.children.count == 1 {
            return false
        }
        return true
    }

}
