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
    
    func getCurrencies() -> [Currency]? {
        let results: Results<Currency> = database.objects(Currency.self)
        return results.toArray(ofType: Currency.self) as [Currency]
    }
    
    func add(_ object: Object) {
        try! self.database.write {
            self.database.add(object)
        }
    }
    
    func get(_ type: Object.Type) -> [Object] {
        let results: Results<Object> = database.objects(type)
        return results.toArray(ofType: type) as [Object]
    }
    
    func createCountryCurrencies() {
        if get(CountryCurrency.self).count == 0 {
            let bs = CountryCurrency()
            bs.id = 0
            bs.country = "Venezuela"
            bs.currency = "Bs. S"
            bs.identifier = "es_VE"
            add(bs)
            
            let usd = CountryCurrency()
            usd.id = 1
            usd.country = "Estados Unidos"
            usd.currency = "USD"
            usd.identifier = "en_US"
            add(usd)
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
