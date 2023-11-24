//
//  ButtonSecondaryStates.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

class ButtonSecondaryEnabledState: ButtonStateProtocol {
    var state: ButtonState = .enabled
    var backgroundColor: UIColor = .clear
    var textColor: UIColor = .blackColor
    var borderColor: UIColor = .clear
    var loadingAnimationColor: UIColor = .blackColor
}

class ButtonSecondaryDisabledState: ButtonStateProtocol {
    var state: ButtonState = .disabled
    var backgroundColor: UIColor = .clear
    var textColor: UIColor = .chimneySweepTwoColor
    var borderColor: UIColor = .clear
    var loadingAnimationColor: UIColor = .chimneySweepTwoColor
}

class ButtonSecondaryDangerState: ButtonStateProtocol {
    var state: ButtonState = .danger
    var backgroundColor: UIColor = .clear
    var textColor: UIColor = .alertErrorColor
    var borderColor: UIColor = .clear
    var loadingAnimationColor: UIColor = .alertErrorColor
}
