//
//  SignUpVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
}

extension SignUpVC {
    private func setupNavigationBar() {
        self.title = "Sign Up"
    }
}
