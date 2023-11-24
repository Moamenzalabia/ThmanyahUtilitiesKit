//
//  UIImageExtensions.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

// MARK: - UIImage Extensions
public extension UIImage {
    
    /// Convenience init that takes color and size
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    
    /// Returns the image associated with the URL
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }
    
    /// Returns created image with color and size that you pass
    class func createColorImage(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    /// Flip image with upMirrored flipped Orientation
    func flipImage() -> UIImage?{
        if let _cgImag = self.cgImage {
            let flippedimg = UIImage(cgImage: _cgImag, scale:self.scale , orientation: UIImage.Orientation.upMirrored)
            return flippedimg
        }
        return nil
    }
    
    /// Flip image in Arabic Language
    func flipImageToArabic() -> UIImage? {
        if Language.isArabic {
            return self.flipImage()
        }
        return self
    }
    
    /// Flip image in English Language
    func flipImageToEnglish() -> UIImage? {
        if Language.isEnglish {
            return self.flipImage()
        }
        return self
    }
    
    /// Flip image with horizontally flipped Orientation
    func flipImage(with tintColor: UIColor? = nil, and image: UIImage?) -> UIImage? {
        guard var image = image else { return nil}
        if tintColor != nil {
            image = image.withRenderingMode(.alwaysTemplate)
        }
        return Language.isArabic ? image : image.withHorizontallyFlippedOrientation()
    }
    
}
