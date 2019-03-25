//
//  Account.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class Currency: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var country: String = ""
    @objc dynamic var identifier: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var selected: Bool = false
    @objc dynamic var owned: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static var current: Currency? = nil
    
    static func setCurrent(_ currency: Currency) {
        RealmManager.shared.changeCurrency(currency)
        current = currency
    }
    
}
