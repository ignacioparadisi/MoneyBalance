//
//  Extensions.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

// MARK: - UIView

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
    
    func makeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - UIColor

extension UIColor {
    /// Creates a UIColor from hexadecimal value
    ///
    /// - Parameter hex: Hexadecimal string representation
    convenience init(_ hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 127.5, green: 127.5, blue: 127.5, alpha: 1)
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

// MARK: - UIImageView

extension UIImageView {
    /// Sets a color for an icon
    ///
    /// - Parameter color: Color for the icon
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

// MARK: - Double

extension Double {
    func toCurrency() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale(identifier: "en_US")
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        return currencyFormatter.string(from: NSNumber(value: self))
    }
}

// MARK: - String

extension String {
    /// Localized a string
    ///
    /// - Returns: Localized string
    func localized() -> String {
        return Localize.localizeString(self) ?? ""
    }
}

