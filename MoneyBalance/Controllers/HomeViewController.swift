//
//  HomeViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import LocalAuthentication
import SPStorkController


class HomeViewController: BaseViewController {
    
    /// NavigationBar title labe for adding a TapGestureRecognizer
    let titleNavbarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        title.textColor = ThemeManager.currentTheme().textColor
        return title
    }()
    var addMovementButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ThemeManager.currentTheme().accentColor
        button.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(goToAddMovement), for: .touchUpInside)
        return button
    }()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        setupNavigationBarTitle()
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(goToSettings))
        settingsButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: -10)
        navigationItem.setLeftBarButton(settingsButton, animated: false)
        addMovementButton.backgroundColor = ThemeManager.currentTheme().accentColor
    }
    
    override func setupView() {
        super.setupView()
        // navigationController?.delegate = self
        view.addSubview(addMovementButton)
        view.addSubview(tableView)
        addMovementButton.setConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, centerXAnchor: view.centerXAnchor, bottomConstant: -20, widthConstant: 60, heightConstant: 60)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.bringSubviewToFront(addMovementButton)
    }
    
    /// Creates the design of the navigationItem.titleView and adds tapGestureRecognizer
    private func setupNavigationBarTitle() {
        titleLabel.text = Currency.current?.name ?? "Currency".localized()
        titleNavbarView.addSubview(titleLabel)

        let arrowImageView = UIImageView(image: UIImage(named: "expand-arrow"))
        arrowImageView.setImageColor(color: ThemeManager.currentTheme().textColor)
        titleNavbarView.addSubview(arrowImageView)

        titleLabel.setConstraints(topAnchor: titleNavbarView.topAnchor, leadingAnchor: titleNavbarView.leadingAnchor, bottomAnchor: titleNavbarView.bottomAnchor, trailingAnchor: arrowImageView.leadingAnchor, trailingConstant: -8)
        arrowImageView.setConstraints(trailingAnchor: titleNavbarView.trailingAnchor, centerYAnchor: titleLabel.centerYAnchor, widthConstant: 15, heightConstant: 15)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentCurrenciesView))
        titleNavbarView.addGestureRecognizer(tapGestureRecognizer)
        titleNavbarView.isUserInteractionEnabled = true
        navigationItem.titleView = titleNavbarView

    }
    
    @objc private func goToSettings() {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func presentCurrenciesView() {
        let viewController = CurrenciesViewController(nibName: "CurrenciesViewController", bundle: nil)
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController), height: 365, showIndicator: true)
    }
    
    @objc private func goToAddMovement() {
        let viewController = AddMovementViewController(nibName: "AddViewController", bundle: nil)
        presentAsStork(UINavigationController(rootViewController: viewController))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        cell.addAccountButton.tintColor = ThemeManager.currentTheme().accentColor
        cell.delegate = self
        return cell
    }
    
}

extension HomeViewController: CurrenciesViewControllerDelegate, AddNewCurrencyViewControllerDelegate {    
    func selectedCurrencyChanged() {
        titleLabel.text = Currency.current?.name
    }
}

extension HomeViewController: AccountTableViewCellDelegate {
    func goToAddAccount() {
        if Currency.current == nil {
            showAddCurrencyAlert()
            return
        }
        let viewController = AddAccountViewController(nibName: "AddViewController", bundle: nil)
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController), showIndicator: true)
    }
    
    func goToDetail(for account: Account) {
        let controller = AccountDetailViewController()
        controller.title = account.bankName
        controller.account = account
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showAddCurrencyAlert() {
        let alert = UIAlertController(title: "Add currency".localized(), message: "For creating a new account you should first add a currency.".localized(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        let addCurrencyAction = UIAlertAction(title: "Add".localized(), style: .default) { action in
            self.presentCurrenciesView()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addCurrencyAction)
        present(alert, animated: true)
    }
    
    func shareAccount(_ text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (_, completed, _, error) in
            if completed {
                print("Shared")
            } else {
                print("Not shared")
            }
        }
        present(activityViewController, animated: true)
    }
}

extension HomeViewController: AddAccountViewControllerDelegate {
    func accountCreated() {
        tableView.reloadData()
    }
}
