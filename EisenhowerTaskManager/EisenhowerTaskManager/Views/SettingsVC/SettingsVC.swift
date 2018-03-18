//
//  SettingsVC.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 11/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import Eureka
import FirebaseAuth

class SettingsVC: FormViewController {

	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Settings"

		form +++ Section("User")
			<<< ButtonRow {
				$0.title = "Profile"
				$0.presentationMode = .show(controllerProvider: .callback(builder: {
					let profileView = ProfileVC()
					return profileView
					}), onDismiss: nil)
			}
			+++ Section()
			<<< ButtonRow {
				$0.title = "Disconnect"
				$0.onCellSelection { _, _ in
					self.disconnect()
				}
		}
    }
}

extension SettingsVC {
	private func disconnect() {
		print("Disconnect!")
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
