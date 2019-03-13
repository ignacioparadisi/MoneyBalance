//
//  AccountTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var currentAccountImageView: UIImageView!
    private var currency: Currency = Currency()
    private var isCurrentAccount: Bool = false {
        didSet {
            setSelectedState()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        currentAccountImageView.backgroundColor = .clear
        currentAccountImageView.layer.borderWidth = 1
        currentAccountImageView.layer.borderColor = ThemeManager.currentTheme().accentColor.cgColor
        currentAccountImageView.layer.cornerRadius = 15
    }
    
    func configureWith(currency: Currency) {
        self.currency = currency
        nameLabel.text = currency.currency
        moneyLabel.text = currency.country
        isCurrentAccount = currency.selected
    }
    
    /// Sets the selected state of the cell
    private func setSelectedState() {
        if isCurrentAccount {
            currentAccountImageView.image = UIImage(named: "checked")
            currentAccountImageView.setImageColor(color: ThemeManager.currentTheme().accentColor)
        } else {
            currentAccountImageView.image = nil
        }
    }
    
}
