//
//  AccountCardTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountCardTableViewCellDelegate {
    func shareAccount(_ text: String)
    func editAccount()
}

class AccountCardTableViewCell: UITableViewCell {

    lazy var view = AccountCardView()
    lazy var buttonBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.backgroundColor = UIColor("007AFF")
        return view
    }()
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        return button
    }()
    var delegate: AccountCardTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        selectionStyle = .none
        view.delegate = self
        editButton.addTarget(self, action: #selector(editAccount), for: .touchUpInside)
        addSubview(buttonBackgroundView)
        addSubview(editButton)
        addSubview(view)
        view.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, topConstant: 20, leadingConstant: 20, bottomConstant: -20, trailingConstant: -20)
        editButton.setConstraints(topAnchor: topAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, topConstant: 20, bottomConstant: -20, trailingConstant: -20, widthConstant: 80)
        buttonBackgroundView.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, topConstant: 20, leadingConstant: 40, bottomConstant: -20, trailingConstant: -20)
        setupView()
    }

    private func setupView() {
        backgroundColor = ThemeManager.currentTheme().backgroundColor
        view.backgroundColor = .clear
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func panGestureAction(_ gestureRecognizer: UIPanGestureRecognizer) {
        var translation = gestureRecognizer.translation(in: self.view)
        let velocity = gestureRecognizer.velocity(in: view)
        
        if view.center.x >= center.x, velocity.x > 0 {
            translation.x = 0
        }
        
        if view.center.x <= 60, velocity.x < 0 {
            translation.x = translation.x * 1/2
        }
        
        if view.center.x <= -frame.width / 4 {
            translation.x = 0
        }
        
        if gestureRecognizer.view != nil  {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y)
        }
        gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if gestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                if self.view.center.x < self.center.x - 40 {
                    if self.view.center.x < self.frame.width / 100 {
                        self.editAccount()
                    }
                    self.view.center.x = self.center.x - 80
                } else {
                    self.view.center.x = self.center.x
                }
                }, completion: nil)
        }
    }
    
    func configureWith(account: Account) {
        view.configureWith(account: account)
    }
    
    @objc private func editAccount() {
        delegate?.editAccount()
    }
    
}

extension AccountCardTableViewCell: AccountCardViewDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
