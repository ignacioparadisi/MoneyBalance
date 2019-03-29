//
//  NameMoneyTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/28/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class NameMoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        textLabel?.textColor = ThemeManager.currentTheme().textColor
        amountLabel.textColor = ThemeManager.currentTheme().textColor
    }
    
    func configureWith(account: Account) {
        textLabel?.text = account.bankName
        amountLabel.text = account.money.toCurrency(with: Currency.current?.identifier ?? "en-US")
    }
    
}
