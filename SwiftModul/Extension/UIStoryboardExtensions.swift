//
//  UIStoryboard+Additions.swift
//  PrintDirect
//
//  Created by liofty on 2018/4/8.
//  Copyright © 2018年 liofty. All rights reserved.
//

import UIKit

protocol StoryboardIdentifierable: class {
    static var identifier: String { get }
}

extension StoryboardIdentifierable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {

    typealias VStoryboardable = UIViewController & StoryboardIdentifierable

    public enum Storyboard: String {
        case home
        case find
        case QRCode
        case sound
        case me
        var name: String {
            return rawValue.capitalized
        }
    }

    public convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }

    func instantiateViewController<T: VStoryboardable>(viewType: T.Type) -> T {
        guard let vc = self.instantiateViewController(withIdentifier: viewType.identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(viewType.identifier)")
        }
        return vc
    }

    class func instantiateViewController<T: VStoryboardable>(storyboard: Storyboard, viewType: T.Type) -> T {
        return UIStoryboard(storyboard).instantiateViewController(viewType: viewType)
    }
}
