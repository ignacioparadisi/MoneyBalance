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
    let titleNavbarLabel: UILabel = {
        let title = UILabel()
        title.text = "USD"
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        title.textColor = ThemeManager.currentTheme().textColor
        return title
    }()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        setupNavigationBarTitle()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.setConstraints(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.bottomAnchor, trailingAnchor: view.trailingAnchor)
    }
    
    /// Adds a TapGestureRecognizer to titleNavbarLabel for opening the bottom sheet
    private func setupNavigationBarTitle() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentAccounts))
        titleNavbarLabel.addGestureRecognizer(tapGestureRecognizer)
        titleNavbarLabel.isUserInteractionEnabled = true
        
        navigationItem.titleView = titleNavbarLabel
    }
    
    /// Present bottom sheet when titleNavbarLabel is tapped
    @objc private func presentAccounts() {
        let viewController = AccountsViewController()
        let bottomSheet = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet, animated: true)
    }

}
