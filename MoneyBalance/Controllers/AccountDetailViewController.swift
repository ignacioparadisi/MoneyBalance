//
//  AccountDetailViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    var account: Account = Account()
    private var movemens: [Movement] = []
    
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
        tableView.register(UINib(nibName: "AccountCardTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountCardTableViewCell
        cell.layoutIfNeeded()
        cell.configureWith(account: account)
        cell.cardView.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 2/3
    }

}
