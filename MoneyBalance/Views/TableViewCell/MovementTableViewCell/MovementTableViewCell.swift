//
//  MovementTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import SwipeCellKit

class MovementTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var movementTypeImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryBackgroundView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var amountLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabelLeadingConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        textLabel?.textColor = ThemeManager.currentTheme().textColor
        categoryBackgroundView.backgroundColor = .clear
        categoryBackgroundView.layer.cornerRadius = 10
    }
    
    func configureWith(movement: Movement) {
        if let currency = Currency.current {
            amountLabel.text = movement.amount.toCurrency(with: currency.identifier)
            var image: UIImage?
            if movement.type == Movement.MovementType.income.rawValue {
                image = UIImage(named: "income")?.withRenderingMode(.alwaysTemplate)
                movementTypeImage.tintColor = UIColor("#52C6A7")
            } else {
                image = UIImage(named: "outcome")?.withRenderingMode(.alwaysTemplate)
                movementTypeImage.tintColor = UIColor("FD582F")
            }
            movementTypeImage.image = image
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateLabel.text = dateFormatter.string(from: movement.date)
            dateLabel.textColor = ThemeManager.currentTheme().placeholderColor
            
            if let category = movement.category {
                let image = UIImage(named: category.image)?.withRenderingMode(.alwaysTemplate)
                categoryImageView.image = image
                categoryImageView.tintColor = .white
                categoryBackgroundView.backgroundColor = UIColor(category.color)
                amountLabelLeadingConstraint.constant = 16
                dateLabelLeadingConstraint.constant = 16
            } else {
                amountLabelLeadingConstraint.constant = (categoryBackgroundView.frame.width) * -1
                dateLabelLeadingConstraint.constant = (categoryBackgroundView.frame.width) * -1
            }
        }
    }
}
