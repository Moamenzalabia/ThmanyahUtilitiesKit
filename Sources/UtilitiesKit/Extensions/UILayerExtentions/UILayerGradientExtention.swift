//
//  UILayerGradientExtention.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

// MARK: - CAGradientLayer Extensions
public extension CAGradientLayer {
    
    convenience init(isVertical: Bool, frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        if isVertical{
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
        }else{
            startPoint = CGPoint.init(x: 0, y: 0.5)
            endPoint = CGPoint(x: 1, y: 0.5)
        }
    }
    
    convenience init(start: CGPoint, end: CGPoint, frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = start
        endPoint = end
    }
    
    func createGradientImage() -> UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
