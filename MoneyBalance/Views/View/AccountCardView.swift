//
//  AccountCardView.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountCardViewDelegate {
    func shareAccount( _ text: String)
}

class AccountCardView: UIView {

    var delegate: AccountCardViewDelegate?
    var amountLabel: TitleLabel = {
        let label = TitleLabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var bankNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        return label
    }()
    var accountNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let shareImage = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)
        button.setImage(shareImage, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = UIColor(white: 0, alpha: 0.3)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        backgroundColor = .clear
        
        setupSubviews()
        amountLabel.text = 1000.00.toCurrency(with: "en_US")
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        addSubview(amountLabel)
        amountLabel.setConstraints(leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, leadingConstant: 16, trailingConstant: -16)
        
        addSubview(bankNameLabel)
        bankNameLabel.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, topConstant: 16, leadingConstant: 16, trailingConstant: -16)
        
        addSubview(accountNumberLabel)
        accountNumberLabel.setConstraints(leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, leadingConstant: 16, bottomConstant: -16, trailingConstant: -16)
        
        addSubview(shareButton)
        shareButton.setConstraints(topAnchor: topAnchor, trailingAnchor: trailingAnchor, topConstant: 10, trailingConstant: -10, widthConstant: 30, heightConstant: 30)
    }
    
    
    @objc private func shareButtonAction() {
        let text = "Name".localized() + ": \n"
            + "ID".localized() + ": \n"
            + "Email".localized() + ": \n"
            + "Bank".localized() + ": \(bankNameLabel.text ?? "")\n"
            + "Account number".localized() + ": \(accountNumberLabel.text ?? "")\n"
        delegate?.shareAccount(text)
    }
    
}
