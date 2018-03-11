//
//  SingInVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTextFields()
        self.setupHideKeyboardWhenTappedAround()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SnackBarHelper.dismiss()
        self.dismissKeyboard()
    }

    @IBAction func signInTouchUpInside(_ sender: Any? = nil) {
        self.dismissKeyboard()
        self.checkTextFields {
            self.signIn()
        }
    }

    @IBAction func signUpTouchUpInside(_ sender: Any? = nil) {
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension SignInVC {
    private func setupNavigationBar() {
        self.title = "Sign In"
    }

    private func setupTextFields() {
        self.usernameTextField?.placeholder = "Mail"
        self.passwordTextField?.placeholder = "Password"
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    private func checkTextFields(success: () -> Void) {
        if self.usernameTextField?.text == nil || (self.usernameTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: "Username Texfield Empty")
            return
        }
        if self.passwordTextField?.text == nil || (self.passwordTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: "Password Texfield Empty")
            return
        }
        success()
    }

    private func signIn() {
        Auth.auth().signIn(withEmail: self.usernameTextField?.text ?? "",
                           password: self.passwordTextField?.text ?? "") { returnedUser, returnedError in
                            if let error = returnedError {
                                SnackBarHelper.showError(withText: error.localizedDescription)
                                return
                            }
                            SnackBarHelper.showSuccess(withText: "Welcome " + (returnedUser?.displayName ?? ""))
        }
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField?.becomeFirstResponder()
        case self.passwordTextField:
            self.view?.endEditing(true)
            self.signInTouchUpInside()
        default:
            break
        }
        return true
    }
}
