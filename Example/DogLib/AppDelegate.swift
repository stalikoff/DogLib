//
//  AppDelegate.swift
//  DogLib
//
//  Created by Oleg Vasilev on 12/26/2022.
//  Copyright (c) 2022 Oleg Vasilev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainAssembly.createModule()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
