//
//  SignUpVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTextFields()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SnackBarHelper.dismiss()
        self.dismissKeyboard()
    }

    @IBAction func signUpTouchUpInside(_ sender: Any? = nil) {
        self.dismissKeyboard()
        self.checkTextFields {
            self.signUp {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController = MainVC()
                }
            }
        }
    }
}

extension SignUpVC {
    private func setupNavigationBar() {
        self.title = L10n.Generic.signUp
    }

    private func setupTextFields() {
        self.usernameTextField?.placeholder = L10n.Generic.email
        self.passwordTextField?.placeholder = L10n.Generic.password
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    private func signUp(success: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: self.usernameTextField?.text ?? "",
                               password: self.passwordTextField?.text ?? "") { returnedUser, returnedError in
                                if let error = returnedError {
                                    SnackBarHelper.showError(withText: error.localizedDescription)
                                } else {
                                    SnackBarHelper.showSuccess(
                                        withText: L10n.Generic.welcome + " " + (returnedUser?.displayName ?? "")
                                    )
                                    success()
                                }
        }
    }

    private func checkTextFields(success: () -> Void) {
        if self.usernameTextField?.text == nil || (self.usernameTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyEmailField)
            return
        }
        if self.passwordTextField?.text == nil || (self.passwordTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyPasswordField)
            return
        }
        success()
    }
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField?.becomeFirstResponder()
        case self.passwordTextField:
            self.view?.endEditing(true)
            self.signUpTouchUpInside()
        default:
            break
        }
        return true
    }
}
