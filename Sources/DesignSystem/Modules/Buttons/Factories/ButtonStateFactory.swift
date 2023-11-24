//
//  ButtonStateFactory.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

class ButtonStateFactory {
    
    init() {}
    
    func createState(for state: ButtonState, and type: ButtonTheme) -> ButtonStateProtocol {
        switch state {
        case .enabled:
            switch type {
            case .primary:
                return ButtonPrimaryEnabledState()
            case .secondary:
                return ButtonSecondaryEnabledState( )
            }
        case .disabled:
            switch type {
            case .primary: return ButtonPrimaryDisabledState( )
            case .secondary: return ButtonSecondaryDisabledState()
            }
        case .danger:
            switch type {
            case .primary: return ButtonPrimaryDangerState()
            case .secondary: return ButtonSecondaryDangerState()
            }
        }
    }
}
