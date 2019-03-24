//
//  AddViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/22/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        label.textColor = ThemeManager.currentTheme().textColor
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        return label
    }()

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        addButton.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        addButton.setTitle("Add".localized(), for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        scrollView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        contentView.backgroundColor = .clear
        setupScrollViewSubviews()
    }
    
    func setupScrollViewSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        titleLabel.setConstraints(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: 20, leadingConstant: 16, trailingConstant: -16)
        descriptionLabel.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: 8, leadingConstant: 16, trailingConstant: -16)
    }

    @IBAction func addButtonAction(_ sender: Any) {
    }
}
