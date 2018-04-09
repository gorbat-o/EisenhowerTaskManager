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
                $0.title = L10n.Settings.ProfileRow.title
                $0.baseCell.imageView?.image = UIImage(named: "Profile") ?? UIImage()
                $0.presentationMode = .show(controllerProvider: .callback { [weak self] in
                    return self?.profileView ?? ProfileVC()
                    }, onDismiss: nil)
            }
            +++ Section()
            <<< ButtonRow {
                $0.title = "Disconnect"
                $0.onCellSelection { [weak self] _, _ in
                    self?.askToDisconnect()
                }
        }
    }

    private func disconnect() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            SnackBarHelper.showError(withText: signOutError.localizedDescription)
            return
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = SignInVC()
        }
    }

    private func askToDisconnect() {
        let alertController = UIAlertController(title: L10n.Popup.Disconnectaction.title,
                                                message: L10n.Popup.Disconnectaction.text,
                                                preferredStyle: .alert)
        let yesAction = UIAlertAction(title: L10n.Generic.yes, style: .destructive) { [weak self] _ in
            self?.disconnect()
        }
        let noAction = UIAlertAction(title: L10n.Generic.no, style: .cancel)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
