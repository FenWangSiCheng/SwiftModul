//
//  UITableVIewExtentions.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/8/30.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type.self, forCellReuseIdentifier: type.className)
    }

    func register<T: UITableViewCell>(_ type: T.Type) where T: NibLoadView {
        register(type.nib, forCellReuseIdentifier: type.className)
    }

    func registerHeaderFooterview<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type.self, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func registerHeaderFooterview<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: NibLoadView {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Couldn't find nib file for `\(type.className)`")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        let dequeueView = self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
        guard let headerFooterView = dequeueView else {
            fatalError("Couldn't find nib file for `\(type.className)`")
        }
        return headerFooterView
    }

}
