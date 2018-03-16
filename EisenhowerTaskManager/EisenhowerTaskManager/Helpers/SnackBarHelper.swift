//
//  SnackBarHelper.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import TTGSnackbar
import Haptica

class SnackBarHelper {
    static private let noActionSnackBar = TTGSnackbar(message: "", duration: TTGSnackbarDuration.middle)
    static private let impactFeedbackStyle = UIImpactFeedbackStyle.medium

    class func showError(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        Haptic.impact(impactFeedbackStyle).generate()
        SnackBarHelper.noActionSnackBar.show()
    }

    class func showSuccess(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        Haptic.impact(impactFeedbackStyle).generate()
        SnackBarHelper.noActionSnackBar.show()
    }

    class func showInformation(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        Haptic.impact(impactFeedbackStyle).generate()
        SnackBarHelper.noActionSnackBar.show()
    }

    class func dismiss() {
        SnackBarHelper.noActionSnackBar.dismiss()
    }

    private init() {}
}
