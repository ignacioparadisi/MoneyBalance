//
//  AppDelegate.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        Localize.verifyLanguage()
        
        let mainVC = UINavigationController(rootViewController: HomeViewController())
        // mainVC.selectedIndex = 1
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Utils.isAuthenticationEnabled() ? LauncherViewController(mainVC) : mainVC
        
        // Apply theme before showing the views
        // TODO: - Cuando se ejecuta no cambia el color de las letras de la celda de idioma
        ThemeManager.applayTheme(ThemeManager.currentTheme())
        RealmManager.shared.createCurrencies()
        if let currentCurrency = RealmManager.shared.getArray(ofType: Currency.self, filter: "selected == true") as? [Currency], currentCurrency.count > 0 {
            Currency.setCurrent(currentCurrency[0])
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        // if window?.rootViewController is MainViewController {
        // if let navigationController = window?.rootViewController as? UINavigationController, navigationController.topViewController is HomeViewController {
            currentViewController = window?.rootViewController
        // }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // window?.rootViewController = Utils.isAuthenticationEnabled() ? LauncherViewController(currentViewController) : MainViewController()
        window?.rootViewController = Utils.isAuthenticationEnabled() ? LauncherViewController(currentViewController) : currentViewController
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

