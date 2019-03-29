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
        
        if let movement = object as? Movement, let account =  movement.account {
            var filter = "account.id == '\(account.id)' AND type == '\(Movement.MovementType.income.rawValue)'"
            let income = getSum(ofType: Movement.self, property: "amount", filter: filter)
            filter = "account.id == '\(account.id)' AND type == '\(Movement.MovementType.outcome.rawValue)'"
            let outcome = getSum(ofType: Movement.self, property: "amount", filter: filter)
            let balance = income - outcome
            try! self.database.write {
                account.money = balance
            }
        }
    }
    
    func createCurrencies() {
        if get(Currency.self).count == 0 {
            let bs = Currency()
            bs.country = "Venezuela"
            bs.name = "Bs. S"
            bs.identifier = "es_VE"
            add(bs)
            
            let usd = Currency()
            usd.country = "Estados Unidos"
            usd.name = "USD"
            usd.identifier = "en_US"
            add(usd)
        }
    }
    
    func createCategories() {
        if get(Category.self).count == 0 {
            let food = Category()
            food.name = "Food"
            food.image = "food"
            food.color = "F6946A"
            add(food)
            
            let car = Category()
            car.name = "Car"
            car.image = "car"
            car.color = "72BFFF"
            add(car)
            
            let utilities = Category()
            utilities.name = "Utilities"
            utilities.image = "utilities"
            utilities.color = "E198F7"
            add(utilities)
            
            let shopping = Category()
            shopping.name = "Shopping"
            shopping.image = "shopping"
            shopping.color = "F7C761"
            add(shopping)
            
            let shop = Category()
            shop.name = "Shop"
            shop.image = "shop"
            shop.color = "AA8AE9"
            add(shop)
            
            let health = Category()
            health.name = "Health"
            health.image = "health"
            health.color = "ED596F"
            add(health)
            
            let trip = Category()
            trip.name = "Trip"
            trip.image = "trip"
            trip.color = "7BCE70"
            add(trip)
        }
    }
    
    // MARK: - GET
    
    func get(_ type: Object.Type) -> Results<Object> {
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
    
    func getSum(ofType type: Object.Type, property: String, filter: String = "") -> Double {
        return get(type).filter(filter).sum(ofProperty: property)
    }
    
    func getMovements(filter: String) -> [Movement] {
        var results = get(Movement.self)
        results = results.filter(filter).sorted(byKeyPath: "date", ascending: false)
        return results.toArray(ofType: Movement.self) as [Movement]
    }
    // MARK: - UPDATE
    
    func createCurrency(_ currency: Currency) {
        try! database.write {
            currency.owned = true
        }
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
        if let movement = object as? Movement, let account =  movement.account {
            if movement.type == Movement.MovementType.income.rawValue {
                try! self.database.write {
                    account.money -= movement.amount
                }
            } else {
                try! self.database.write {
                    account.money += movement.amount
                }
            }
            
        }
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
