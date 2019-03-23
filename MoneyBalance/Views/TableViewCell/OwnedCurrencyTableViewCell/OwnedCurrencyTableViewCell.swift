//
//  AccountTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol OwnedCurrencyTableViewCellDelegate {
    func deleteAccount(at index: Int)
}

class OwnedCurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var currentAccountImageView: UIImageView!
    private var currency: Currency = Currency()
    private var isCurrentAccount: Bool = false {
        didSet {
            setSelectedState()
        }
    }
    var delegate: OwnedCurrencyTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        currentAccountImageView.backgroundColor = .clear
        currentAccountImageView.layer.borderWidth = 1
        currentAccountImageView.layer.borderColor = ThemeManager.currentTheme().accentColor.cgColor
        currentAccountImageView.layer.cornerRadius = 15
        addLongPressRecognizer()
    }
    
    func configureWith(currency: Currency) {
        self.currency = currency
        nameLabel.text = currency.name
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
    
    private func addLongPressRecognizer() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(deleteAccount(recognizer:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc private func deleteAccount(recognizer: UILongPressGestureRecognizer) {
        delegate?.deleteAccount(at: tag)
    }
    
}
