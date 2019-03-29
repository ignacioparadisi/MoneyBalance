//
//  BaseViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// Default identifier for a table view cell
    let cellIdentifier = "cellIdentifier"
    /// Table view
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        return tv
    }()
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(dismissPanel))
        return button
    }()
    
    lazy var groupedTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    /// Sets up the view
    func setupView() {
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
    /// Sets up the navigation bar
    func setupNavigationBar() {
    }
    
    func refresh() {
    }
    
    internal func tag(for indexPath: IndexPath) -> Int {
        let section = indexPath.section
        let row = indexPath.row
        return (section * 10) + row
    }
    
    internal func section(from tag: Int) -> Int {
        return tag / 10
    }
    
    internal func row(from tag: Int) -> Int {
        return tag - section(from: tag)
    }
    
    @objc internal func dismissPanel() {
        dismiss(animated: true)
    }

}

// MARK: - [extension] UITableViewDataSource
extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - [extension] UITableViewDelegate
extension BaseViewController: UITableViewDelegate {
}
