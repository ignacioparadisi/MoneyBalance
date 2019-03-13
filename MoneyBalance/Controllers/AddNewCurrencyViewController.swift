//
//  AddNewCurrencyViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddNewCurrencyViewController: BaseViewController {
    
    private var currencies: [CountryCurrency] = []

    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchCurrencies()
    }
    
    private func fetchCurrencies() {
        currencies = RealmManager.shared.get(CountryCurrency.self) as! [CountryCurrency]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
        cell.configureWith(title: currency.currency, selectedValue: currency.country)
        return cell
    }

}
