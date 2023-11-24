//
//  Fonts.swift
//
//  Created by Moamen on 24/11/2023.
//

import UIKit

extension UIFont {
    /// IBMPlexSansArabic, Bold, 22px
    public class var H1: UIFont {
        return UIFont(name: AppFonts.bold(), size: 20)!
    }
    
    /// IBMPlexSansArabic, Bold, 15px
    public class var H2: UIFont {
        return UIFont(name: AppFonts.bold(), size: 16)!
    }
    
    /// IBMPlexSansArabic, Bold, 12px
    public class var H3: UIFont {
        return UIFont(name: AppFonts.bold(), size: 12)!
    }
    
    /// IBMPlexSansArabic, Regular, 12px
    public class var H4: UIFont {
        return UIFont(name: AppFonts.regular(), size: 12)!
    }
    
    /// IBMPlexSansArabic, Bold, 12px
    public class var Body1: UIFont {
        return UIFont(name: AppFonts.light(), size: 12)!
    }
    
    /// IBMPlexSansArabic, Medium, 10px
    public class var Body2: UIFont {
        return UIFont(name: AppFonts.light(), size: 10)!
    }
    
    /// IBMPlexSansArabic, Regular, 8px
    public class var Body3: UIFont {
        return UIFont(name: AppFonts.light(), size: 8)!
    }
    
}

fileprivate struct AppFonts {
    static func bold() -> String {
        return TypoName.Bold.ar.rawValue
    }
    
    static func extraLight() -> String {
        return TypoName.ExtraLight.ar.rawValue
    }
    
    static func light() -> String {
        return TypoName.Light.ar.rawValue
    }
    
    static func medium() -> String {
        return TypoName.Medium.ar.rawValue
    }
    
    static func regular() -> String {
        return TypoName.Regular.ar.rawValue
    }
    
    static func semiBold() -> String {
        return TypoName.SemiBold.ar.rawValue
    }

    static func text() -> String {
        return TypoName.Text.ar.rawValue
    }
    
    static func thin() -> String {
        return TypoName.Thin.ar.rawValue
    }
}

fileprivate struct TypoName {

    fileprivate enum Bold: String {
        case ar = "IBMPlexSansArabic-Bold"
    }
    
    fileprivate enum ExtraLight: String {
        case ar = "IBMPlexSansArabic-ExtraLight"
    }
    
    fileprivate enum Light: String {
        case ar = "IBMPlexSansArabic-Light"
    }
    
    fileprivate enum Medium: String {
        case ar = "IBMPlexSansArabic-Medium"
    }
    
    fileprivate enum Regular: String {
        case ar = "IBMPlexSansArabic-Regular"
    }
    
    fileprivate enum SemiBold: String {
        case ar = "IBMPlexSansArabic-SemiBold"
    }
    
    fileprivate enum Text: String {
        case ar = "IBMPlexSansArabic-Thin"
    }
    
    fileprivate enum Thin: String {
        case ar = "IBMPlexSansArabic-Thin"
    }
}

public class Fonts {
    public class func registerFonts() {
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Bold", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-ExtraLight", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Light", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Medium", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Regular", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-SemiBold", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Text", fontExtension: "otf")
        UIFont.registerFont(bundle: .module, fontName: "IBMPlexSansArabic-Thin", fontExtension: "otf")
    }
}

extension UIFont {
    @discardableResult static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }
        return true
    }
}
