//
//  AppDelegate.swift
//  SwiftModul
//
//  Created by fenrir-cd on 2018/5/16.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        initKeyboard()
        #if DEVELOP
        print("1")
        #elseif STAGING
        print("2")
        #elseif PRODUCTION
        print("3")
        #endif
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}

// MARK: - 私有方法
extension AppDelegate {

    fileprivate func initKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
}
