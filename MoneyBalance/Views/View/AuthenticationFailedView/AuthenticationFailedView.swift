//
//  AuthenticationFailedView.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AuthenticationFailedViewDelegate: class {
    func authenticate()
}

class AuthenticationFailedView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var touchIdButton: UIButton!
    weak var delegate: AuthenticationFailedViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    /// Gets authentication failed view from xib and adds texts
    private func setupXib() {
        Bundle.main.loadNibNamed("AuthenticationFailedView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.backgroundColor = .clear
        
        titleLabel.text = "Application Locked".localized()
        descriptionLabel.text = "Unlock with Touch ID to open".localized()
        touchIdButton.setTitle("Use Touch ID".localized(), for: .normal)
    }
    
    /// Shows authentication alert if button is tapped
    ///
    /// - Parameter sender: UIButton tapped
    @IBAction func authenticateAction(_ sender: Any) {
        delegate?.authenticate()
    }
    
}
