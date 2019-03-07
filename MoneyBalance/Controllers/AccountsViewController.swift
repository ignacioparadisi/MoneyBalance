//
//  AccountsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountsViewController: BaseViewController {
    
    let topLine: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let accountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Accounts".localized()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 25)
        label.textColor = ThemeManager.currentTheme().textColor
        return label
    }()

    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = ThemeManager.currentTheme().bottomSheetColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        
        view.addSubview(topLine)
        view.addSubview(accountsLabel)
        view.addSubview(tableView)
        
        topLine.setConstraints(topAnchor: view.topAnchor, centerXAnchor: view.centerXAnchor, topConstant: 10, widthConstant: 35, heightConstant: 3)
        accountsLabel.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: tableView.topAnchor, trailingAnchor: view.trailingAnchor, topConstant: 16, leadingConstant: 16, trailingConstant: -16, heightConstant: 70)
        tableView.setConstraints(leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        cell.isCurrentAccount = indexPath.row == 0 ? true : false
        return cell
    }

}
