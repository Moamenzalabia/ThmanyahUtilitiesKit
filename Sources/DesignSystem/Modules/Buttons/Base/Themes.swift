//
//  Themes.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation
import Foundation

class ButtonPrimaryTheme: ButtonThemeProtocol {
    var theme: ButtonTheme = .primary
    var borderWidth: CGFloat = 0.0
    var cornerRadius: CGFloat = 8
}

class ButtonSecondaryTheme: ButtonThemeProtocol {
    var theme: ButtonTheme = .secondary
    var borderWidth: CGFloat = 0.0
    var cornerRadius: CGFloat = 0
}
