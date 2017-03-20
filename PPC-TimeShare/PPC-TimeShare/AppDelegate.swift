//
//  AppDelegate.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //delay splash screen
        Thread.sleep(forTimeInterval: 3)
        
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDiG0f3EhmYY4ylA_cmgOayR1KT9LYbl5E")
        
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible()
        let homeVC : HomeVC = HomeVC()
        
        window?.rootViewController = homeVC;
//        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        application.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(),for: .default)
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 43, green: 32, blue: 26)
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
        
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
    }


}

