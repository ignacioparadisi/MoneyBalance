//
//  AddAccountViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AddAccountViewControllerDelegate {
    func accountCreated()
}

class AddAccountViewController: AddViewController {
    
    private lazy var nameTitleLabel: TitleLabel = TitleLabel()
    private lazy var nameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        return label
    }()
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.returnKeyType = .next
        return textField
    }()
    private lazy var accountNumberTitleLabel: TitleLabel = TitleLabel()
    private lazy var accountNumberTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        return textField
    }()
    var delegate: AddAccountViewControllerDelegate?

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Add Account".localized()
    }
    
    override func setupView() {
        super.setupView()
        nameTitleLabel.text = "Name".localized()
        nameDescriptionLabel.text = "Enter the name of the bank".localized()
        nameTextField.setPlaceholder("Bank name".localized())
        accountNumberTitleLabel.text = "Account Number".localized()
        accountNumberTextField.setPlaceholder("Account number".localized())
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        accountNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameTextField.delegate = self
        
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameDescriptionLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(accountNumberTitleLabel)
        contentView.addSubview(accountNumberTextField)
        
        nameTitleLabel.setConstraints(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        nameDescriptionLabel.setConstraints(topAnchor: nameTitleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: descriptionTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        nameTextField.setConstraints(topAnchor: nameDescriptionLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        accountNumberTitleLabel.setConstraints(topAnchor: nameTextField.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        accountNumberTextField.setConstraints(topAnchor: accountNumberTitleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        
        shouldEnabledButton()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        shouldEnabledButton()
    }
    
    override func shouldEnabledButton() {
        if !allFieldsAreFilled() && addButton.isEnabled {
            addButton.isEnabled = false
            addButton.layer.sublayers?.remove(at: 0)
            addButton.layer.cornerRadius = 10
            addButton.layer.masksToBounds = false
            addButton.backgroundColor = ThemeManager.currentTheme().disabledButtonBackgroundColor
            return
        } else if allFieldsAreFilled() && !addButton.isEnabled {
            addButton.backgroundColor = .clear
            addButton.isEnabled = true
            addButton.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor, cornerRadius: 10)
        }
    }
    
    private func allFieldsAreFilled() -> Bool {
        return nameTextField.text != "" && accountNumberTextField.text != ""
    }
    
    override func addButtonAction(_ sender: Any) {
        let account = Account()
        account.bankName = nameTextField.text ?? ""
        account.number = accountNumberTextField.text ?? ""
        account.currency = Currency.current
        RealmManager.shared.add(account)
        dismissPanel()
        NotificationCenter.default.post(name: .didCreateAccount, object: nil)
        // delegate?.accountCreated()
    }

}

extension AddAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            accountNumberTextField.becomeFirstResponder()
        }
        return true
    }
}
