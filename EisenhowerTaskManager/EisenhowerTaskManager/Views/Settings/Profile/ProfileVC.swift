//
//  ProfileVC.swift
//  EisenhowerTaskManager
//
//  Created by Samy Kettani on 14/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Eureka
import GenericPasswordRow
import FirebaseAuth

class ProfileVC: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }
}

extension ProfileVC {
    private func setupNavigationBar() {
        title = L10n.Generic.profile
    }

    private func setupTableView() {
        form
            +++ Section ("Update email")
            <<< EmailRow {
                $0.title = "New email"
                $0.tag = "newemail1"
            }
            <<< EmailRow {
                $0.title = "Email confirmation"
                $0.tag = "newemail2"
            }
            <<< ButtonRow {
                $0.title = "Change email"
                $0.onCellSelection { [weak self] _, _ in
                    self?.changeEmail()
                }
            }
            +++ Section("Update password")
            <<< GenericPasswordRow {
                $0.tag = "newpwd1"
            }
            <<< GenericPasswordRow {
                $0.tag = "newpwd2"
            }
            <<< ButtonRow {
                $0.title = "Change password"
                $0.onCellSelection { [weak self] _, _ in
                    self?.changePassword()
                }
            }
            +++ Section()
            <<< ButtonRow {
                $0.title = L10n.Generic.signOut
                $0.baseCell.tintColor = UIColor.red
                $0.onCellSelection { [weak self] _, _ in
                    self?.disconnect()
                }
        }
    }

    private func changeEmail() {
        guard let mail1: String = (form.rowBy(tag: "newemail1"))?.value else {
            SnackBarHelper.showError(withText: "New email is empty")
            return
        }
        guard let mail2: String = (form.rowBy(tag: "newemail2"))?.value else {
            SnackBarHelper.showError(withText: "New email confirmation is empty")
            return
        }
        if mail1 == mail2 {
            Auth.auth().currentUser?.updateEmail(to: mail1) { error in
                if error != nil {
                    SnackBarHelper.showError(withText: error?.localizedDescription ?? "Error")
                } else {
                    SnackBarHelper.showSuccess(withText: "E-mail successfully updated")
                }
            }
        } else {
            SnackBarHelper.showError(withText: "E-mails don't match")
        }
    }

    private func changePassword() {
        guard let pwd1: String = (form.rowBy(tag: "newpwd1"))?.value else {
            SnackBarHelper.showError(withText: "New password is empty")
            return
        }
        guard let pwd2: String = (form.rowBy(tag: "newpwd2"))?.value else {
            SnackBarHelper.showError(withText: "New password confirmation is empty")
            return
        }
        if pwd1 == pwd2 {
            Auth.auth().currentUser?.updatePassword(to: pwd1) { error in
                if error != nil {
                    SnackBarHelper.showError(withText: error?.localizedDescription ?? "Error")
                } else {
                    SnackBarHelper.showSuccess(withText: "Password successfully updated")
                }
            }
        } else {
            SnackBarHelper.showError(withText: "Passwords don't match")
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
}
