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
    
    @objc dynamic var id: Int = 0
    @objc dynamic var countryCurrency: CountryCurrency?
    @objc dynamic var selected: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
