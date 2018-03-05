//
//  SplashScreenVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 26/02/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFirstView()
    }
}

extension SplashScreenVC {
    private func setupFirstView() {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            let vc = UINavigationController(rootViewController: SignInVC())
            UIApplication.shared.delegate?.window??.rootViewController = vc
        }
    }
}
