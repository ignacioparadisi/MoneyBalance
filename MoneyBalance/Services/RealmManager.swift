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
    
    func add(currency: Currency) {
        try! database.write {
            database.add(currency, update: true)
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
