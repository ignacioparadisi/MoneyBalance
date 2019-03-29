//
//  AccountSelectionViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/24/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountSelectionViewControllerDelegate: class {
    func didSelectAccount(_ account: Account)
}

class AccountSelectionViewController: BaseViewController {
    
    private lazy var picker = UIPickerView()
    private var accounts: [Account] = []
    var delegate: AccountSelectionViewControllerDelegate?

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Accounts".localized()
        let confirmButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmSelection))
        navigationItem.setRightBarButton(confirmButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .clear
        picker.setValue(ThemeManager.currentTheme().textColor, forKeyPath: "textColor")
        
        view.addSubview(picker)
        picker.setConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, trailingAnchor: view.trailingAnchor)
        
        fetchAccounts()
    }
    
    private func fetchAccounts() {
        accounts = RealmManager.shared.getArray(ofType: Account.self) as! [Account]
        picker.reloadAllComponents()
    }
    
    @objc private func confirmSelection() {
        let row = picker.selectedRow(inComponent: 0)
        let account = accounts[row]
        delegate?.didSelectAccount(account)
        dismissPanel()
    }

}

extension AccountSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let account = accounts[row]
        let titleText = account.bankName + " - " + account.number.suffix(4)
        let title = NSAttributedString(string: titleText, attributes: [.foregroundColor: ThemeManager.currentTheme().textColor])
        return title
    }
    
}
