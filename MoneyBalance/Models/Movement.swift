//
//  Movement.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class Movement: Object {
    
    enum MovementType: String {
        case income = "Income"
        case outcome = "Outcome"
    }
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var account: Account?
    @objc dynamic var type: String?
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var movDescription: String?
    @objc dynamic var date: Date = Date()
    @objc dynamic var category: Category?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
