//
//  AccountCardTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        cardView.backgroundColor = .clear
        bankNameLabel.textColor = .white
        bankNameLabel.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        amountLabel.textColor = .white
        amountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        amountLabel.text = 1000.00.toCurrency(with: "en_US")
        accountNumberLabel.textColor = .white
    }
    
    func configureWith(account: Account) {
        bankNameLabel.text = account.bankName
        amountLabel.text = account.money.toCurrency(with: account.currency?.identifier ?? "en_US")
        accountNumberLabel.text = account.number
    }
    
}
