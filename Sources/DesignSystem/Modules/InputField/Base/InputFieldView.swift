//
//  InputFieldView.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit
import UtilitiesKit
import EasyConstraints

public enum InputFieldStateType {
    case `default`
    case disabled
    case error(message: String? = nil)
    case success(message: String? = nil)
}

public class InputFieldView: UIView, UITextFieldDelegate, InputTextFieldDelegate {
    
    // MARK: - Delegate Properties
    public weak var delegate: InputFieldDelegate?
    
    // MARK: - public Properties
    public var text: String? {
        get {
            return textField.text
        }
        set {
            delegate?.textFieldChanged(with: newValue, view: self)
            if newValue == nil { return }
            if !isRightButtonAppear { isRightButtonAppear = true }
            textField.text = newValue
        }
    }
    
    // MARK: - Internal Properties
    var inputFieldState: InputFieldStateType?
    var inputText: String?
    var inputFieldBorderColorWhileWriting: UIColor?
    
    var viewModel: InputFieldViewModel? {
        willSet {
            guard let viewModel = newValue else { return }
            inputFieldTitleTextColor = viewModel.inputFieldTitleTextColor
            inputFieldTitleFont = viewModel.inputFieldTitleFont
            inputFieldFont = viewModel.inputFieldFont
            inputFieldTextColor = viewModel.inputFieldTextColor
            inputFieldMessageFont = viewModel.inputFieldMessageFont
            inputFieldBorderColor = viewModel.borderColor
            inputFieldBorderColorWhileWriting = viewModel.borderColorWhileWriting
            rightIcon = viewModel.rightIconImage
            textAlignment = viewModel.textAlignment
        }
    }
    
    var inputFieldTitleText: String? {
        didSet {
            titleLabel.text = inputFieldTitleText
        }
    }
    
