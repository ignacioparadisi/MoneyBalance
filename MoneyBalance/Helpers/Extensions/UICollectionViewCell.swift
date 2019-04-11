//
//  UICollectionViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 4/11/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension UIView {
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.3) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            } else {
                self.transform = .identity
            }
        }
    }
}
