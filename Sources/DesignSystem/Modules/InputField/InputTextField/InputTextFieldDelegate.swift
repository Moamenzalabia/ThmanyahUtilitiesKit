//
//  InputTextFieldDelegate.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

protocol InputTextFieldDelegate: AnyObject {
    func beginEditing()
    func didEndEditing()
    func textFieldChanged(with text: String?)
}
