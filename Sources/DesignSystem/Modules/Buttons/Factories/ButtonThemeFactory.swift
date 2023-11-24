//
//  ButtonThemeFactory.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

class ButtonThemeFactory {
    
    init() {}
    
    func createTheme(for type: ButtonTheme) -> ButtonThemeProtocol {
        switch type {
        case .primary: return ButtonPrimaryTheme()
        case .secondary: return ButtonSecondaryTheme()
        }
    }
}
