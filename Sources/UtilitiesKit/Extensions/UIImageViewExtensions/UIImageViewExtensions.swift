//
//  UIImageViewExtensions.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit
import Kingfisher

public enum PlaceholderImages: String {
    case def = ""
    public var image: UIImage? {
        return UIImage(named: rawValue, in: .module, compatibleWith: nil)
    }
}

// MARK: - UIImageView Kingfisher Extensions
public extension UIImageView {
    ///Download image data from image URL
    func loadImage(with url: String?,
                   placeholderImage: UIImage? = PlaceholderImages.def.image,
                   tintColor: UIColor? = nil,
                   shouldShowLoading: Bool = true,
                   defaultImageCompletion: ((Bool) -> ())? = nil) {
        guard let stringURL = url, !stringURL.isEmpty, let url = URL(string: stringURL) else {
            self.image = placeholderImage
            defaultImageCompletion?(true)
            return
        }
        self.kf.indicatorType = shouldShowLoading ? .activity : .none
        self.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [.transition(.fade(1)), .cacheOriginalImage],
            progressBlock: nil
        ) { result in
            switch result{
            case .success(let value) :
                DispatchQueue.main.async {
                    self.image = value.image
                }
                defaultImageCompletion?(false)
            case .failure(let error) :
                self.image = placeholderImage
                debugPrint("Failed Download Image ❌: ", error.localizedDescription)
                defaultImageCompletion?(true)
            }
        }
        if let tintColor = tintColor {
            self.tintColor = tintColor
            self.image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
}
