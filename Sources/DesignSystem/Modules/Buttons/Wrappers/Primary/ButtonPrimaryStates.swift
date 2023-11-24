//
//  ButtonPrimaryStates.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit
import UtilitiesKit

class ButtonPrimaryEnabledState: ButtonStateProtocol {
    var state: ButtonState = .enabled
    var backgroundColor: UIColor = .blackColor
    var textColor: UIColor = .whiteColor
    var borderColor: UIColor = .blackColor
    var loadingAnimationColor: UIColor = .whiteColor
}

class ButtonPrimaryDisabledState: ButtonStateProtocol {
    var state: ButtonState = .disabled
    var backgroundColor: UIColor = .chimneySweepTwoColor
    var textColor: UIColor = .whiteColor
    var borderColor: UIColor = .chimneySweepTwoColor
    var loadingAnimationColor: UIColor = .whiteColor
}

class ButtonPrimaryDangerState: ButtonStateProtocol {
    var state: ButtonState = .danger
    var backgroundColor: UIColor = .alertErrorColor
    var textColor: UIColor = .whiteColor
    var borderColor: UIColor = .alertErrorColor
    var loadingAnimationColor: UIColor = .whiteColor
}
