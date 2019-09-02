//
//  PermissionTool.swift
//  PeiPeiPay
//
//  Created by fenrir-cd on 2018/8/17.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import Photos

class PermissionTool: NSObject {

    public static let shareInstance: PermissionTool = PermissionTool()

    public func requestCameraPermission(success:@escaping () -> Void, failure:@escaping () -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            success()
        default:
            failure()
        }
    }
}
