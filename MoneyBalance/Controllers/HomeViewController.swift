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
    let titleNavbarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
    
    /// Creates the design of the navigationItem.titleView and adds tapGestureRecognizer
    private func setupNavigationBarTitle() {
        let title = UILabel()
        title.font = UIFont(name: ThemeManager.currentTheme().titleFont, size: 17.0)
        title.text = "USD"
        title.textColor = ThemeManager.currentTheme().textColor
        titleNavbarView.addSubview(title)
        
        let arrowImageView = UIImageView(image: UIImage(named: "expand-arrow"))
        arrowImageView.setImageColor(color: ThemeManager.currentTheme().textColor)
        titleNavbarView.addSubview(arrowImageView)
        
        title.setConstraints(topAnchor: titleNavbarView.topAnchor, leadingAnchor: titleNavbarView.leadingAnchor, bottomAnchor: titleNavbarView.bottomAnchor, trailingAnchor: arrowImageView.leadingAnchor, trailingConstant: -8)
        arrowImageView.setConstraints(trailingAnchor: titleNavbarView.trailingAnchor, centerYAnchor: title.centerYAnchor, widthConstant: 15, heightConstant: 15)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentAccountsView))
        titleNavbarView.addGestureRecognizer(tapGestureRecognizer)
        titleNavbarView.isUserInteractionEnabled = true
        navigationItem.titleView = titleNavbarView
    
    }
    
    @objc func presentAccountsView() {
        let viewController = AccountsViewController()
        let bottomSheet = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet, animated: true)
    }
}
