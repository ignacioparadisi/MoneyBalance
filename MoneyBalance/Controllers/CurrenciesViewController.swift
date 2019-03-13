//
//  CurrenciesViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol CurrenciesViewControllerDelegate {
    func goToAddCurrency()
    func selectedCurrencyChanged()
}

class CurrenciesViewController: UIViewController {

    private let cellIdentifier = "cellIdentifier"
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    private var currencies: [Currency] = []
    var delegate: CurrenciesViewControllerDelegate?
    
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
        currencies = RealmManager.shared.getArray(ofType: Currency.self, filter: "owned == true") as! [Currency]
        currencies.sort { (currency1, currency2) -> Bool in
            return currency1.selected && !currency2.selected
        }
        tableView.reloadData()
    }
    
    @objc private func addCurrency() {
        delegate?.goToAddCurrency()
    }
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        cell.configureWith(currency: currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        Currency.setCurrent(currency)
        let firstIndexPath = IndexPath(row: 0, section: 0)
        currencies.sort { (currency1, currency2) -> Bool in
            return currency1.selected && !currency2.selected
        }
        tableView.reloadData()
        tableView.moveRow(at: indexPath, to: firstIndexPath)
        delegate?.selectedCurrencyChanged()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currency = currencies[indexPath.row]
            RealmManager.shared.deleteCurrency(currency)
            currencies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
