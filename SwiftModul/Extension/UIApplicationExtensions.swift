import UIKit

extension UIApplication {

    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

    static var topVC: UIViewController {
        let rootVC = shared.delegate?.window??.rootViewController
        return topViewController(rootViewController: rootVC!)
    }

    private static func topViewController(rootViewController: UIViewController) -> UIViewController {
        if let navi = rootViewController as? UINavigationController,
            let visibleVC = navi.visibleViewController {
            return topViewController(rootViewController: visibleVC)
        }
        let presentedVC = rootViewController.presentedViewController
        if presentedVC != nil {

            return topViewController(rootViewController: presentedVC!)
        }
        return rootViewController
    }
}
