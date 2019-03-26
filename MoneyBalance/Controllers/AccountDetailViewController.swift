//
//  AccountDetailViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    private let accountCellIdentifier = "accountCellIdentifier"
    var account: Account = Account() {
        didSet {
            fetchMovements()
        }
    }
    private var movements: [Movement] = []
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let image = UIImage(named: "bar_chart")
        let chartsButton = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.setRightBarButton(chartsButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(AccountCardTableViewCell.self, forCellReuseIdentifier: accountCellIdentifier)
        tableView.register(UINib(nibName: "MovementTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func fetchMovements() {
        movements = RealmManager.shared.getArray(ofType: Movement.self, filter: "account.id == '\(account.id)'") as! [Movement]
        tableView.reloadData()
    }
}

extension AccountDetailViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return movements.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: accountCellIdentifier, for: indexPath) as! AccountCardTableViewCell
            cell.layoutIfNeeded()
            cell.delegate = self
            cell.configureWith(account: account)
            cell.view.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovementTableViewCell
            cell.configureWith(movement: movements[row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return view.frame.width * 2/3
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 42))
        view.backgroundColor = ThemeManager.currentTheme().tableViewBackgroundColor
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        view.addSubview(label)
        label.setConstraints(leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, centerYAnchor: view.centerYAnchor, leadingConstant: 16, trailingConstant: -16)
        label.text = section == 0 ? "Account".localized().uppercased() : "Movements".localized().uppercased()
        
        if section == 0 {
            let deleteButton = UIButton()
            deleteButton.setTitle("Delete".localized(), for: .normal)
            deleteButton.setTitleColor(ThemeManager.currentTheme().accentColor, for: .normal)
            view.addSubview(deleteButton)
            deleteButton.setConstraints(trailingAnchor: view.trailingAnchor, centerYAnchor: view.centerYAnchor, trailingConstant: -16)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
}
