//
//  CountryCurrencies.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class CountryCurrency: Object {
    
    // TODO: - Manejar que el UUID no se repita
    @objc dynamic var id: Int = 0
    @objc dynamic var country: String = ""
    @objc dynamic var identifier: String = ""
    @objc dynamic var currency: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
