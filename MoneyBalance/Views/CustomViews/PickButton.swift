//
//  PickButton.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/24/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

class PickButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        let image = UIImage(named: "disclosure")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .lightGray
        addSubview(imageView)
        imageView.setConstraints(trailingAnchor: trailingAnchor, centerYAnchor: centerYAnchor, trailingConstant: -10, widthConstant: 20, heightConstant: 20)
        
        setTitleColor(.lightGray, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 17.0)
        backgroundColor = ThemeManager.currentTheme().lightBackgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
