//
//  DefaultTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectedValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .default
        selectedValueLabel.isHidden = true
        // selectedValueLabel.textColor = ThemeManager.currentTheme().lightTextColor
        selectedValueLabel.textColor = .lightGray
    }
    
    func configureWith(title: String, accessoryType: UITableViewCell.AccessoryType = .none, selectedValue: String? = nil) {
        titleLabel.text = title
        self.accessoryType = accessoryType
        if let value = selectedValue {
            selectedValueLabel.isHidden = false
            selectedValueLabel.text = value
        } else {
            selectedValueLabel.isHidden = true
        }
    }
}
