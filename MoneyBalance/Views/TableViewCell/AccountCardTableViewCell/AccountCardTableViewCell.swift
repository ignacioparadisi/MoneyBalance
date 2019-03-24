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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupView()
    }

    private func setupView() {
        bankNameLabel.textColor = .white
        bankNameLabel.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        amountLabel.textColor = .white
        amountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        amountLabel.text = 1000.00.toCurrency()
    }
    
}
