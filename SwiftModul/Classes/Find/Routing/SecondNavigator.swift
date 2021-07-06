//
//  SecondNavigator.swift
//  SwiftModul
//
//  Created by wangsicheng on 2021/6/30.
//  Copyright © 2021 fenrir-cd. All rights reserved.
//

import UIKit

class SecondNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String: String]) {
        let destinationViewController = UIStoryboard.instantiateViewController(storyboard: .find, viewType: SecondViewController.self)
        navigate(to: destinationViewController, from: viewController, using: .show)
    }
}
