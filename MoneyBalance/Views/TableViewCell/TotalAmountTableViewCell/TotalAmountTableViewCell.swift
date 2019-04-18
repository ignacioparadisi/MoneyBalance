//
//  TotalAmountTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/28/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class TotalAmountTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        textLabel?.textColor = ThemeManager.currentTheme().textColor
        textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textLabel?.text = "Total".localized()
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
    }
    
    func configuereWith(amount: Double) {
        amountLabel.text = amount.toCurrency(with: Currency.current?.identifier ?? "en-US")
    }
    
}
