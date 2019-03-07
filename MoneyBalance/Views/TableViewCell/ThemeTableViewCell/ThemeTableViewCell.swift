//
//  ThemeTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLabel.text = "Dark Theme".localized()
        if ThemeManager.currentTheme() == .light {
            themeSwitch.isOn = false
        } else {
            themeSwitch.isOn = true
        }
    }
    
    @IBAction func changeTheme(_ sender: UISwitch) {
        if sender.isOn {
            ThemeManager.applayTheme(.dark)
        } else {
            ThemeManager.applayTheme(.light)
        }
    }
    
}
