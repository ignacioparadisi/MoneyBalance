//
//  LanguageSettingsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/11/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class LanguageSettingsViewController: BaseViewController {

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Language".localized()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(groupedTableView)
        groupedTableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        groupedTableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Select the desired language for the app".localized()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
        if indexPath.row == 0 {
            cell.configureWith(title: "English".localized())
        } else if indexPath.row == 1 {
            cell.configureWith(title: "Spanish".localized())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Localize.setLanguage("en")
        } else {
            Localize.setLanguage("es-US")
        }
    }

}
