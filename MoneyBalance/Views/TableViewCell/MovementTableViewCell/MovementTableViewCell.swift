//
//  MovementTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MovementTableViewCell: UITableViewCell {

    @IBOutlet weak var movementTypeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        textLabel?.textColor = ThemeManager.currentTheme().textColor
    }
    
    func configureWith(movement: Movement) {
        if let currency = Currency.current {
            textLabel?.text = movement.amount.toCurrency(with: currency.identifier)
            var image: UIImage?
            if movement.type == Movement.MovementType.income.rawValue {
                image = UIImage(named: "income")?.withRenderingMode(.alwaysTemplate)
                movementTypeImage.tintColor = UIColor("#52C6A7")
            } else {
                image = UIImage(named: "outcome")?.withRenderingMode(.alwaysTemplate)
                movementTypeImage.tintColor = UIColor("FD582F")
            }
            movementTypeImage.image = image
            
        }
    }
}
