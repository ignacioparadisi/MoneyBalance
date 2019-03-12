//
//  LocaleCurrency.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class LocaleCurrency: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var identifier: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
