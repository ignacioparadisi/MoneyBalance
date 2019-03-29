//
//  SettingsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    private let languageSection = 0
    private let themeSection = 1
    private let authenticationSection = 2
    
    // Identifier for theme selection cell
    private let switchCellIdentifier = "switchCellIdentifier"

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Settings".localized()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(groupedTableView)
        groupedTableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
        groupedTableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        groupedTableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: switchCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case languageSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
            cell.configureWith(title: "Language".localized(), accessoryType: .disclosureIndicator, selectedValue: Localize.getSelectedLanguageName())
            return cell
            
        case themeSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: switchCellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.tag = tag(for: indexPath)
            cell.configureWith(theme: ThemeManager.currentTheme())
            cell.delegate = self
            return cell
            
        case authenticationSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DefaultTableViewCell
            cell.configureWith(title: "Screen Lock".localized(), accessoryType: .disclosureIndicator)
            return cell
        default:
            return UITableViewCell()
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
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case languageSection:
            return "Change app's language".localized()
        case authenticationSection:
            return "Require Touch ID to unlock this app".localized()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case languageSection:
            let viewController = LanguageSettingsViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case authenticationSection:
            let viewController = ScreenLockSettingsViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    private func restartApplication () {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
        }
        
        navigationController.view.frame = rootViewController.view.frame
        navigationController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navigationController
        })
        
    }

}

extension SettingsViewController: SwitchTableViewCellDelegate {
    func switchValueChanged(isOn: Bool, tag: Int) {
        switch section(from: tag) {
        case 1:
            if isOn {
                ThemeManager.applayTheme(.dark)
            } else {
                ThemeManager.applayTheme(.light)
            }
        default:
            break
        }
        restartApplication()
    }
}
