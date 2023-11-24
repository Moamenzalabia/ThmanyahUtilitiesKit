//
//  UITableViewExtensions.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit
import ViewAnimator

// MARK: - UITableView Extensions
public extension UITableView {
    
    /**
     * Call when you need to register UITableViewCell CellNib
     * - parameter cellClass: UITableViewCell Calss
     */
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: .main), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    /**
     * Call when you need to dequeue UITableViewCell and you can casting to any UITableViewCell
     */
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell") // this line for me as adevloper no a user to help me to know where is a problem becuse it block my code in this line to help me to detecte where is a problem
        }
        return cell
    }
    
    func didBottomAnimateScrolling() {
        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
        UIView.animate(views: self.visibleCells, animations: animations, completion: {})
    }
    
    func didFromZoomAnimation() {
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation, zoomAnimation], delay: 0.2)
    }
    
    func didZoomRotateAnimation() {
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        UIView.animate(views: self.visibleCells, animations: [zoomAnimation, rotateAnimation], duration: 0.5)
    }
    
    func didRightAnimateScrolling() {
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        UIView.animate(views: self.visibleCells, animations: [fromAnimation, zoomAnimation], delay: 0.2)
    }
}
