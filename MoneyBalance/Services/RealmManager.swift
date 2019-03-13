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
            bs.name = "Bs. S"
            bs.identifier = "es_VE"
            add(bs)
            
            let usd = Currency()
            usd.id = 1
            usd.country = "Estados Unidos"
            usd.name = "USD"
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
        changeCurrency(currency)
    }
    
    func changeCurrency(_ currency: Currency) {
        if let selectedCurrency = getArray(ofType: Currency.self, filter: "selected == true") as? [Currency], selectedCurrency.count > 0 {
            try! database.write {
                selectedCurrency[0].selected = false
            }
        }
        try! database.write {
            currency.selected = true
        }
    }
    
    func deleteCurrency(_ currency: Currency) {
        try! database.write {
            currency.owned = false
            currency.selected = false
        }
    }
    
    // MARK: - DELETE
    
    func delete(_ object: Object) {
        try! database.write {
            database.delete(object)
        }
    }
    
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
