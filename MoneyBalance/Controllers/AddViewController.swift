//
//  AddViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/22/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        addButton.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        addButton.setTitle("Add".localized(), for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        scrollView.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }

    @IBAction func addButtonAction(_ sender: Any) {
    }
}
