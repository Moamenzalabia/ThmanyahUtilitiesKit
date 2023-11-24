//
//  StringExtensions.swift
//  
//  Created by Moamen on 24/11/2023.
//

import UIKit

// MARK: - String Extensions
public extension String {
    
    /// Checks if String is valid email
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Checks if String is valid password
    var isValidPassword: Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return passwordTest.evaluate(with: self)
    }
    
    /// Return localized key string value
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    /// String number localize
    var needToLocalize: String {
        var str : String = self
        str = Language.isArabic ? str.replacedEnglishDigitsWithArabic : str
        return str
    }
    
    /// Replace arabic digits with english
    var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = [ "٠": "0", "١": "1", "٢": "2", "٣": "3", "٤": "4", "٥": "5",
                    "٦": "6", "٧": "7", "٨": "8", "٩": "9", "٬":"." ]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    /// Replace english digits with arabic
    var replacedEnglishDigitsWithArabic: String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "٤", "5" : "٥", "6" : "٦", "7" : "۷", "8" : "۸", "9" : "۹" ,".":"٬"]
        var str : String = self
        for (key,value) in numbersDictionary {
            if key != "-"{
                str =  str.replacingOccurrences(of: key, with: value)
            } else {
                str = "\(str)-"
            }
        }
        return str
    }
    
    /// Calculate String height
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    /// Calculate String width
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    /// Remove all spaces from string
    func removeAllSpaces()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }

    /// Trims white space and new line characters, returns a new string
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// split string using a spearator string, returns an array of string
    func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator).filter {
            !$0.trimmed().isEmpty
        }
    }
    
    /// split string with delimiters, returns an array of string
    func split(_ characters: CharacterSet) -> [String] {
        return self.components(separatedBy: characters).filter {
            !$0.trimmed().isEmpty
        }
    }

    /// Checking if String contains input with comparing options
    func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: find, options: compareOption) != nil
    }
    
    /// Converts String to Int
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Double
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Float
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Bool
    func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    /// Returns underlined NSAttributedString
    func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return underlineString
    }
    
    /// Returns hight of rendered string
    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
    }
    
    /// Returns NSAttributedString
    func color(_ color: UIColor) -> NSAttributedString {
        let colorString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
        return colorString
    }
    
    /// Returns NSAttributedString
    func colorSubString(_ subString: String, color: UIColor) -> NSMutableAttributedString {
        var start = 0
        var ranges: [NSRange] = []
        while true {
            let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
            if range.location == NSNotFound {
                break
            } else {
                ranges.append(range)
                start = range.location + range.length
            }
        }
        let attrText = NSMutableAttributedString(string: self)
        for range in ranges {
            attrText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return attrText
    }
    
    /// copy string to pasteboard
    func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }
    
    /// Remove HTML from string
    func removeHTML()->String{
        return self.replacingOccurrences(of:"<[^>]+>" , with: "", options: .regularExpression, range: nil)
    }

    func convertHtml() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtml()
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            return nil
        }
    }
}
