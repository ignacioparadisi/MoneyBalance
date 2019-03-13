//
//  Services.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private var database: Realm
    static let shared: RealmManager = RealmManager()
    
    private init() {
        database = try! Realm()
        print("Realm File: \(database.configuration.fileURL)")
    }
    
    // MARK: - CREATE
    
    func add(_ object: Object) {
        try! self.database.write {
            self.database.add(object)
        }
    }
    
    func createCurrencies() {
        if get(Currency.self).count == 0 {
            let bs = Currency()
            bs.id = 0
            bs.country = "Venezuela"
            bs.currency = "Bs. S"
            bs.identifier = "es_VE"
            add(bs)
            
            let usd = Currency()
            usd.id = 1
            usd.country = "Estados Unidos"
            usd.currency = "USD"
            usd.identifier = "en_US"
            add(usd)
        }
    }
    
    // MARK: - GET
    
    private func get(_ type: Object.Type) -> Results<Object> {
        let results: Results<Object> = database.objects(type)
        return results
    }
    
    func getArray(ofType type: Object.Type, filter: String? = nil) -> [Object] {
        var results = get(type)
        if let filt = filter {
            results = results.filter(filt)
        }
        return results.toArray(ofType: type) as [Object]
    }
    
    // MARK: - UPDATE
    
    func createCurrency(_ currency: Currency) {
        try! database.write {
            currency.owned = true
        }
    }
    
    // MARK: - DELETE
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
