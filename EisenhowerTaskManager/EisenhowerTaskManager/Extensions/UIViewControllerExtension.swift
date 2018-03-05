//
//  UIViewControllerExtension.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(leftButtonWithImageNamed name: String, andAction action: Selector) {
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: name), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: action, for: .touchUpInside)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.setLeftBarButton(leftButtonItem, animated: true)
    }

    func setupNavigationBar(rightButtonWithImageNamed name: String, andAction action: Selector) {
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: name), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.addTarget(self, action: action, for: .touchUpInside)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.setRightBarButton(rightButtonItem, animated: true)
    }

    func setupNavigationBar(leftButtonWithTitle buttonTitle: String, andAction action: Selector) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                                style: .plain,
                                                                target: self,
                                                                action: action)
    }

    func setupNavigationBar(rightButtonWithTitle buttonTitle: String, andAction action: Selector) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: action)
    }

    func setupHideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
