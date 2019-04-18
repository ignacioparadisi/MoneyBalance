//
//  MovementTypeCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/24/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MovementTypeCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        textLabel.textColor = .lightGray
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }

}
