//
//  Category.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/24/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
