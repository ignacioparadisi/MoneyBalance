//
//  Account.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class Account: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var money: Double = 0
    @objc dynamic var bankName: String = ""
    @objc dynamic var number: Double = 0
    @objc dynamic var currency: Currency?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
