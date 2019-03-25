//
//  ViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddMovementViewController: AddViewController {
    
    private let movementTypes: [Movement.MovementType] = [.income, .outcome]
    private lazy var amountTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    private var typeCollectionView: UICollectionView!
    private lazy var accountButton: PickButton = PickButton()
    private lazy var dateButton: PickButton = PickButton()
    private var selectedTypeIndex = -1
    private var selectedAccount: Account?
    private var selectedDate: Date?

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
    }
    
    private func setupAmountSection() {
        let titleLabel: TitleLabel = TitleLabel()
        let descriptionLabel = UILabel()
        
        titleLabel.text = "Amount".localized()
        descriptionLabel.textColor = ThemeManager.currentTheme().textColor
        descriptionLabel.text = "Enter amount of money".localized()
        amountTextField.setPlaceholder("Amount of money".localized())
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(amountTextField)
        
        titleLabel.setConstraints(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        descriptionLabel.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: descriptionTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        amountTextField.setConstraints(topAnchor: descriptionLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor,  trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
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
        
        titleLabel.setConstraints(topAnchor: amountTextField.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        descriptionLabel.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: descriptionTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        typeCollectionView.setConstraints(topAnchor: descriptionLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, heightConstant: collectionViewHeight)
    }
    
    
    private func setupAccountSection() {
        let titleLabel: TitleLabel = TitleLabel()
        
        titleLabel.text = "Account".localized()
        accountButton.setTitle("Select an account".localized(), for: .normal)
        accountButton.addTarget(self, action: #selector(presentAccountPicker), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(accountButton)
        
        titleLabel.setConstraints(topAnchor: typeCollectionView.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        accountButton.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor,  trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant, heightConstant: 55)
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
        
        titleLabel.setConstraints(topAnchor: accountButton.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: titleTopConstant, leadingConstant: leadingConstant, trailingConstant: trailingConstant)
        dateButton.setConstraints(topAnchor: titleLabel.bottomAnchor, leadingAnchor: contentView.leadingAnchor, bottomAnchor: contentView.bottomAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: textFieldTopConstant, leadingConstant: leadingConstant, bottomConstant: 0, trailingConstant: trailingConstant, heightConstant: 55)
    }
    
    @objc private func presentDatePicker() {
        let viewController =  DateSelectionViewController()
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController), height: 300, showIndicator: false)
    }
    
    override func addButtonAction(_ sender: Any) {
        let movement = Movement()
        if let amount = amountTextField.text {
           movement.amount = Double(amount) ?? 0
        }
        movement.type = movementTypes[selectedTypeIndex].rawValue
        movement.account = selectedAccount
        RealmManager.shared.add(movement)
        NotificationCenter.default.post(name: .didCreateAccount, object: nil)
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
    }
}

extension AddMovementViewController: DateSelectionViewControllerDelegate {
    func didSelectDate(_ date: Date) {
        selectedDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let title = dateFormatter.string(from: date)
        accountButton.setTitle(title, for: .normal)
    }
}
