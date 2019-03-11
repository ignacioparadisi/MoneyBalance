//
//  Utils.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/11/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation

class Utils {
    
    private static let AUTHENTICATION_KEY: String = "authenticationKey"
    
    static func isAuthenticationEnabled() -> Bool {
        if let isOn = (UserDefaults.standard.value(forKey: AUTHENTICATION_KEY) as AnyObject).boolValue {
            return isOn
        } else {
            return false
        }
    }
    
    static func changeAuthenticationStatus(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: AUTHENTICATION_KEY)
        UserDefaults.standard.synchronize()
    }
    
}
