//
//  DateExtensions.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

// MARK: - Date Extensions
public extension Date {
    init?(fromString string: String, format: String, timezone: TimeZone = TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.locale = locale
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    /// Initializes Date from string returned from an http response, according to several RFCs / ISO
    init?(httpDateString: String) {
        if let date = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
            self = date
            return
        }
        
        if let date = Date(fromString: httpDateString, format: "dd-MM-yyyy'T'HH:mm:ss.SSSZ") {
            self = date
            return
        }
        
        return nil
    }
    
    func toString(format: String, locale: String = Locale.current.identifier) -> String {
        let dateFormatter = createDateFormatter(for: format, locale: locale)
        return dateFormatter.string(from: self)
    }
    
    /// CreateDateFormatter if formatter
    private func createDateFormatter(for format: String, locale: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter
    }
    
}
