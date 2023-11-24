//
//  UIWindowExtensions.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
