//
//  CategoryCollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/28/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
    
    func configureWith(category: Category) {
        let image = UIImage(named: category.image)?.withRenderingMode(.alwaysTemplate)
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        imageView.image = image
        imageView.tintColor = ThemeManager.currentTheme().placeholderColor
    }

}
