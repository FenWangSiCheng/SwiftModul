//  FireProtectionClient
//
//  Created by wangsicheng on 2017/9/16.
//  Copyright © 2017年 Fenrir Chengdu Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

enum HUDStatus : Equatable {
    case success(status:String?)
    case error(status:String?)
    case status(status:String?)
    case dismiss
    static func ==(lhs: HUDStatus, rhs: HUDStatus) -> Bool {
        switch (lhs,rhs) {
            case (.success(let a), .success(let b)):
                return a == b
            case (.error(let a), .error(let b)):
                return a == b
            case (.status(let a), .status(let b)):
                return a == b
            case ((.dismiss),(.dismiss)):
                return true
            default:
                return false
        }
    }
}

struct HUD {
    
    public static let shared = HUD()
    
    private init(){
        setupHUD()
    }
    
    private func setupHUD(){
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    public func showSuccess(string:String?,delay:Double = 2){
        SVProgressHUD.setMinimumDismissTimeInterval(delay)
        SVProgressHUD.showSuccess(withStatus: string)
    }
    
    public func showError(string:String?,delay:Double = 2){
        SVProgressHUD.setMinimumDismissTimeInterval(delay)
        SVProgressHUD.showError(withStatus: string)
    }
    
    public func showTitle(string: String?, delay:Double = 2){
        SVProgressHUD.setMinimumDismissTimeInterval(delay)
        SVProgressHUD.showError(withStatus: string)
    }
    
    public func showStatus(string: String? = nil){
        SVProgressHUD.show(withStatus: string)
    }
    
    public func dismiss(delay : Double = 0.0){
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
}

extension HUD: ObserverType {
    
   public func on(_ event: Event<HUDStatus>) {
        switch event {
        case .next(let element):
            switch element {
            case .success(let status):
                showSuccess(string: status)
            case .error(let status):
                showError(string: status)
            case .status(let status):
                showStatus(string: status)
            case .dismiss:
                dismiss()
            }
        default:
            break
        }
    }
}

extension Observable {
    public func showStatus() -> Observable<Element> {
        return `do`(onError: { _ in HUD.shared.dismiss() },
                    onCompleted: { HUD.shared.dismiss() },
                    onSubscribed: {  HUD.shared.showStatus() })
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    
    public func showStatus() -> Single<Element> {
        return self.do(onSuccess: { (_) in
            HUD.shared.dismiss()
        }, onError: { (error) in
            HUD.shared.dismiss()
        }, onSubscribe: {
            HUD.shared.showStatus()
        }, onSubscribed: {
            HUD.shared.showStatus()
        })
    }
}


