//
//  LauncherViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import LocalAuthentication

class LauncherViewController: UIViewController, AuthenticationFailedViewDelegate {
    
    lazy var viewController: UIViewController = MainViewController()
    
    lazy var contentView: AuthenticationFailedView = {
        let view = AuthenticationFailedView()
        view.backgroundColor = .clear
        view.alpha = 0
        view.isUserInteractionEnabled = false
        view.delegate = self
        return view
    }()
    
    init(_ viewController: UIViewController? = MainViewController()) {
        super.init(nibName: nil, bundle: nil)
        if let vc = viewController {
            self.viewController = vc
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        view.addSubview(contentView)
        contentView.setConstraints(leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor, leadingConstant: 16, trailingConstant: -16)
        
        authenticate()
    }
    
    internal func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Touch ID is required to use this app.".localized()
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [unowned self] (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        UIApplication.shared.keyWindow?.rootViewController = self.viewController
                    } else {
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                            self.contentView.alpha = 1
                        }, completion: { _ in
                            self.contentView.isUserInteractionEnabled = true
                        })
                    }
                }
            }
        } else {

        }
    }

}
