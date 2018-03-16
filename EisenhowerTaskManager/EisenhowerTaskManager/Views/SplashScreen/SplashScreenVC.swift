//
//  SplashScreenVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 26/02/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebasePerformance

class SplashScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        Performance.start(withKey: self.title)
        if self.firstTimeLaunchedApp() {
            try? Auth.auth().signOut()
            self.setupSignInVC()
        } else {
            self.setupMainVC()
        }
        Performance.stop()
    }
}

extension SplashScreenVC {
    private func setupSignInVC() {
        let vc = UINavigationController(rootViewController: SignInVC())
        UIApplication.shared.delegate?.window??.rootViewController = vc
    }

    private func setupMainVC() {
        if Auth.auth().currentUser == nil {
            self.setupSignInVC()
        } else {
            let vc = MainVC()
            UIApplication.shared.delegate?.window??.rootViewController = vc
        }
    }

    private func firstTimeLaunchedApp() -> Bool {
        if UserDefaults.standard.bool(forKey: "firstTimeLaunchedApp") == false {
            UserDefaults.standard.set(true, forKey: "firstTimeLaunchedApp")
            UserDefaults.standard.synchronize()
            return true
        } else {
            return false
        }
    }
}
