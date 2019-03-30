//
//  TitleTableViewHeader.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/30/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol TitleTableViewHeaderDelegate: class {
    func tappedHeaderRightButton()
}

class TitleTableViewHeader: UIView {
    
    lazy var titleLabel = TitleLabel()
    lazy var rightButton = UIButton()
    weak var delegate: TitleTableViewHeaderDelegate?

//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        initialize()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = ThemeManager.currentTheme().backgroundColor
        titleLabel.textColor = ThemeManager.currentTheme().textColor
        addSubview(titleLabel)
        titleLabel.setConstraints(topAnchor: topAnchor, leadingAnchor: leadingAnchor, bottomAnchor: bottomAnchor, trailingAnchor: trailingAnchor, topConstant: 16, leadingConstant: 16, bottomConstant: -16, trailingConstant: -16)
    }
    
    func setRightItem(with text: String? = nil, image: UIImage? = nil, delegate: TitleTableViewHeaderDelegate) {
        self.delegate = delegate
        if let text = text {
            rightButton.setTitle(text, for: .normal)
            rightButton.setTitleColor(ThemeManager.currentTheme().accentColor, for: .normal)
        }
        if let image = image {
            let renderedImage = image.withRenderingMode(.alwaysTemplate)
            rightButton.setImage(renderedImage, for: .normal)
            rightButton.tintColor = ThemeManager.currentTheme().accentColor
        }
        rightButton.addTarget(self, action: #selector(tappedRightButton), for: .touchUpInside)
        addSubview(rightButton)
        rightButton.setConstraints(trailingAnchor: trailingAnchor, centerYAnchor: centerYAnchor, trailingConstant: -16)
    }
    
    @objc private func tappedRightButton() {
        delegate?.tappedHeaderRightButton()
    }
    
}
