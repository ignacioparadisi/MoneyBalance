//
//  CurrenciesViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol CurrenciesViewControllerDelegate {
    func goTo(viewController: UIViewController)
    func selectedCurrencyChanged()
}

class CurrenciesViewController: UIViewController {

    private let cellIdentifier = "cellIdentifier"
    @IBOutlet weak var tableView: UITableView!
    private var currencies: [Currency] = []
    var delegate: CurrenciesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies".localized()
        setupView()
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = ThemeManager.currentTheme().bottomSheetColor
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCurrency))
        addButton.tintColor = ThemeManager.currentTheme().accentColor
        navigationItem.setRightBarButton(addButton, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OwnedCurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(UIView())
        
//        let topLine = UIView()
//        topLine.backgroundColor = .lightGray
//        navigationController?.navigationBar.addSubview(topLine)
//        topLine.setConstraints(topAnchor: navigationController?.navigationBar.topAnchor, centerXAnchor: navigationController?.navigationBar.centerXAnchor, topConstant: 10, widthConstant: 35, heightConstant: 3)
        
    }
    
    private func fetchData() {
        currencies = RealmManager.shared.getArray(ofType: Currency.self, filter: "owned == true") as! [Currency]
        currencies.sort { (currency1, currency2) -> Bool in
            return currency1.selected && !currency2.selected
        }
        tableView.reloadData()
    }
    
    @objc private func addCurrency() {
        let controller = AddNewCurrencyViewController()
        controller.delegate = delegate as? AddNewCurrencyViewControllerDelegate
        dismiss(animated: true) {
            self.delegate?.goTo(viewController: controller)
        }
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        dismiss(animated: true) {
            let settingsViewController = SettingsViewController()
            self.delegate?.goTo(viewController: settingsViewController)
        }
    }
    
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OwnedCurrencyTableViewCell
        cell.tag = indexPath.row
        cell.delegate = self
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

extension CurrenciesViewController: OwnedCurrencyTableViewCellDelegate {
    func deleteAccount(at index: Int) {
        let currency = currencies[index]
        let indexPath = IndexPath(row: index, section: 0)
        let alert = UIAlertController(title: "Delete account", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] alert in
            RealmManager.shared.deleteCurrency(currency)
            self?.currencies.remove(at: index)
            self?.tableView.deleteRows(at: [indexPath], with: .left)
        }))
        present(alert, animated: true)
    }
}

extension CurrenciesViewController: AddNewCurrencyViewControllerDelegate {
    func selectedCurrencyChanged() {
        fetchData()
    }
}
