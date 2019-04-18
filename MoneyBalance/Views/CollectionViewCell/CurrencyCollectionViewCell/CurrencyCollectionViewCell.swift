//
//  CurrencyCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol CurrencyCollectionViewCellDelegate: class {
    func deleteCurrency(at index: Int)
}

class CurrencyCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: CurrencyCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteCurrency))
        addGestureRecognizer(longPressGesture)
    }
    
    func configuereWith(currency: Currency) {
        nameLabel.textColor = currency.selected ? .white : .black
        nameLabel.text = currency.name
        backgroundColor = currency.selected ? ThemeManager.currentTheme().accentColor : UIColor("DDDDDD")
    }
    
    @objc private func deleteCurrency() {
        delegate?.deleteCurrency(at: tag)
    }

}
