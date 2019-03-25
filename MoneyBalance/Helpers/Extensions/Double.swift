//
//  Double.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension Double {
    func toCurrency(with identifier: String) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale(identifier: identifier)
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        return currencyFormatter.string(from: NSNumber(value: self))
    }
}
