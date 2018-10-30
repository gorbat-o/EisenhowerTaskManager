//
//  SignUpVC.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebasePerformance
import FirebaseDatabase
import DSGradientProgressView
import SafariServices

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var progressView: DSGradientProgressView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var termsAndConditionsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        Performance.start(withKey: "\(L10n.Generic.registration) viewDidLoad")
        setupNavigationBar()
        setupButtons()
        setupProgressView()
        setupTextFields()
        Performance.stop()
    }

    override func viewWillDisappear(_ animated: Bool) {
        SnackBarHelper.dismiss()
        progressView.signal()
        dismissKeyboard()
    }

    @IBAction func signUpTouchUpInside(_ sender: Any? = nil) {
        dismissKeyboard()
        checkTextFields {
            progressView.wait()
            signUp { [weak self] in
                self?.setupMainView()
            }
        }
    }

    @IBAction func termsAndConditionsTouchUpInside(_ sender: Any) {
        let databaseReference = Database.database().reference().child("public")
        databaseReference.observeSingleEvent(of: DataEventType.value) { [weak self] snapshot in
            if let data = snapshot.value as? [String: AnyObject],
                let termsConditions = data["termsConditions"] as? String,
                let url = URL(string: termsConditions) {
                let vc = SFSafariViewController(url: url)
                self?.present(vc, animated: true)
            }
        }
    }
}

extension SignUpVC {
    private func setupNavigationBar() {
        title = L10n.Generic.registration
    }

    private func setupTextFields() {
        usernameTextField?.placeholder = L10n.Generic.email
        passwordTextField?.placeholder = L10n.Generic.password
        usernameTextField?.delegate = self
        passwordTextField?.delegate = self
    }

    private func setupProgressView() {
        progressView?.barColor = UIColor.darkGray
        progressView?.wait()
        progressView?.signal()
    }

    private func setupButtons() {
        signUpButton?.isHaptic = true
        signUpButton?.hapticType = .impact(.light)
        termsAndConditionsButton?.isHaptic = true
        termsAndConditionsButton?.hapticType = .impact(.light)
    }

    private func signUp(success: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: usernameTextField?.text ?? "",
                               password: passwordTextField?.text ?? "") { [weak self] returnedUser, returnedError in
                                if let error = returnedError {
                                    SnackBarHelper.showError(withText: error.localizedDescription)
                                } else {
                                    SnackBarHelper.showSuccess(
                                        withText: L10n.Generic.welcome + " " + (returnedUser?.user.displayName ?? "")
                                    )
                                    success()
                                }
                                self?.progressView.signal()
        }
    }

    private func setupMainView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = MainVC()
        }
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
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField?.becomeFirstResponder()
        case passwordTextField:
            view?.endEditing(true)
            signUpTouchUpInside()
        default:
            break
        }
        return true
    }
}
