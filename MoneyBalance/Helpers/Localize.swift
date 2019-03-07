//
//  Localize.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation

let LANGUAGE_KEY: String = "LanguageKey"

class Localize {
    
    private static var languageBundle: Bundle? = .main
    
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
    
    static func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: LANGUAGE_KEY)
        UserDefaults.standard.synchronize()
    }
    
    static func localizeString(_ string: String) -> String? {
        return languageBundle?.localizedString(forKey: string, value: nil, table: nil)
    }
}
