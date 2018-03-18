//
//  SingInVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebasePerformance
import Haptica
import DSGradientProgressView

class SignInVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var progressView: DSGradientProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Performance.start(withKey: "\(L10n.Generic.authentication) viewDidLoad")
        setupNavigationBar()
        setupTextFields()
        setupButtons()
        setupProgressView()
        setupHideKeyboardWhenTappedAround()
        Performance.stop()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SnackBarHelper.dismiss()
        progressView.signal()
        dismissKeyboard()
    }

    @IBAction func signInTouchUpInside(_ sender: Any? = nil) {
        dismissKeyboard()
        checkTextFields {
            progressView.wait()
            signIn { [weak self] in
                self?.setupMainView()
            }
        }
    }

    @IBAction func signUpTouchUpInside(_ sender: Any? = nil) {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension SignInVC {
    private func setupNavigationBar() {
        title = L10n.Generic.authentication
    }

    private func setupMainView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = MainVC()
        }
    }

    private func setupProgressView() {
        progressView?.barColor = UIColor.darkGray
        progressView?.wait()
        progressView?.signal()
    }

    private func setupButtons() {
        signInButton?.isHaptic = true
        signInButton?.hapticType = .impact(.light)
        signUpButton?.isHaptic = true
        signUpButton?.hapticType = .impact(.light)
    }

    private func setupTextFields() {
        usernameTextField?.placeholder = L10n.Generic.email
        passwordTextField?.placeholder = L10n.Generic.password
        usernameTextField?.delegate = self
        passwordTextField?.delegate = self
    }

    private func checkTextFields(success: () -> Void) {
        if usernameTextField?.text == nil || (usernameTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyEmailField)
            return
        }
        if passwordTextField?.text == nil || (passwordTextField?.text ?? "").isEmpty {
            SnackBarHelper.showError(withText: L10n.Error.emptyPasswordField)
            return
        }
        success()
    }

    private func signIn(success: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: usernameTextField?.text ?? "",
                           password: passwordTextField?.text ?? "") { [weak self] returnedUser, returnedError in
                            if let error = returnedError {
                                SnackBarHelper.showError(withText: error.localizedDescription)
                            } else {
                                SnackBarHelper.showSuccess(
                                    withText: L10n.Generic.welcome + " " + (returnedUser?.displayName ?? "")
                                )
                                success()
                            }
                            self?.progressView.signal()
        }
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField?.becomeFirstResponder()
        case passwordTextField:
            view?.endEditing(true)
            signInTouchUpInside()
        default:
            break
        }
        return true
    }
}
