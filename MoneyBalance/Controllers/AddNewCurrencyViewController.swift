//
//  AddNewCurrencyViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import SPStorkController

protocol AddNewCurrencyViewControllerDelegate {
    func selectedCurrencyChanged()
}

class AddNewCurrencyViewController: BaseViewController {
    
    private var currencies: [Currency] = []
    var delegate: AddNewCurrencyViewControllerDelegate?

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Currencies".localized()
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchCurrencies()
    }
    
    private func fetchCurrencies() {
        currencies = RealmManager.shared.getArray(ofType: Currency.self) as! [Currency]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
        cell.configureWith(title: currency.name, selectedValue: currency.country)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().highlightTableViewCellColor
        let currency = currencies[indexPath.row]
        RealmManager.shared.createCurrency(currency)
        delegate?.selectedCurrencyChanged()
        dismissPanel()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().highlightTableViewCellColor
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
}
