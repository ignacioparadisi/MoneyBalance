//
//  BankCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountCollectionViewCellDelegate: class {
    func shareAccount(_ text: String)
}

class AccountCollectionViewCell: UICollectionViewCell, ReusableView {

    lazy var view = AccountCardView()
    weak var delegate: AccountCollectionViewCellDelegate?
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = .clear
        view.delegate = self
        addSubview(view)
        view.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor)
    }
    
    func configureWith(account: Account) {
        view.configureWith(account: account)
    }

}

extension AccountCollectionViewCell: AccountCardViewDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
