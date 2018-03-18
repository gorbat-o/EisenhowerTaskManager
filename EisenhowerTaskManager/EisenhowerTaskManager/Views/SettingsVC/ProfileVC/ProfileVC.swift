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
		self.title = "Profile"

		form +++ Section("Update password")
			<<< GenericPasswordRow {
				$0.tag = "newpwd1"
			}
			<<< GenericPasswordRow {
				$0.tag = "newpwd2"
			}
			<<< ButtonRow {
				$0.title = "Change password"
				$0.onCellSelection { _, _ in
					self.changePassword()
				}
		}
    }
}

extension ProfileVC {
	private func changePassword() {
		print("Hello there")

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
