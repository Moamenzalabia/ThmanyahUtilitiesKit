//
//  InputFieldsFactory.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

public enum InputFieldType {
    case simple(charactersLimit: Int = .max)
    
    public init?(_ type: String, charactersLimit: Int = .max) {
        switch type.lowercased() {
        case "simple":
            self = .simple(charactersLimit: charactersLimit)
        default: return nil
        }
    }
}

public class InputFieldsFactory {
    
    init() {}
    
    public static func createInputField(with type: InputFieldType, fieldTitle: String? = nil, placeholder: String? = nil, hintMessage: String? = nil, keyboardType: UIKeyboardType = .default) -> InputFieldView {
        switch type {
        case .simple(let charactersLimit):
            let inputView = SimpleInputFieldView(fieldTitle: fieldTitle, placeholder: placeholder, hintMessage: hintMessage, charactersLimit: charactersLimit, keyboardType: keyboardType)
            return inputView
        }
    }
}
