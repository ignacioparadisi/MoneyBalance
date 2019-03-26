//
//  MovementDetailViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/26/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MovementDetailViewController: BaseViewController {
    
    var movement: Movement = Movement()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Detail".localized()
    }
    
    override func setupView() {
        super.setupView()
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupAmountSection() {
        let title = TitleLabel()
        title.text = "Amount".localized()
    }

}
