//
//  SettingsVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 11/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Eureka

class SettingsVC: FormViewController {
    private let profileView = ProfileVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }
}

extension SettingsVC {
    private func setupNavigationBar() {
        title = L10n.Generic.settings
    }

    private func setupTableView() {
        form +++ Section()
            <<< ButtonRow {
                $0.title = L10n.Settings.Profilerow.title
                $0.baseCell.imageView?.image = UIImage(named: "Profile") ?? UIImage()
                $0.presentationMode = .show(controllerProvider: .callback { [weak self] in
                    return self?.profileView ?? ProfileVC()
                    }, onDismiss: nil)
            }
    }
}
