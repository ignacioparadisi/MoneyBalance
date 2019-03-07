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
    
    @objc dynamic var account: Account?
    @objc dynamic var type: String?
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var movDescription: String?
    
}
