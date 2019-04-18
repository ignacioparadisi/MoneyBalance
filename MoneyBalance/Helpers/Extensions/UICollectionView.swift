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

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
