//
//  MainVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 11/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
}

extension MainVC {
    private func setupTabBarController() {
        let matrixTab = UINavigationController(rootViewController: MatrixVC())
        let matrixTabBarItem = UITabBarItem(title: L10n.Generic.matrix,
                                            image: UIImage(named: "Matrix"),
                                            selectedImage: UIImage(named: "Matrix"))
        matrixTab.tabBarItem = matrixTabBarItem
        let settingsTab = UINavigationController(rootViewController: SettingsVC())
        let settingsTabBarItem = UITabBarItem(title: "Settings",
                                              image: UIImage(named: "Settings"),
                                              selectedImage: UIImage(named: "Settings"))
        settingsTab.tabBarItem = settingsTabBarItem
        self.viewControllers = [matrixTab, settingsTab]
    }
}
