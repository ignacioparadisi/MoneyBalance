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
    
    private let ACCOUNTS_SECTION = 0
    private let SAVING_SECTION = 1
    private let accountsCellIdentifier = "accountsCellIdentifier"
    private let titleCellIdentifier = "titleCellIdentifier"
    private let totalCellIdentifier = "totalCellIdentifier"
    
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
    var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    var backgroundWasSet = false
    private var accounts: [Account] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !backgroundWasSet {
            backgroundWasSet = true
            let white: CGFloat = ThemeManager.currentTheme() == .light ? 0.94 : 0.09
            bottomBackgroundView.setGradientBackground(colorOne: UIColor(white: white, alpha: 0), colorTwo: UIColor(white: white, alpha: 1), locations: [0.0, 0.5], startPoint: CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint(x: 0.5, y: 1.0))
        }
    }
    
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
        tableView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        tableView.separatorStyle = .none
        view.addSubview(addMovementButton)
        view.addSubview(bottomBackgroundView)
        view.addSubview(tableView)
        addMovementButton.setConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, centerXAnchor: view.centerXAnchor, bottomConstant: -20, widthConstant: 60, heightConstant: 60)
        bottomBackgroundView.setConstraints( leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor, heightConstant: 115)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: accountsCellIdentifier)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: titleCellIdentifier)
        tableView.register(UINib(nibName: "NameMoneyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "TotalAmountTableViewCell", bundle: nil), forCellReuseIdentifier: totalCellIdentifier)
        view.bringSubviewToFront(bottomBackgroundView)
        view.bringSubviewToFront(addMovementButton)
        refresh()
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
        presentAsStork(UINavigationController(rootViewController: viewController), height: 365, showIndicator: true, hideIndicatorWhenScroll: true, showCloseButton: false, complection: nil)
    }
    
    @objc private func goToAddMovement() {
        let viewController = AddMovementViewController(nibName: "AddViewController", bundle: nil)
        presentAsStork(UINavigationController(rootViewController: viewController), height: nil, showIndicator: true, hideIndicatorWhenScroll: true, showCloseButton: false, complection: nil)
    }
    
    override func refresh() {
        fetchAcconts()
    }
    
    private func fetchAcconts() {
        accounts = RealmManager.shared.getArray(ofType: Account.self) as! [Account]
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if accounts.count == 0 {
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ACCOUNTS_SECTION:
            return 1
        case SAVING_SECTION:
            return accounts.count + 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == ACCOUNTS_SECTION {
            let cell = tableView.dequeueReusableCell(withIdentifier: accountsCellIdentifier, for: indexPath) as! AccountTableViewCell
            cell.addAccountButton.tintColor = ThemeManager.currentTheme().accentColor
            cell.delegate = self
            return cell
        } else {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: titleCellIdentifier, for: indexPath) as! TitleTableViewCell
                cell.configuereWith(title: "Savings".localized())
                return cell
            } else if row == accounts.count + 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: totalCellIdentifier, for: indexPath) as! TotalAmountTableViewCell
                
                var amount: Double = 0
                for account in accounts {
                    amount += account.money
                }
                cell.configuereWith(amount: amount)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NameMoneyTableViewCell
                cell.configureWith(account: accounts[row - 1])
                return cell
            }
        }
        
    }
    
}

extension HomeViewController: CurrenciesViewControllerDelegate, AddNewCurrencyViewControllerDelegate {    
    func selectedCurrencyChanged() {
        titleLabel.text = Currency.current?.name
        tableView.reloadData()
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
        presentAsStork(UINavigationController(rootViewController: viewController), height: nil, showIndicator: true, hideIndicatorWhenScroll: true, showCloseButton: false, complection: nil)
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
