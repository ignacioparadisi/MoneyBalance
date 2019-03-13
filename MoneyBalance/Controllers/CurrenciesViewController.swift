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
}
