//
//  InputTextField.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

class InputTextField: UITextField {
    
    // MARK: - Properties
    weak var inputTextFieldDelegate: InputTextFieldDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8))
    }
    
    // MARK: - Private Methods
    @objc private func editingDidBegin() {
        inputTextFieldDelegate?.beginEditing()
    }
    
    @objc private func editingDidEndEditing() {
        inputTextFieldDelegate?.didEndEditing()
    }
    
    @objc private func textFieldDidChange(textField:UITextField) {
        inputTextFieldDelegate?.textFieldChanged(with: textField.text)
    }
    
}
