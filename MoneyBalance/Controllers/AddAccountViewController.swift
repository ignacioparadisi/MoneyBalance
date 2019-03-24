//
//  AddAccountViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddAccountViewController: AddViewController {
    
    lazy var nameTextField: CustomTextField = CustomTextField()

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Add Account".localized()
    }
    
    override func setupView() {
        super.setupView()
        titleLabel.text = "Name".localized()
        descriptionLabel.text = "Enter the name of the bank".localized()
        contentView.addSubview(nameTextField)
        nameTextField.setConstraints(topAnchor: descriptionLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: 10, leadingConstant: 16, trailingConstant: -16)
    }

}
