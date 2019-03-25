//
//  DateSelectionViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol DateSelectionViewControllerDelegate {
    func didSelectDate(_ date: Date)
}

class DateSelectionViewController: BaseViewController {

    private lazy var picker = UIDatePicker()
    var delegate: DateSelectionViewControllerDelegate?
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Date".localized()
        let confirmButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmSelection))
        navigationItem.setRightBarButton(confirmButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        picker.backgroundColor = .clear
        picker.setValue(ThemeManager.currentTheme().textColor, forKeyPath: "textColor")
        
        view.addSubview(picker)
        picker.setConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, trailingAnchor: view.trailingAnchor)
    }
    
    @objc private func confirmSelection() {
        let date = picker.date
        delegate?.didSelectDate(date)
        dismissPanel()
    }

}
