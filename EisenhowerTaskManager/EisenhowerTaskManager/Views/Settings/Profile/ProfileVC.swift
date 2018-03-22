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
        title = "Profile"
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
    }

    private func changeEmail() {
        let mailRow1: EmailRow? = form.rowBy(tag: "newemail1")
        let mail1 = mailRow1?.value
        let mailRow2: EmailRow? = form.rowBy(tag: "newemail2")
        let mail2 = mailRow2?.value

        if mail1 == mail2 {
            Auth.auth().currentUser?.updateEmail(to: mail1!, completion: { (error) in
                if error != nil {
                    SnackBarHelper.showError(withText: (error?.localizedDescription)!)
                } else {
                    SnackBarHelper.showSuccess(withText: "E-mail successfully updated")
                }

            })
        } else {
            SnackBarHelper.showError(withText: "E-mails don't match")
        }
    }

    private func changePassword() {
        let pwdRow1: GenericPasswordRow? = form.rowBy(tag: "newpwd1")
        let pwd1 = pwdRow1?.value
        let pwdRow2: GenericPasswordRow? = form.rowBy(tag: "newpwd2")
        let pwd2 = pwdRow2?.value

        if pwd1 == pwd2 {
            Auth.auth().currentUser?.updatePassword(to: pwd1!, completion: { (error) in
                if error != nil {
                    SnackBarHelper.showError(withText: (error?.localizedDescription)!)
                } else {
                    SnackBarHelper.showSuccess(withText: "Password successfully updated")
                }

            })
        } else {
            SnackBarHelper.showError(withText: "Passwords don't match")
        }
    }
}
