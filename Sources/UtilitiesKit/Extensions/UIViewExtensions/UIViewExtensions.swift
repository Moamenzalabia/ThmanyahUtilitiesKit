//
//  UIViewExtensions.swift
//  
//  Created by Moamen on 24/11/2023.
//

import UIKit

// MARK: UIView Extensions
public extension UIView {
    /// Add shadow with color, radius, opacity
    func addShadowWith(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize = .zero) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    /// Add Shadow
    func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    /// Add corner radius
    func addCornerRadius(_ radius: CGFloat = 0) {
        if radius == 0 {
            layer.cornerRadius = frame.size.height / 2
        } else {
            layer.cornerRadius = radius
        }
        layer.masksToBounds = true
    }
    
    /// Add border with border width and color
    func addBorderWith(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    /// Rounded from specific side
    func roundedFromSide(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
    
    /// Rounded with border width, color and corner radius
    func rounded(borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
    }
    
    /// Add multiple subviews
    func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
}

// MARK: Gesture Extensions
public extension UIView {
    func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
