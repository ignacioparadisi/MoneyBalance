//
//  TitleTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/28/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        textLabel?.textColor = ThemeManager.currentTheme().textColor
    }
    
    func configuereWith(title: String) {
        textLabel?.text = title
    }
    
}
