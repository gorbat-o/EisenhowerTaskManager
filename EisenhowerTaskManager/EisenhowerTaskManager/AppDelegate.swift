//
//  AppDelegate.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 26/02/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupFirebase()
        self.setupMainView()
        return true
    }
}

extension AppDelegate {
    private func setupMainView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashScreenVC()
        self.window?.makeKeyAndVisible()
    }

    private func setupFirebase() {
        if let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: filePath) {
            FirebaseApp.configure(options: options)
        }
    }
}
