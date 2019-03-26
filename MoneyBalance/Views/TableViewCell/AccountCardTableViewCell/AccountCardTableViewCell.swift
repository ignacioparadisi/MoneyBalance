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
        backgroundColor = ThemeManager.currentTheme().backgroundColor
        view.backgroundColor = .clear
    }
    
    func configureWith(account: Account) {
        view.configureWith(account: account)
    }
    
}

extension AccountCardTableViewCell: AccountCardViewDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
