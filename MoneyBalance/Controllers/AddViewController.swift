//
//  AddViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/22/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {

    internal let titleTopConstant: CGFloat = 20
    internal let descriptionTopConstant: CGFloat = 5
    internal let textFieldTopConstant: CGFloat = 10
    internal let leadingConstant: CGFloat = 16
    internal let trailingConstant: CGFloat = -16
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contentView: UIView!

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 95, right: 0)
//        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 95, right: 0)
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        addButton.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        addButton.setTitle("Add".localized(), for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        scrollView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        contentView.backgroundColor = .clear
    }
    
    

    @IBAction func addButtonAction(_ sender: Any) {
    }
}
