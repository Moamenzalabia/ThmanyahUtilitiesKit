//
//  SimpleInputFieldView.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit
import UtilitiesKit

public class SimpleInputFieldView: InputFieldView {
    
    // MARK: - Properties
    var charactersLimit: Int
    
    // MARK: - Initializers
    public init(fieldTitle: String? = nil, placeholder: String? = nil, hintMessage: String? = nil, charactersLimit: Int = .max, keyboardType: UIKeyboardType = .default) {
        self.charactersLimit = charactersLimit
        super.init()
        inputFieldMessage = hintMessage
        inputFieldPlaceHolder = placeholder
        inputFieldTitleText = fieldTitle
        textField.keyboardType = keyboardType
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupAppearance() {
        viewModel = InputFieldViewModel(
            inputFieldTitleFont: .H3,
            inputFieldTitleTextColor: UIColor.haileyBlueColor,
            inputFieldDisabledTitleTextColor: UIColor.chimneySweepTwoColor,
            inputFieldFont: .H4,
            inputFieldTextColor: UIColor.chimneySweepColor,
            inputFieldDisabledTextColor: UIColor.chimneySweepTwoColor,
            inputFieldMessageFont: .H4,
            inputFieldErrorTintColor: UIColor.alertErrorColor,
            inputFieldSuccessTintColor: UIColor.whiteColor,
            borderColor: UIColor.chimneySweepThreeColor,
            borderDisabledColor: UIColor.chimneySweepThreeColor,
            borderColorWhileWriting: UIColor.haileyBlueColor,
            rightIconImage: UIImage(named: "clearSearch_icon", in: .module, compatibleWith: nil),
            textAlignment: Language.isArabic ? .right : .left)
    }
    
    override func rightImageViewDidTap() {
        super.rightImageViewDidTap()
        textField.text?.removeAll()
        textField.becomeFirstResponder()
    }
    
    public override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= charactersLimit
    }
}
