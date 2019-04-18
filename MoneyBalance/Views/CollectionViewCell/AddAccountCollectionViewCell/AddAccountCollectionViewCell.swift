//
//  AddAccountCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddAccountCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.text = "Add a new account".localized()
        textLabel.textColor = .lightGray // ThemeManager.currentTheme().lightTextColor
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }

}
