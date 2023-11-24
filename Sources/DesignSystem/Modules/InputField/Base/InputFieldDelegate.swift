//
//  InputFieldDelegate.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

public protocol InputFieldDelegate: AnyObject {
    func beginEditing(view: InputFieldView)
    func endEditing(view: InputFieldView)
    func textFieldChanged(with text: String?, view: InputFieldView)
}

public extension InputFieldDelegate {
    func textFieldChanged(with text: String?, view: InputFieldView) {}
}
