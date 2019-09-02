//
//  FPWebViewController.swift
//  FireProtectionClient
//
//  Created by wangsicheng on 2018/03/26.
//  Copyright © 2018年 wangsicheng. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa

class FPWebViewController: BaseViewController {
    @IBOutlet weak var webBgView: UIView!
    
    var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var url: URL? {
        didSet {
            if let url = url {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webBgView.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.center.equalTo(self.webBgView)
            make.width.height.equalTo(self.webBgView)
        }
        webView.navigationDelegate = self
    }
    
    func reloadStatus() {
        backButton.isEnabled = webView.canGoBack
        nextButton.isEnabled = webView.canGoForward
    }
    
    @IBAction func backAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension FPWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        reloadStatus()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        reloadStatus()
        webView.evaluateJavaScript("document.title") {[weak self] (response, _) in
            if let titleStr = response as? String {
                self?.title = titleStr
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        reloadStatus()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
}
