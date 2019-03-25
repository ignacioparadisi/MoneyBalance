//
//  AccountCardTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountCardTableViewCellDelegate {
    func shareAccount(_ text: String)
}

class AccountCardTableViewCell: UITableViewCell {

    lazy var view = AccountCardView()
    var delegate: AccountCardTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        selectionStyle = .none
        view.delegate = self
        addSubview(view)
        view.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, topConstant: 20, leadingConstant: 20, bottomConstant: -20, trailingConstant: -20)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        view.backgroundColor = .clear
        view.bankNameLabel.textColor = .white
        view.bankNameLabel.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        view.amountLabel.textColor = .white
        view.amountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        view.amountLabel.text = 1000.00.toCurrency(with: "en_US")
        view.accountNumberLabel.textColor = .white
    }
    
    func configureWith(account: Account) {
        view.bankNameLabel.text = account.bankName
        view.amountLabel.text = account.money.toCurrency(with: account.currency?.identifier ?? "en_US")
        view.accountNumberLabel.text = account.number
    }
    
}

extension AccountCardTableViewCell: AccountCardViewDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
