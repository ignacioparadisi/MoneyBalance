//
//  AccountsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    private let cellIdentifier = "cellIdentifier"
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = ThemeManager.currentTheme().bottomSheetColor
        view.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        view.layer.masksToBounds = false
        navigationBar.prefersLargeTitles = true
        navigationBar.topItem?.title = "Accounts".localized()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        addButton.tintColor = ThemeManager.currentTheme().accentColor
        navigationBar.topItem?.setRightBarButton(addButton, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        cell.isCurrentAccount = indexPath.row == 0 ? true : false
        return cell
    }
}
