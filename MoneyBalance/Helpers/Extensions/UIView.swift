//
//  UIView.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/23/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

extension UIView {
    /// Sets constraints to the view
    ///
    /// - Parameters:
    ///   - topAnchor: Top constraint for the view
    ///   - leadingAnchor: Leading constraint for the view
    ///   - bottomAnchor: Bottom constraint for the view
    ///   - trailingAnchor: Trailing constraint for the view
    ///   - centerXAnchor: Center X constraint for the view
    ///   - centerYAnchor: Center Y constraint for the view
    ///   - topConstant: Top margin
    ///   - leadingConstant: Leading margin
    ///   - bottomConstant: Bottom margin
    ///   - trailingConstant: Trailing margin
    ///   - widthConstant: Width of the view
    ///   - heightConstant: Height of the view
    func setConstraints(topAnchor: NSLayoutYAxisAnchor? = nil, leadingAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, trailingAnchor: NSLayoutXAxisAnchor? = nil, centerXAnchor: NSLayoutXAxisAnchor? = nil, centerYAnchor: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, trailingConstant: CGFloat = 0, widthConstant: CGFloat? = nil, heightConstant: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        if let topAnchor = topAnchor {
            constraints.append(self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant))
        }
        
        if let trailingAnchor = trailingAnchor {
            constraints.append(self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant))
        }
        
        if let bottomAnchor = bottomAnchor {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant))
        }
        
        if let leadingAnchor = leadingAnchor {
            constraints.append(self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant))
        }
        
        if let centerXAnchor = centerXAnchor {
            constraints.append(self.centerXAnchor.constraint(equalTo: centerXAnchor))
        }
        
        if let centerYAnchor = centerYAnchor {
            constraints.append(self.centerYAnchor.constraint(equalTo: centerYAnchor))
        }
                
        if let widthConstant = widthConstant {
            constraints.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if let heightConstant = heightConstant {
            constraints.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        constraints.forEach { $0.isActive = true }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, locations: [NSNumber] = [0.0, 1.0], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), cornerRadius: CGFloat = 0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = cornerRadius
        // gradientLayer.masksToBounds = false
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
