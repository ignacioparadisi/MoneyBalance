//
//  CustomTextView.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/25/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    private let padding = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        textColor = ThemeManager.currentTheme().textColor
        layer.cornerRadius = 10
        layer.masksToBounds = false
        textContainerInset = padding
    }

}
