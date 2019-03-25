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
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        addButton.setTitle("Add".localized(), for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        addButton.backgroundColor = .lightGray
        addButton.layer.cornerRadius = 10
        addButton.layer.masksToBounds = false
        bottomBackgroundView.backgroundColor = .clear
        let white: CGFloat = ThemeManager.currentTheme() == .light ? 1 : 0.07
        bottomBackgroundView.setGradientBackground2(colorOne: UIColor(white: white, alpha: 0), colorTwo: UIColor(white: white, alpha: 1))
    }
    
    

    @IBAction func addButtonAction(_ sender: Any) {
    }
}
