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
        setup3DTouch(application)
        return true
    }

    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "AddTask":
            States.isForceTouchAddTask = true
            let splashScreenVC = SplashScreenVC()
            UIApplication.shared.keyWindow?.rootViewController?.present(splashScreenVC, animated: false) {
                completionHandler(true)
            }
        case "ShareTheApp":
            // Waiting the iTunes link to be available :)
            break
        default:
            break
        }
    }
}

extension AppDelegate {
    private func setupMainView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashScreenVC()
        window?.makeKeyAndVisible()
    }

    private func setup3DTouch(_ application: UIApplication) {
        if let shortcutItems = application.shortcutItems, shortcutItems.isEmpty {
            let addTaskShortcut = UIMutableApplicationShortcutItem(
                type: "AddTask",
                localizedTitle: "Create a task",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.add),
                userInfo: nil
            )
            // Waiting the iTunes link to be available :)
            //            let shareTaskShortcut = UIMutableApplicationShortcutItem(
            //                type: "ShareTheApp",
            //                localizedTitle: "Share the app",
            //                localizedSubtitle: nil,
            //                icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.share),
            //                userInfo: nil
            //            )
            application.shortcutItems = [addTaskShortcut]
        }
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
