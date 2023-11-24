//
//  ButtonSizeFactory.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

class ButtonSizeFactory {
    
    init() {}
    
    func createSize(for size: ButtonSize) -> ButtonSizeProtocol {
        switch size {
        case .large: return ButtonLargeSize()
        case .medium: return ButtonMediumSize()
        case .small: return ButtonSmallSize()
        case .xSmall: return ButtonXSmallSize()
        }
    }
    
}
