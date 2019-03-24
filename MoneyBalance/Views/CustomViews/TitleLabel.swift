//
//  TitleLabel.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/22/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func awakeFromNib() {
        initialize()
    }
    
    private func initialize() {
        font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        textColor = ThemeManager.currentTheme().textColor
    }
    
}
