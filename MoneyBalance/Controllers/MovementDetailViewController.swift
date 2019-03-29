//
//  MovementDetailViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/26/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MovementDetailViewController: BaseViewController {
    
    internal let titleTopConstant: CGFloat = 20
    internal let descriptionTopConstant: CGFloat = 5
    internal let textFieldTopConstant: CGFloat = 10
    internal let leadingConstant: CGFloat = 16
    internal let trailingConstant: CGFloat = -16
    var movement: Movement = Movement()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    lazy var cardView = UIView()
    lazy var typeImageView = UIImageView()
    lazy var amountLabel = TitleLabel()
    lazy var descriptionLabel = UILabel()
    lazy var dateLabel = UILabel()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Detail".localized()
    }
    
    override func setupView() {
        super.setupView()
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupCardView()
        setupDateSection()
        // setupImageViewSection()
        setupDescriptionLabel()
        setupAmountSection()
        if cardView.frame.height > view.frame.height {
            cardView.setConstraints(bottomAnchor: contentView.bottomAnchor, bottomConstant: -titleTopConstant)
        }
    }
    
    private func setupCardView() {
        cardView.backgroundColor = .clear
        cardView.backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = false
        contentView.addSubview(cardView)
        cardView.setConstraints(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        
    }
    
    private func setupDateSection() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(for: movement.date)
        dateLabel.textColor = ThemeManager.currentTheme().textColor
        dateLabel.textAlignment = .right
        
        cardView.addSubview(dateLabel)
        dateLabel.setConstraints(topAnchor: cardView.topAnchor, leadingAnchor: cardView.leadingAnchor, trailingAnchor: cardView.trailingAnchor, topConstant: 16, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
    }
    
    private func setupImageViewSection() {
        var image = UIImage()
        if let type = movement.type {
            if type == Movement.MovementType.income.rawValue {
                image = UIImage(named: "income")!.withRenderingMode(.alwaysTemplate)
            } else {
                image = UIImage(named: "outcome")!.withRenderingMode(.alwaysTemplate)
            }
            typeImageView = UIImageView(image: image)
            typeImageView.tintColor = type == Movement.MovementType.income.rawValue ? UIColor("#52C6A7") : UIColor("FD582F")
        }
        cardView.addSubview(typeImageView)
        typeImageView.setConstraints(topAnchor: dateLabel.topAnchor, centerXAnchor: cardView.centerXAnchor, topConstant: titleTopConstant, widthConstant: 100, heightConstant: 100)
    }
    
    private func setupDescriptionLabel() {
        let title = TitleLabel()
        title.text = "Description".localized()
        
        descriptionLabel.text = movement.movDescription
        descriptionLabel.textColor = ThemeManager.currentTheme().textColor
        descriptionLabel.numberOfLines = 0
        
        cardView.addSubview(title)
        cardView.addSubview(descriptionLabel)
        
        title.setConstraints(topAnchor: dateLabel.bottomAnchor, leadingAnchor: cardView.leadingAnchor, trailingAnchor: cardView.trailingAnchor, topConstant: 20, leadingConstant: 10, trailingConstant: -10)
        descriptionLabel.setConstraints(topAnchor: title.bottomAnchor, leadingAnchor: cardView.leadingAnchor, trailingAnchor: cardView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: 10, trailingConstant: -10)
    }
    
    private func setupAmountSection() {
        let container = UIView()
        container.backgroundColor = .clear
        
        amountLabel.textAlignment = .center
        if let account = movement.account, let currency = account.currency {
            amountLabel.text = movement.amount.toCurrency(with: currency.identifier)
        }
        
        cardView.addSubview(container)
        container.addSubview(amountLabel)
        
        container.setConstraints(topAnchor: descriptionLabel.bottomAnchor, leadingAnchor: cardView.leadingAnchor, bottomAnchor: cardView.bottomAnchor, trailingAnchor: cardView.trailingAnchor, topConstant: 30, leadingConstant: leadingConstant, bottomConstant: -30, trailingConstant: trailingConstant)
        
        amountLabel.setConstraints(leadingAnchor: container.leadingAnchor, trailingAnchor: container.trailingAnchor, centerXAnchor: container.centerXAnchor, centerYAnchor: container.centerYAnchor)

    }
    
}
