//
//  SnackBarHelper.swift
//  EisenhowerTaskManager-development
//
//  Created by Oleg GORBATCHEV on 05/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import UIKit
import TTGSnackbar

class SnackBarHelper {
    static private let noActionSnackBar = TTGSnackbar(message: "", duration: TTGSnackbarDuration.middle)

    class func showError(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        SnackBarHelper.noActionSnackBar.show()
    }

    class func showSuccess(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        SnackBarHelper.noActionSnackBar.show()
    }

    class func showInformation(withText text: String) {
        SnackBarHelper.noActionSnackBar.message = text
        SnackBarHelper.noActionSnackBar.show()
    }

    class func dismiss() {
        SnackBarHelper.noActionSnackBar.dismiss()
    }

    private init() {}
}
