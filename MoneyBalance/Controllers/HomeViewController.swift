//
//  HomeViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import LocalAuthentication

class HomeViewController: BaseViewController {
    
    /// NavigationBar title labe for adding a TapGestureRecognizer
    let titleNavbarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var bottomSheet: MDCBottomSheetController?
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        setupNavigationBarTitle()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    /// Creates the design of the navigationItem.titleView and adds tapGestureRecognizer
    private func setupNavigationBarTitle() {
        let title = UILabel()
        title.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        title.text = "USD"
        title.textColor = ThemeManager.currentTheme().textColor
        titleNavbarView.addSubview(title)
        
        let arrowImageView = UIImageView(image: UIImage(named: "expand-arrow"))
        arrowImageView.setImageColor(color: ThemeManager.currentTheme().textColor)
        titleNavbarView.addSubview(arrowImageView)
        
        title.setConstraints(topAnchor: titleNavbarView.topAnchor, leadingAnchor: titleNavbarView.leadingAnchor, bottomAnchor: titleNavbarView.bottomAnchor, trailingAnchor: arrowImageView.leadingAnchor, trailingConstant: -8)
        arrowImageView.setConstraints(trailingAnchor: titleNavbarView.trailingAnchor, centerYAnchor: title.centerYAnchor, widthConstant: 15, heightConstant: 15)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentAccountsView))
        titleNavbarView.addGestureRecognizer(tapGestureRecognizer)
        titleNavbarView.isUserInteractionEnabled = true
        navigationItem.titleView = titleNavbarView
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BankTableViewCell
        return cell
    }
    
    @objc func presentAccountsView() {
        let viewController = CurrenciesViewController(nibName: "CurrenciesViewController", bundle: nil)
        viewController.delegate = self
        bottomSheet = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet!, animated: true)

    }
}

extension HomeViewController: CurrenciesViewControllerDelegate {
    func goToAddCurrency() {
        let controller = AddNewCurrencyViewController()
        bottomSheet!.dismiss(animated: true) {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
