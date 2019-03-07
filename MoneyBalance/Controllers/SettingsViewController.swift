//
//  SettingsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    private let themeCellIdentifier = "themeCellIdentifier"

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "Settings".localized()
    }
    
    override func setupView() {
        super.setupView()
    
        createTableView()
        
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "ThemeTableViewCell", bundle: nil), forCellReuseIdentifier: themeCellIdentifier)
    }
    
    private func createTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
            
            if row == 0 {
                cell.label.text = "English".localized()
            } else {
                cell.label.text = "Spanish".localized()
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: themeCellIdentifier, for: indexPath) as! ThemeTableViewCell
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
