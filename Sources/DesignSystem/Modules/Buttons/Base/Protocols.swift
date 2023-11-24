//
//  Protocols.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation
import UIKit

/// Button size interface
protocol ButtonSizeProtocol {
    var height: CGFloat { get }
    var font: UIFont { get }
}

/// Button theme interface
protocol ButtonThemeProtocol {
    var theme: ButtonTheme { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
}

/// Button state interface
protocol ButtonStateProtocol {
    var state: ButtonState { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var loadingAnimationColor: UIColor { get }
}
