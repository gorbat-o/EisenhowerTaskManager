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
    @IBOutlet weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Performance.start(withKey: "Splashscreen: viewDidLoad")
        if firstTimeLaunchedApp() {
            try? Auth.auth().signOut()
            setupSignInVC()
        } else {
            setupMainVC()
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
            setupSignInVC()
        } else {
            let mainVC = MainVC()
            UIApplication.shared.delegate?.window??.rootViewController = mainVC
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
