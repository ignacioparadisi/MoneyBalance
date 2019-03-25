//
//  CustomTextField.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/24/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        textColor = ThemeManager.currentTheme().textColor
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func setPlaceholder(_ string: String) {
        attributedPlaceholder = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().placeholderColor])
    }
    
}
