//
//  AppDelegate.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            let viewController = ProductTableViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window!.rootViewController = navigationController
        }

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // iOS 13 setup is done in SceneDelegate
        } else {
            self.window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
         // iOS 13 setup is done in SceneDelegate
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         // iOS 13 setup is done in SceneDelegate
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // iOS 13 setup is done in SceneDelegate
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         // iOS 13 setup is done in SceneDelegate
    }


    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
