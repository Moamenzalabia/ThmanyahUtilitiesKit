//
//  Language.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

public class Language {
    
    public class var currentLanguage: String {
        Bundle.main.preferredLocalizations[0]
    }
    
    public class var isArabic: Bool {
        currentLanguage == "ar"
    }
    
    public class var isEnglish: Bool {
        currentLanguage == "en"
    }
}
