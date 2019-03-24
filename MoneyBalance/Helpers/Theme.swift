//
//  Theme.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/5/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

let THEME_KEY = "SelectedTheme"

/// Defines the variables for the app theme
enum Theme: Int {
    case light, dark

    var titleFont: String {
        return "HelveticaNeue-Bold"
    }
    
    var accentColor: UIColor {
        switch self {
        case .light:
            return UIColor("007AFF")
        case .dark:
            // return UIColor("4CD963")
            return UIColor("FD2D55")
        }
    }
    
    var gradientColor: UIColor {
        switch self {
        case .light:
            // return UIColor("#9300E0")
            return UIColor("#52C6A7")
        case .dark:
            return UIColor("FD582F")
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor("#FFFFFF")
        case .dark:
            return UIColor("#111111")
        }
    }
    
    var lightBackgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor("EEEEEE")
        case .dark:
            return UIColor("333333")
        }
    }
    
    var tabBarBackgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor("F5F5F7")
        case .dark:
            return UIColor("1B1B1B")
        }
    }

    var tableViewBackgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor("EFEFF4")
        case .dark:
            return UIColor("181818")
        }
    }

    var textColor: UIColor {
        switch self {
        case .light:
            return UIColor("#000000")
        case .dark:
            return UIColor("#FFFFFF")
        }
    }
    
    var lightTextColor: UIColor {
        switch self {
        case .light:
            return .lightGray
        case .dark:
            return .white
        }
    }
    
    var highlightTableViewCellColor: UIColor {
        switch self {
        case .light:
            return UIColor("D9D9D9")
        case .dark:
            return UIColor("333333")
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .black
        }
    }
}

/// Manages the theme changing and gets the current theme
struct ThemeManager {

    /// Defines which theme to use
    ///
    /// - Returns: Current selected theme
    static func currentTheme() ->  Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: THEME_KEY) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .light
        }
    }

    /// Adds a transition when changing the theme
    ///
    /// - Parameter theme: Selected theme
    static func applayTheme(_ theme: Theme) {
        if let window = UIApplication.shared.delegate?.window, let unwrappedWindow = window {
            UIView.transition(
                with: unwrappedWindow,
                duration: 0.2,
                options: [.transitionCrossDissolve],
                animations: {
                    self.apply(theme)
            },
                completion: nil
            )
        }
    }
    
    /// Sets the current theme in UserDefaults and makes the changes to the global views
    ///
    /// - Parameter theme: Selected theme
    private static func apply(_ theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: THEME_KEY)
        UserDefaults.standard.synchronize()
        
        setupNavigationBarAppearance(theme)
        setupTabBarAppearance(theme)
        setupLabelAppearance(theme)
        setupTableViewAppearance(theme)
        setupTableViewCellAppearance(theme)
        
//        let windows = UIApplication.shared.windows
//        for window in windows {
//            print("Window: \(window)")
//            for view in window.subviews {
//                print("View: \(view)")
//                view.removeFromSuperview()
//                window.addSubview(view)
//            }
//        }
        UIApplication.shared.delegate?.window??.tintColor = theme.accentColor
    }
    
    /// Applies changes to all UINavigationBars
    ///
    /// - Parameter theme: Selected theme
    private static func setupNavigationBarAppearance(_ theme: Theme) {
        UINavigationBar.appearance().barStyle = theme.barStyle
    }
    
    /// Applies changes to all UITabBars
    ///
    /// - Parameter theme: Selected theme
    private static func setupTabBarAppearance(_ theme: Theme) {
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().tintColor = theme.accentColor
    }
    
    /// Applies changes to all UILabels
    ///
    /// - Parameter theme: Selected theme
    private static func setupLabelAppearance(_ theme: Theme) {
        UILabel.appearance().textColor = theme.textColor
    }
    
    /// Applies changes to all UITableViews
    ///
    /// - Parameter theme: Selected theme
    private static func setupTableViewAppearance(_ theme: Theme) {
        UITableView.appearance().backgroundColor = theme.tableViewBackgroundColor
    }
    
    /// Applies changes to all UITableCells
    ///
    /// - Parameter theme: Selected theme
    private static func setupTableViewCellAppearance(_ theme: Theme) {
        UITableViewCell.appearance().backgroundColor = theme.backgroundColor
    }
    
}
