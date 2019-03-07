//
//  Account.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class Account: Object {
    
    @objc dynamic var currency: LocaleCurrency?
    @objc dynamic var money: Double = 0.0
    
}
