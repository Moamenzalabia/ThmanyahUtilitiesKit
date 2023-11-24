//
//  EasyConstraints.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

extension UIView {
    // MARK: - Public Properties
    public typealias YAnchor = NSLayoutYAxisAnchor
    public typealias XAnchor = NSLayoutXAxisAnchor
    
    // MARK: - Public Methods
    public func edgesToSuperView(safeArea: Bool? = nil, padding: UIPadding? = nil) {
        guard let superView = superview else { return }
        let safeArea = safeArea ?? false
        if #available(iOS 11.0, *) {
            anchor(
                top: safeArea ? superView.safeAreaLayoutGuide.topAnchor : superView.topAnchor,
                bottom: safeArea ? superView.safeAreaLayoutGuide.bottomAnchor : superView.bottomAnchor,
                leading: safeArea ? superView.safeAreaLayoutGuide.leadingAnchor : superView.leadingAnchor,
                trailing: safeArea ? superView.safeAreaLayoutGuide.trailingAnchor : superView.trailingAnchor,
                padding: padding
            )
        } else {
            anchor(
                top: safeArea ? superView.topAnchor : superView.topAnchor,
                bottom: safeArea ? superView.bottomAnchor : superView.bottomAnchor,
                leading: safeArea ? superView.leadingAnchor : superView.leadingAnchor,
                trailing: safeArea ? superView.trailingAnchor : superView.trailingAnchor,
                padding: padding
            )
        }
    }
    
    public func edgesToSuperView(exclude anchorType: AnchorType, width: CGFloat? = nil, height: CGFloat? = nil, padding: UIPadding? = nil, safeArea: Bool? = nil) {
        guard let superview = superview else { return }
        let safeArea = safeArea ?? false
        let padding = UIPadding(top: padding?.top ?? 0, left: padding?.left ?? 0, bottom: padding?.bottom ?? 0, right: padding?.right ?? 0)
        switch anchorType {
        case .top:
            if #available(iOS 11.0, *) {
                anchor(
                    bottom:
                    safeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
                    leading: safeArea ? superview.safeAreaLayoutGuide.leadingAnchor :  superview.leadingAnchor,
                    trailing: safeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            } else {
                anchor(
                    bottom:
                    safeArea ? superview.bottomAnchor : superview.bottomAnchor,
                    leading: safeArea ? superview.leadingAnchor :  superview.leadingAnchor,
                    trailing: safeArea ? superview.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            }
        case .bottom:
            if #available(iOS 11.0, *) {
                anchor(
                    top: safeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
                    leading: safeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor,
                    trailing: safeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            } else {
                anchor(
                    top: safeArea ? superview.topAnchor : superview.topAnchor,
                    leading: safeArea ? superview.leadingAnchor : superview.leadingAnchor,
                    trailing: safeArea ? superview.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            }
        case .leading:
            if #available(iOS 11.0, *) {
                anchor(
                    top: safeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
                    bottom: safeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
                    trailing: safeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            } else {
                anchor(
                    top: safeArea ? superview.topAnchor : superview.topAnchor,
                    bottom: safeArea ? superview.bottomAnchor : superview.bottomAnchor,
                    trailing: safeArea ? superview.trailingAnchor : superview.trailingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            }
        case .trailing:
            if #available(iOS 11.0, *) {
                anchor(
                    top: safeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
                    bottom: safeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
                    leading: safeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            } else {
                anchor(
                    top: safeArea ? superview.topAnchor : superview.topAnchor,
                    bottom: safeArea ? superview.bottomAnchor : superview.bottomAnchor,
                    leading: safeArea ? superview.leadingAnchor : superview.leadingAnchor,
                    padding: padding,
                    width: width,
                    height: height
                )
            }
        }
    }
    
    public func edgesToSuperView(exclude anchorType: AnchorType, padding: UIPadding? = nil) {
        edgesToSuperView(exclude: anchorType, width: nil, height: nil, padding: padding, safeArea: nil)
    }
    
    public func anchor(top: YAnchor? = nil, bottom: YAnchor? = nil, leading: XAnchor? = nil, trailing: XAnchor? = nil, padding: UIPadding? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        let view = self
        turnAutoresizingMaskIntoConstraintsOff()
        
        if let top = top {
            view.topAnchor.constraint(equalTo: top, constant: padding?.top ?? 0).isActive = true
        }
        
        if let bottom = bottom {
            view.bottomAnchor.constraint(equalTo: bottom, constant:  -(padding?.bottom ?? 0)).isActive = true
        }
        
        if let leading = leading {
            view.leadingAnchor.constraint(equalTo: leading, constant: padding?.left ?? 0).isActive = true
        }
        
        if let trailing = trailing {
            view.trailingAnchor.constraint(equalTo: trailing, constant: -(padding?.right ?? 0)).isActive = true
        }
        
        if let width = width {
            setWidth(width)
        }
        
        if let height = height {
            setHeight(height)
        }
    }
    
    public func centerInSuperView(width: CGFloat? = nil, height: CGFloat? = nil, safeArea: Bool? = nil ) {
        let view = self
        if let width = width { setWidth(width) }
        if let height = height { setHeight(height) }
        view.centerHorizontally(constant: 0, safeArea: safeArea )
        view.centerVertically(constant: 0, safeArea: safeArea)
    }
    
    public func centerInSuperView(safeArea: Bool? = nil) {
        centerInSuperView(width: nil, height: nil, safeArea: safeArea)
    }
    
    public func centerHorizontally(constant: CGFloat = 0, safeArea: Bool? = nil) {
        guard let superView = superview else { return }
        turnAutoresizingMaskIntoConstraintsOff()
        let safeArea = safeArea ?? false
        if #available(iOS 11.0, *) {
            centerXAnchor.constraint(equalTo: safeArea ? superView.safeAreaLayoutGuide.centerXAnchor : superView.centerXAnchor , constant: constant).isActive = true
        } else {
            centerXAnchor.constraint(equalTo: safeArea ? superView.centerXAnchor : superView.centerXAnchor , constant: constant).isActive = true
        }
    }
    
    public func centerVertically(constant: CGFloat = 0, safeArea: Bool? = nil) {
        guard let superView = superview else { return }
        turnAutoresizingMaskIntoConstraintsOff()
        let safeArea = safeArea ?? false
        if #available(iOS 11.0, *) {
            centerYAnchor.constraint(equalTo: safeArea ? superView.safeAreaLayoutGuide.centerYAnchor : superView.centerYAnchor, constant: constant).isActive = true
        } else {
            centerYAnchor.constraint(equalTo: safeArea ? superView.centerYAnchor : superView.centerYAnchor, constant: constant).isActive = true
        }
    }
    
    public func set(width: CGFloat, height: CGFloat) {
        setWidth(width)
        setHeight(height)
    }
    
    public func setWidth(_ width: CGFloat) {
        turnAutoresizingMaskIntoConstraintsOff()
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    public func setHeight(_ height: CGFloat) {
        turnAutoresizingMaskIntoConstraintsOff()
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    public func turnAutoresizingMaskIntoConstraintsOff() {
        if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    }
    
}
