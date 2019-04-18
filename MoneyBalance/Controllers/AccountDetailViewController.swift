//
//  AccountDetailViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    private let accountSection = 0
    private let movementsSection = 1
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
    var account: Account = Account() {
        didSet {
            refresh()
        }
    }
    private var movements: [Movement] = []
    
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
        // addChartsButton()
    }
    
    private func addChartsButton() {
        let image = UIImage(named: "bar_chart")
        let chartsButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goToCharts))
        navigationItem.setRightBarButton(chartsButton, animated: false)

    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(bottomBackgroundView)
        view.addSubview(addMovementButton)
        view.addSubview(tableView)
        addMovementButton.setConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, centerXAnchor: view.centerXAnchor, bottomConstant: -20, widthConstant: 60, heightConstant: 60)
        bottomBackgroundView.setConstraints( leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor, heightConstant: 115)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 115, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.register(AccountCardTableViewCell.self, forCellReuseIdentifier: AccountCardTableViewCell.reusableIdentifier)
        tableView.register(MovementTableViewCell.self)
        view.bringSubviewToFront(bottomBackgroundView)
        view.bringSubviewToFront(addMovementButton)
    }
    
    override func refresh() {
        fetchMovements()
        // tableView.reloadSections(IndexSet(integer: 1), with: .none)
        tableView.reloadData()
    }
    
    private func fetchMovements() {
        movements = RealmManager.shared.getMovements(filter: "account.id == '\(account.id)'")
        // movements = RealmManager.shared.getArray(ofType: Movement.self, filter: "account.id == '\(account.id)'") as! [Movement]
        
    }
    
    @objc private func goToAddMovement() {
        let viewController = AddMovementViewController(nibName: "AddViewController", bundle: nil)
        viewController.selectedAccount = account
        viewController.delegate = self
        presentAsStork(UINavigationController(rootViewController: viewController))
    }
    
    private func goToMovementDetails(movement: Movement) {
        let viewController = MovementDetailViewController(nibName: "MovementDetailViewController", bundle: nil)
        viewController.movement = movement
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func goToCharts() {
        let viewController = ChartsViewController()
        viewController.account = account
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showDeleteAlert(with title: String, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete".localized(), style: .destructive, handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension AccountDetailViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case accountSection:
            return 1
        default:
            return movements.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case accountSection:
            let cell = tableView.dequeueReusableCell(for: indexPath) as AccountCardTableViewCell
            cell.layoutIfNeeded()
            cell.delegate = self
            cell.configureWith(account: account)
            cell.view.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor, cornerRadius: 10)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath) as MovementTableViewCell
            cell.configureWith(movement: movements[row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == accountSection {
            return view.frame.width * 2/3
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TitleTableViewHeader()
        switch section {
        case accountSection:
            view.titleLabel.text = "Account".localized()
            // view.setRightItem(with: "Delete".localized(), delegate: self)
        default:
            view.titleLabel.text = "Movements".localized()
        }
        return view
    }
    
    private func deleteAccount() {
        showDeleteAlert(with: "Delete account?".localized(), message: "Deleting the account is permanent. You won't be able to get it back.".localized(), handler: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == movementsSection {
            goToMovementDetails(movement: movements[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().highlightTableViewCellColor
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == accountSection {
            return .none
        }
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, indexPath.section == movementsSection {
            showDeleteAlert(with: "Delete movement?".localized(), message: "", handler: { _ in
                RealmManager.shared.delete(self.movements[indexPath.item])
                self.movements.remove(at: indexPath.item)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                NotificationCenter.default.post(name: .updateAccountCard, object: nil)
            })
        }
    }
}

extension AccountDetailViewController: AccountCardTableViewCellDelegate {
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
    
    func editAccount() {
        let viewController = AddAccountViewController(nibName: "AddViewController", bundle: nil)
        viewController.account = account
        presentAsStork(UINavigationController(rootViewController: viewController))
    }
}

extension AccountDetailViewController: AddMovementViewControllerDelegate {
    func didCreateMovement() {
        fetchMovements()
        let indexPath = IndexPath(row: 0, section: movementsSection)
        tableView.insertRows(at: [indexPath], with: .right)
    }
}

extension AccountDetailViewController: TitleTableViewHeaderDelegate {
    func tappedHeaderRightButton() {
        deleteAccount()
    }
}
