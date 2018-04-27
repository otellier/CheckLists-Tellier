//
//  AppDelegate.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("Function: \(#function)")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      print("Function: \(#function)")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Function: \(#function)")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       print("Function: \(#function)")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Function: \(#function)")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Function: \(#function)")
    }


}

