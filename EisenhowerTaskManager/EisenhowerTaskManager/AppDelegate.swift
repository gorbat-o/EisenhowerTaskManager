//
//  AppDelegate.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 26/02/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
#if ADHOC || APPSTORE
    import Fabric
    import Crashlytics
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var databaseReference: DatabaseReference?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        setupMainView()
        setupFabric()
        return true
    }
}

extension AppDelegate {
    private func setupMainView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashScreenVC()
        window?.makeKeyAndVisible()
    }

    private func setupFirebase() {
        if let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: filePath) {
            FirebaseApp.configure(options: options)
            databaseReference = Database.database().reference()
        }
    }

    private func setupFabric() {
        #if ADHOC || APPSTORE
            Fabric.with([Crashlytics.self])
        #endif
    }
}
