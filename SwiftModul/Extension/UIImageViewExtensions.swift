//
//  UIImageView-Extension.swift
//  LiveProduct
//
//  Created by abon on 2018/1/22.
//  Copyright © 2018年 kaito. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {

    /// 加载网络图片
    ///
    /// - Parameters:
    ///   - URLString: 网络图片url
    ///   - placeHolderName: 占位图片名
    public func setImage(_ URLString: String?, _ placeHolderName: String?) {
        guard let URLString = URLString else {
            return
        }

        guard let placeHolderName = placeHolderName else {
            return
        }

        guard let url = URL(string: URLString) else { return }
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }

}
