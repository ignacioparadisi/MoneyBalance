//
//  BankCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        bankNameLabel.textColor = .white
        bankNameLabel.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        amountLabel.textColor = .white
        amountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        amountLabel.text = 1000.00.toCurrency()
        accountNumberLabel.textColor = .white
    }
    
    func configureWith(account: Account) {
        bankNameLabel.text = account.bankName
        amountLabel.text = account.money.toCurrency()
        accountNumberLabel.text = account.number
    }

}
