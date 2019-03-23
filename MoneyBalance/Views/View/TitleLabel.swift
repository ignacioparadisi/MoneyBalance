//
//  TitleLabel.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/22/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    override func awakeFromNib() {
        font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 30.0)
    }
    
}
