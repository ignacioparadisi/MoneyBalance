//
//  Localize.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation

/// Key for getting the selected language from UserDefaults
let LANGUAGE_KEY: String = "LanguageKey"

class Localize {
    
    /// Bundle for selected language
    private static var languageBundle: Bundle? = .main
    
    /// Sets selected language Bundle from file
    static func verifyLanguage() {
        if UserDefaults.standard.value(forKey: LANGUAGE_KEY) == nil {
            setLanguage("Base")
        }
        let language = UserDefaults.standard.string(forKey: LANGUAGE_KEY)
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            languageBundle = Bundle(path: path)
        } else {
            languageBundle = Bundle(path: Bundle.main.path(forResource: "Base", ofType: "lproj")!)
        }
    
    }
    
    static func getSelectedLanguageName() -> String {
        if UserDefaults.standard.value(forKey: LANGUAGE_KEY) == nil {
            return "English".localized()
        }
        switch UserDefaults.standard.string(forKey: LANGUAGE_KEY) {
        case "en":
            return "English".localized()
        case "es-US":
            return "Spanish".localized()
        default:
            return "English".localized()
        }
    }
    
    /// Changes the selected language
    ///
    /// - Parameter language: Selected language
    static func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: LANGUAGE_KEY)
        UserDefaults.standard.synchronize()
    }
    
    /// Localizes a string with the selected language bundle
    ///
    /// - Parameter string: String key to be localized
    /// - Returns: Localized string
    static func localizeString(_ string: String) -> String? {
        return languageBundle?.localizedString(forKey: string, value: nil, table: nil)
    }
}