    var inputFieldPlaceHolder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: inputFieldPlaceHolder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.chimneySweepFourColor, .font: UIFont.Body3])
        }
    }
    
    var rightIcon: UIImage? {
        didSet {
            setRightImageView()
        }
    }
    
    var inputFieldMessage: String? {
        didSet {
            configureMessageLabel(message: inputFieldMessage)
        }
    }
    
    var isRightButtonAppear = false {
        willSet {
            rightImageView.isHidden = !newValue
        }
    }
    
    // MARK: - Private Properties
    private var inputFieldTitleTextColor: UIColor? {
        didSet {
            titleLabel.textColor = inputFieldTitleTextColor
        }
    }
    
    private var inputFieldTitleFont: UIFont? {
        didSet {
            titleLabel.font = inputFieldTitleFont
        }
    }
    
    private var inputFieldFont: UIFont? {
        didSet {
            textField.font = inputFieldFont
        }
    }
    
    private var inputFieldTextColor: UIColor? {
        didSet {
            textField.textColor = inputFieldTextColor
        }
    }
    
    private var textAlignment: NSTextAlignment? {
        didSet {
            if let textAlignment = textAlignment {
                titleLabel.textAlignment = textAlignment
                textField.textAlignment = textAlignment
                messageLabel.textAlignment = textAlignment
            }
        }
    }
    
    private var inputFieldBorderColor: UIColor? {
        didSet {
            if let inputFieldBorderColor = inputFieldBorderColor {
                horizontalStackView.layer.borderColor = inputFieldBorderColor.cgColor
            }
        }
    }
    
    private var inputFieldMessageColor: UIColor? {
        didSet {
            messageLabel.textColor = inputFieldMessageColor
            messageIcon.tintColor = inputFieldMessageColor
        }
    }
    
    private var inputFieldMessageFont: UIFont? {
        didSet {
            messageLabel.font = inputFieldMessageFont
        }
    }
    
    // MARK: - Computed Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setHeight(24)
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textField,
            rightImageView
        ])
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        stackView.axis = .horizontal
        stackView.setHeight(55)
        return stackView
    }()
    
    lazy var textField: InputTextField = {
        let textInput = InputTextField()
        textInput.delegate = self
        textInput.inputTextFieldDelegate = self
        textInput.tintColor = .haileyBlueColor
        return textInput
    }()
    
    private lazy var rightImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.setWidth(40)
        return view
    }()
    
    private lazy var rightImageIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var messageContentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageLabel, messageIcon])
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.isHidden = true
        stackView.setHeight(20)
        return stackView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var messageIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.setWidth(12)
        image.setHeight(12)
        return image
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            horizontalStackView,
            messageContentStack
        ])
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupSubViews() {
        addSubview(verticalStack)
        rightImageView.addSubview(rightImageIcon)
    }
    
    private func setupConstraints() {
        verticalStack.edgesToSuperView()
        rightImageIcon.centerHorizontally()
        rightImageIcon.centerVertically()
    }
    
    private func setRightImageView() {
        if let icon = rightIcon {
            rightImageIcon.image = icon
            rightImageView.isHidden = false
            rightImageView.isUserInteractionEnabled = true
            rightImageView.addTapGesture(target: self, action: #selector(rightImageViewDidTap))
        } else {
            rightImageView.isHidden = true
            rightImageView.isUserInteractionEnabled = false
        }
        rightImageView.isHidden = !isRightButtonAppear
    }
    
    private func setDefaultState() {
        guard let viewModel = viewModel else { return }
        horizontalStackView.layer.borderColor = viewModel.borderColor?.cgColor
        inputFieldBorderColorWhileWriting = viewModel.borderColorWhileWriting
        inputFieldTitleTextColor = viewModel.inputFieldTitleTextColor
        inputFieldTextColor = viewModel.inputFieldTextColor
        textField.isEnabled = true
        isRightButtonAppear = true
        configureMessageLabel()
    }
    
    private func setDisableState() {
        guard let viewModel = viewModel else { return }
        horizontalStackView.layer.borderColor = viewModel.borderDisabledColor?.cgColor
        inputFieldBorderColorWhileWriting = viewModel.borderColorWhileWriting
        inputFieldTitleTextColor = viewModel.inputFieldDisabledTitleTextColor
        inputFieldTextColor = viewModel.inputFieldDisabledTextColor
        textField.isEnabled = false
        isRightButtonAppear = false
        configureMessageLabel()
    }
    
    private func setErrorState(errorMessage: String?) {
        guard let viewModel = viewModel else { return }
        inputFieldMessageColor = viewModel.inputFieldErrorTintColor
        horizontalStackView.layer.borderColor = viewModel.inputFieldErrorTintColor?.cgColor
        inputFieldTitleTextColor = viewModel.inputFieldTitleTextColor
        inputFieldTextColor = viewModel.inputFieldTextColor
        messageIcon.image = UIImage(named: "circle-info", in: .module, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        isRightButtonAppear = true
        configureMessageLabel(message: errorMessage)
    }
    
    private func setSuccessState(successMessage: String?) {
        guard let viewModel = viewModel else { return }
        inputFieldMessageColor = viewModel.inputFieldSuccessTintColor
        horizontalStackView.layer.borderColor = viewModel.inputFieldSuccessTintColor?.cgColor
        inputFieldTitleTextColor = viewModel.inputFieldTitleTextColor
        inputFieldTextColor = viewModel.inputFieldTextColor
        messageIcon.image = UIImage(named: "circle-check", in: .module, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        isRightButtonAppear = true
        configureMessageLabel(message: successMessage)
    }
    
    private func configureMessageLabel(message: String? = nil) {
        if let message = message {
            messageContentStack.isHidden = false
            messageLabel.text = message
        } else {
            messageContentStack.isHidden = true
        }
    }
    
    // MARK: - Public Methods
    public func changeState(to state: InputFieldStateType) {
        inputFieldState = state
        switch state {
        case .default:
            setDefaultState()
        case .disabled:
            setDisableState()
        case .error(message: let errorMessage):
            setErrorState(errorMessage: errorMessage)
        case .success(message: let message):
            setSuccessState(successMessage: message)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    // MARK: - Internal Method's
    @objc func rightImageViewDidTap() {
        textFieldChanged(with: nil)
    }
    
    // MARK: - InputTextFieldDelegate Method's
    func beginEditing() {
        rightImageView.isHidden = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.horizontalStackView.layer.borderColor = self.inputFieldBorderColorWhileWriting?.cgColor ?? UIColor.haileyBlueColor.cgColor
        }
        if (inputText?.count ?? 0) > 0 { return }
        delegate?.beginEditing(view: self)
    }
    
    func didEndEditing() {
        rightImageView.isHidden = true
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.horizontalStackView.layer.borderColor = self.viewModel?.borderColor?.cgColor ?? UIColor.chimneySweepFourColor.cgColor
        }
        delegate?.endEditing(view: self)
    }
    
    func textFieldChanged(with text: String?) {
        delegate?.textFieldChanged(with: text, view: self)
        if text ?? "" != "" && isRightButtonAppear == false {
            isRightButtonAppear = true
        } else if text ?? "" == "" && isRightButtonAppear == true {
            isRightButtonAppear = false
        }
    }
}


