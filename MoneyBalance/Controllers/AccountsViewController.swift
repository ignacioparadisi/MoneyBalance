//
//  AccountsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    private let cellIdentifier = "cellIdentifier"
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    private var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = ThemeManager.currentTheme().bottomSheetColor
        view.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        view.layer.masksToBounds = false
        navigationBar.prefersLargeTitles = true
        navigationBar.topItem?.title = "Currencies".localized()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCurrency))
        addButton.tintColor = ThemeManager.currentTheme().accentColor
        navigationBar.topItem?.setRightBarButton(addButton, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func fetchData() {
        if let currencies = RealmManager.shared.getCurrencies() {
            self.currencies = currencies
            tableView.reloadData()
        }
    }
    
    @objc private func addCurrency() {
        let currency = Currency()
        currency.identifier = "en_US"
        currency.name = "USD"
        currency.selected = true
        RealmManager.shared.add(currency: currency)
    }
}

extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        cell.isCurrentAccount = indexPath.row == 0 ? true : false
        return cell
    }
}
