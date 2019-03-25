//
//  BankCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountCollectionViewCellDelegate {
    func shareAccount(_ text: String)
}

class AccountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    private var account: Account = Account()
    var delegate: AccountCollectionViewCellDelegate?
    
    
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
        amountLabel.text = 1000.00.toCurrency(with: "en_US")
        accountNumberLabel.textColor = .white
        let shareImage = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)
        shareButton.setImage(shareImage, for: .normal)
        shareButton.tintColor = .white
        shareButton.layer.cornerRadius = 17.5
        shareButton.layer.masksToBounds = false
        shareButton.backgroundColor = UIColor(white: 0, alpha: 0.3)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
    }
    
    func configureWith(account: Account) {
        self.account = account
        bankNameLabel.text = account.bankName
        amountLabel.text = account.money.toCurrency(with: account.currency?.identifier ?? "en_US") 
        accountNumberLabel.text = account.number
    }
    
    @objc private func shareButtonAction() {
        let text = "Name".localized() + ": \n"
            + "ID".localized() + ": \n"
            + "Email".localized() + ": \n"
            + "Bank".localized() + ": \(account.bankName)\n"
            + "Account number".localized() + ": \(account.number)\n"
        delegate?.shareAccount(text)
    }

}
