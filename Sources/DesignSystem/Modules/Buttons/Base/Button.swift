//
//  Button.swift
//  
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

public class Button: UIButton {
    
    private var activityIndicatorView: UIActivityIndicatorView?
    private var sizeFactory: ButtonSizeFactory = ButtonSizeFactory()
    private var stateFactory: ButtonStateFactory = ButtonStateFactory()
    private var typeFactory: ButtonThemeFactory = ButtonThemeFactory()
    private var themeInfo: ButtonThemeProtocol?
    private var sizeInfo: ButtonSizeProtocol?
    private var stateInfo: ButtonStateProtocol?
    private var title: String?
    public var currentState: ButtonState {
        get {
            return stateInfo?.state ?? .enabled
        }
    }
    
    public var isAnimating: Bool {
        get {
            return activityIndicatorView?.isAnimating ?? false
        }
    }
    
    internal var height: CGFloat {
        get {
            return sizeInfo?.height ?? 0.0
        }
    }
    
    public init(theme: ButtonTheme = .primary, size: ButtonSize = .large, state: ButtonState = .enabled) {
        super.init(frame: .zero)
        themeInfo = typeFactory.createTheme(for: theme)
        sizeInfo = sizeFactory.createSize(for: size)
        stateInfo = stateFactory.createState(for: state, and: theme)
        build()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    public func setupButton(theme: ButtonTheme = .primary, size: ButtonSize = .large, state: ButtonState = .enabled) {
        themeInfo = typeFactory.createTheme(for: theme)
        sizeInfo = sizeFactory.createSize(for: size)
        stateInfo = stateFactory.createState(for: state, and: theme)
        build()
    }
    
    public func changeState(to state: ButtonState) {
        stateInfo = stateFactory.createState(for: state, and: themeInfo!.theme)
        buildState()
    }
    
    public func startAnimating() {
        buildActivityIndicatorIfNeeded()
        title = titleLabel?.text
        setTitle(nil, for: .normal)
        activityIndicatorView?.isHidden = false
        activityIndicatorView?.startAnimating()
    }
    
    public func stopAnimating() {
        setTitle(title, for: .normal)
        activityIndicatorView?.isHidden = true
        activityIndicatorView?.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func build() {
        layer.borderWidth = themeInfo?.borderWidth ?? 0.0
        layer.cornerRadius = themeInfo?.cornerRadius ?? 0.0
        titleLabel?.font = sizeInfo?.font
        heightAnchor.constraint(equalToConstant: sizeInfo?.height ?? 0.0).isActive = true
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        buildState()
    }
    
    private func buildState() {
        backgroundColor = stateInfo?.backgroundColor
        setTitleColor(stateInfo?.textColor, for: .normal)
        layer.borderColor = stateInfo?.borderColor.cgColor
        isEnabled = stateInfo?.state == .disabled ? false : true
    }
    
    private func buildActivityIndicatorIfNeeded() {
        if activityIndicatorView != nil {return}
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView?.isHidden = true
        addSubview(activityIndicatorView!)
        activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        activityIndicatorView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        activityIndicatorView?.color = stateInfo?.loadingAnimationColor
    }
}
