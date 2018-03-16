//
//  SingInVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Haptica
import LinearProgressBarMaterial

class SignInVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    private let linearBar = LinearProgressBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTextFields()
        self.setupButtons()
        self.setupLinearBar()
        self.setupHideKeyboardWhenTappedAround()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SnackBarHelper.dismiss()
        linearBar.stopAnimation()
        self.dismissKeyboard()
    }

    @IBAction func signInTouchUpInside(_ sender: Any? = nil) {
        self.dismissKeyboard()
        linearBar.startAnimation()
        self.checkTextFields {
            self.signIn {
                self.setupMainView()
            }
        }
    }

    @IBAction func signUpTouchUpInside(_ sender: Any? = nil) {
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension SignInVC {
    private func setupNavigationBar() {
        self.title = L10n.Generic.signIn
    }

    private func setupMainView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = MainVC()
        }
    }

    private func setupLinearBar() {
        // A revoir c'est pas bon, ne pas oublier que l'intégration de firebase avec crashlytics il faut fix
        linearBar.layer.frame.origin.y = (navigationController?.navigationBar.frame.height ?? 0) * 2
    }

    private func setupButtons() {
        signInButton.isHaptic = true
        signInButton.hapticType = .impact(.light)
    }

    private func setupTextFields() {
        self.usernameTextField?.placeholder = L10n.Generic.email
        self.passwordTextField?.placeholder = L10n.Generic.password
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    private func checkTextFields(success: () -> Void) {
        if self.usernameTextField?.text == nil || (self.usernameTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyEmailField)
            linearBar.stopAnimation()
            return
        }
        if self.passwordTextField?.text == nil || (self.passwordTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyPasswordField)
            linearBar.stopAnimation()
            return
        }
        success()
    }

    private func signIn(success: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: self.usernameTextField?.text ?? "",
                           password: self.passwordTextField?.text ?? "") { [weak self] returnedUser, returnedError in
                            if let error = returnedError {
                                SnackBarHelper.showError(withText: error.localizedDescription)
                            } else {
                                SnackBarHelper.showSuccess(
                                    withText: L10n.Generic.welcome + " " + (returnedUser?.displayName ?? "")
                                )
                                success()
                            }
                            self?.linearBar.stopAnimation()
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
