//
//  ScreenLockSettingsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/11/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class ScreenLockSettingsViewController: BaseViewController {

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Screen Lock".localized()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(groupedTableView)
        groupedTableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        groupedTableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "When enabled, you'll need to use Touch ID to unlock this app.".localized()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SwitchTableViewCell
        cell.tag = tag(for: indexPath)
        cell.configureWith(title: "Require Touch ID".localized(), value: Utils.isAuthenticationEnabled())
        cell.delegate = self
        return cell
    }
}

extension ScreenLockSettingsViewController: SwitchTableViewCellDelegate {
    func switchValueChanged(isOn: Bool, tag: Int) {
        Utils.changeAuthenticationStatus(isOn: isOn)
    }
}
