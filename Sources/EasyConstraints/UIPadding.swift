//
//  UIPadding.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

// MARK: - UI Padding Types
public struct UIPadding {
    // MARK: - Public Properties
    public var top: CGFloat = 0
    public var bottom: CGFloat = 0
    public var left: CGFloat = 0
    public var right: CGFloat = 0
    
    // MARK: - Initialization
    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}
