//
//  BaseTabarController.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/5/29.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

class BaseTabarController: UITabBarController {

    static let sharedInstance = BaseTabarController()
    
    /// add child VC
    ///
    /// - Parameter addVCBlock: callBack
    public class func tabBarControllerWithAddChildVCsBlock(addVCBlock: (_ tabbarVC: BaseTabarController) -> (Void)){
        let tabbarVC = BaseTabarController()
        addVCBlock(tabbarVC)
    }
    
    
    /// set chirld VC
    ///
    /// - Parameters:
    ///   - vc: viewController
    ///   - normalImageName:
    ///   - selectedImageName:
    ///   - isRequirednavController: 
    public func addChildVC(vc:UIViewController, normalImageName: String, selectedImageName: String, isRequirednavController: Bool) {
        if isRequirednavController {
            let nav = BaseNavigationController.init(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: nil, image: UIImage.originImageWithName(name: normalImageName), selectedImage: UIImage.originImageWithName(name: selectedImageName))
            self.addChild(nav)
        }else {
            self.addChild(vc)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
