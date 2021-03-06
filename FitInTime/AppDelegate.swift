//
//  AppDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import UserNotifications

// Change status bar to white
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavBarAppearance()
        setupNotificationRequestAndDelegate()
        checkUserDefaultsValues()
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let mainTabBarController = MainTabBarController()
        window?.rootViewController = mainTabBarController
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    fileprivate func checkUserDefaultsValues() {
        if UserDefaults.standard.value(forKey: "automaticTimerSwitchIsOn") == nil {
            UserDefaults.standard.set(true, forKey: "automaticTimerSwitchIsOn")
        }
        if UserDefaults.standard.value(forKey: "automaticAddedAnimationSwitchIsOn") == nil {
            UserDefaults.standard.set(true, forKey: "automaticAddedAnimationSwitchIsOn")
        }
    }
    
    fileprivate func setupNavBarAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.barTintColor = .mainColor
        navigationBarAppearance.prefersLargeTitles = true
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    fileprivate func setupNotificationRequestAndDelegate() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, err) in
            if let err = err {
                print(err)
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

