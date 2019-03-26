//
//  ViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AddMovementViewControllerDelegate {
    func didCreateMovement()
}

class AddMovementViewController: AddViewController {
    
    private let movementTypes: [Movement.MovementType] = [.income, .outcome]
    private lazy var amountTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.keyboardType = .decimalPad
        return textField
    }()
    private var typeCollectionView: UICollectionView!
    private lazy var accountButton: PickButton = PickButton()
    private lazy var dateButton: PickButton = PickButton()
    private lazy var descriptionTextView: CustomTextView = CustomTextView()
    private var selectedTypeIndex = -1
    var selectedAccount: Account?
    private var selectedDate: Date?
    var delegate: AddMovementViewControllerDelegate?

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Add Movement".localized()
    }
    
    override func setupView() {
        super.setupView()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomBackgroundView.frame.height, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        setupAmountSection()
        setupMovementTypeSection()
        setupAccountSection()
        setupDateSection()
        setupDescriptionSection()
        shouldEnabledButton()
    }
    
    private func setupAmountSection() {
        let titleLabel: TitleLabel = TitleLabel()
        let descriptionLabel = UILabel()
        
        titleLabel.text = "Amount".localized()
        descriptionLabel.textColor = ThemeManager.currentTheme().textColor
        descriptionLabel.text = "Enter amount of money".localized()
        amountTextField.setPlaceholder("Amount of money".localized())
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(amountTextField)
        
        setupConstraints(for: amountTextField, titleTopConstraint: contentView.topAnchor, titleLabel: titleLabel, descriptionLabel: descriptionLabel)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        shouldEnabledButton()
    }
    
    private func setupMovementTypeSection() {
        let contentInsets: CGFloat = 20
        let collectionViewHeight: CGFloat = 50
        let titleLabel = TitleLabel()
        let descriptionLabel = UILabel()
        let layout = UICollectionViewFlowLayout()
        
        titleLabel.text = "Movement type".localized()
        descriptionLabel.textColor = ThemeManager.currentTheme().textColor
        descriptionLabel.text = "Select a movement type".localized()
        layout.itemSize = CGSize(width: view.frame.width / 2 - contentInsets - contentInsets / 2, height: collectionViewHeight)
        layout.minimumInteritemSpacing = 8
        typeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self
        typeCollectionView.backgroundColor = .clear
        typeCollectionView.contentInset = UIEdgeInsets(top: 0, left: contentInsets, bottom: 0, right: contentInsets)
        typeCollectionView.register(UINib(nibName: "MovementTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(typeCollectionView)
        
        setupConstraints(for: typeCollectionView, titleTopConstraint: amountTextField.bottomAnchor, titleLabel: titleLabel, descriptionLabel: descriptionLabel)
        typeCollectionView.setConstraints(heightConstant: collectionViewHeight)
    }
    
    
    private func setupAccountSection() {
        let titleLabel: TitleLabel = TitleLabel()
        
        titleLabel.text = "Account".localized()
        if let account = selectedAccount {
            accountButton.setTitle(account.bankName + " - " + account.number.suffix(4), for: .normal)
        } else {
            accountButton.setTitle("Select an account".localized(), for: .normal)
        }
        accountButton.addTarget(self, action: #selector(presentAccountPicker), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(accountButton)
        
        setupConstraints(for: accountButton, titleTopConstraint: typeCollectionView.bottomAnchor, titleLabel: titleLabel)
        accountButton.setConstraints(heightConstant: 55)
    }
    
    @objc private func presentAccountPicker() {
        let viewController =  AccountSelectionViewController()
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController), height: 300, showIndicator: false)
    }
    
    private func setupDateSection() {
        let titleLabel: TitleLabel = TitleLabel()
        
        titleLabel.text = "Date".localized()
        dateButton.setTitle("Select a date".localized(), for: .normal)
        dateButton.addTarget(self, action: #selector(presentDatePicker), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateButton)
        
        setupConstraints(for: dateButton, titleTopConstraint: accountButton.bottomAnchor, titleLabel: titleLabel)
        dateButton.setConstraints(heightConstant: 55)
    }
    
    @objc private func presentDatePicker() {
        let viewController =  DateSelectionViewController()
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController), height: 300, showIndicator: false)
    }
    
    private func setupDescriptionSection() {
        let titleLabel: TitleLabel = TitleLabel()
        titleLabel.text = "Description".localized()
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = ThemeManager.currentTheme().textColor
        descriptionLabel.text = "Add a description for the movement".localized()
        
        descriptionTextView.delegate = self
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextView)
        
        setupConstraints(for: descriptionTextView, titleTopConstraint: dateButton.bottomAnchor, titleLabel: titleLabel, descriptionLabel: descriptionLabel)
        descriptionTextView.setConstraints(bottomAnchor: contentView.bottomAnchor, bottomConstant: trailingConstant, heightConstant: 100)
    }
    
    private func setupConstraints(for view: UIView, titleTopConstraint: NSLayoutYAxisAnchor, titleLabel: UILabel, descriptionLabel: UILabel? = nil) {
        titleLabel.setConstraints(topAnchor: titleTopConstraint, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        
        var viewTopAnchor: NSLayoutYAxisAnchor = titleLabel.bottomAnchor
        if let descriptionLbl = descriptionLabel {
            descriptionLbl.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: descriptionTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
            viewTopAnchor = descriptionLbl.bottomAnchor
        }
        
        view.setConstraints(topAnchor: viewTopAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
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
        return amountTextField.text != "" && selectedTypeIndex != -1
            && selectedDate != nil && selectedAccount != nil
    }
    
    override func addButtonAction(_ sender: Any) {
        let movement = Movement()
        if let amount = amountTextField.text {
           movement.amount = Double(amount) ?? 0
        }
        movement.type = movementTypes[selectedTypeIndex].rawValue
        movement.account = selectedAccount
        movement.movDescription = descriptionTextView.text
        RealmManager.shared.add(movement)
        NotificationCenter.default.post(name: .updateAccountCard, object: nil)
        delegate?.didCreateMovement()
        dismissPanel()
    }

}

extension AddMovementViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movementTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovementTypeCollectionViewCell
        cell.textLabel.text = movementTypes[indexPath.item].rawValue.localized()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTypeIndex = indexPath.item
        let cell = collectionView.cellForItem(at: indexPath) as! MovementTypeCollectionViewCell
        cell.backgroundColor = ThemeManager.currentTheme().accentColor
        cell.textLabel.textColor = .white
        shouldEnabledButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovementTypeCollectionViewCell
        cell.backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        cell.textLabel.textColor = .lightGray
    }
}

extension AddMovementViewController: AccountSelectionViewControllerDelegate {
    func didSelectAccount(_ account: Account) {
        selectedAccount = account
        let title = account.bankName + " - " + account.number.suffix(4)
        accountButton.setTitle(title, for: .normal)
        shouldEnabledButton()
    }
}

extension AddMovementViewController: DateSelectionViewControllerDelegate {
    func didSelectDate(_ date: Date) {
        selectedDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let title = dateFormatter.string(from: date)
        dateButton.setTitle(title, for: .normal)
        shouldEnabledButton()
    }
}

extension AddMovementViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        shouldEnabledButton()
    }
}
