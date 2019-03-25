//
//  AccountCardView.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountCardView: UIView {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        backgroundColor = .clear
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
    
    @objc private func shareButtonAction() {
//        let text = "Name".localized() + ": \n"
//            + "ID".localized() + ": \n"
//            + "Email".localized() + ": \n"
//            + "Bank".localized() + ": \(account.bankName)\n"
//            + "Account number".localized() + ": \(account.number)\n"
//        delegate?.shareAccount(text)
    }
    
}
