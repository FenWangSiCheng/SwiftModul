//
//  QRCodeScanTool.swift
//  PeiPeiPay
//
//  Created by wangsicheng on 2018/8/17.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import AVFoundation

typealias ResultBlock = ([String]?) -> Void

class QRCodeScanTool: NSObject {
    
    public static let shareInstance: QRCodeScanTool = QRCodeScanTool()
    
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.default(for: .video)
        return try? AVCaptureDeviceInput(device: device!)
    }()
    
    private lazy var output: AVCaptureMetadataOutput? = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    
    private lazy var session: AVCaptureSession? = {
        return AVCaptureSession()
    }()
    
    private var prelayer: AVCaptureVideoPreviewLayer?
    private var resultBlock: ResultBlock?
    
    // begin scan
    public func beginScanInView(view: UIView, result:@escaping ([String]?) -> Void) {
        
        resultBlock = result
        prelayer =  AVCaptureVideoPreviewLayer(session: self.session!)
        guard self.session != nil || self.output != nil || self.input != nil else {
            return
        }
        if self.session!.canAddInput(self.input!) && self.session!.canAddOutput(self.output!) {
            self.session!.addInput(self.input!)
            self.session!.addOutput(self.output!)
            self.output!.metadataObjectTypes = [.qr]
        } else {
            if resultBlock != nil {
                resultBlock!(nil)
            }
            return
        }
        
        if !view.layer.sublayers!.contains(self.prelayer!) {
            self.prelayer?.frame = view.layer.frame
            view.layer.insertSublayer(self.prelayer!, at: 0)
        }
        self.session!.startRunning()
    }
    
    // stop scan
    public func stopScan() {
        
        guard self.session != nil else {
            return
        }
        self.session!.stopRunning()
    }
    
    // set insteret rect
    public func setInsteretRect(originRect: CGRect) {
        guard self.output != nil else {
            return
        }
        let screenBounds = UIScreen.main.bounds
        let x = originRect.origin.x / screenBounds.origin.x
        let y = originRect.origin.y / screenBounds.origin.y
        let width = originRect.size.width / screenBounds.size.width
        let height = originRect.size.height / screenBounds.size.height
        self.output!.rectOfInterest = CGRect(x: y, y: x, width: width, height: height)
    }
    
    // remove device
    public func removeAllDevice() {
        guard self.session != nil || self.output != nil || self.input != nil else {
            return
        }
        self.session!.removeInput(self.input!)
        self.session!.removeOutput(self.output!)
    }
}

// MARK: AVCaptureMetadataOutputObjectsDelegate
extension QRCodeScanTool: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var resultStrs = [String]()
        metadataObjects.forEach { (obj) in
            if let obj = obj as? AVMetadataMachineReadableCodeObject {
                resultStrs.append(obj.stringValue ?? "")
            }
        }
        if resultBlock != nil {
            self.resultBlock!(resultStrs)
        }
    }
    
}
