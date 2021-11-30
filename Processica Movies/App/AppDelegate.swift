//
//  AppDelegate.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppManager.shared.start()
        startApp()
        return true
    }
    
    private func startApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = Controller.getMainNavigationController()
        window.rootViewController = vc
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

