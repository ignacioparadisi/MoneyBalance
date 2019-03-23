//
//  String.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension String {
    /// Localized a string
    ///
    /// - Returns: Localized string
    func localized() -> String {
        return Localize.localizeString(self) ?? ""
    }
}
