// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Action {
    /// Choose the category
    internal static let chooseTheCategory = L10n.tr("Localizable", "action.chooseTheCategory")
    /// Put a title
    internal static let putATitle = L10n.tr("Localizable", "action.putATitle")
  }

  internal enum Error {
    /// Email field is empty
    internal static let emptyEmailField = L10n.tr("Localizable", "error.emptyEmailField")
    /// Password field is empty
    internal static let emptyPasswordField = L10n.tr("Localizable", "error.emptyPasswordField")
  }

  internal enum Generic {
    /// Add
    internal static let add = L10n.tr("Localizable", "generic.add")
    /// All
    internal static let all = L10n.tr("Localizable", "generic.all")
    /// Authentication
    internal static let authentication = L10n.tr("Localizable", "generic.authentication")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "generic.cancel")
    /// Category
    internal static let category = L10n.tr("Localizable", "generic.category")
    /// Completed
    internal static let completed = L10n.tr("Localizable", "generic.completed")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "generic.delete")
    /// Description
    internal static let description = L10n.tr("Localizable", "generic.description")
    /// Do First
    internal static let doFirst = L10n.tr("Localizable", "generic.doFirst")
    /// Done
    internal static let done = L10n.tr("Localizable", "generic.done")
    /// Email
    internal static let email = L10n.tr("Localizable", "generic.email")
    /// For
    internal static let `for` = L10n.tr("Localizable", "generic.for")
    /// Incomplete
    internal static let incomplete = L10n.tr("Localizable", "generic.incomplete")
    /// Matrix
    internal static let matrix = L10n.tr("Localizable", "generic.matrix")
    /// Password
    internal static let password = L10n.tr("Localizable", "generic.password")
    /// Registration
    internal static let registration = L10n.tr("Localizable", "generic.registration")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "generic.settings")
    /// Sign In
    internal static let signIn = L10n.tr("Localizable", "generic.signIn")
    /// Sign Up
    internal static let signUp = L10n.tr("Localizable", "generic.signUp")
    /// Task
    internal static let task = L10n.tr("Localizable", "generic.task")
    /// Task creation
    internal static let taskCreation = L10n.tr("Localizable", "generic.taskCreation")
    /// Title
    internal static let title = L10n.tr("Localizable", "generic.title")
    /// To Delegate
    internal static let toDelegate = L10n.tr("Localizable", "generic.toDelegate")
    /// To Not Do
    internal static let toNotDo = L10n.tr("Localizable", "generic.toNotDo")
    /// To Schedule
    internal static let toSchedule = L10n.tr("Localizable", "generic.toSchedule")
    /// Welcome
    internal static let welcome = L10n.tr("Localizable", "generic.welcome")
  }

  internal enum Popup {

    internal enum Disconnectaction {
      /// Are you sure you want to disconnect ?
      internal static let text = L10n.tr("Localizable", "popup.disconnectAction.text")
      /// Log out
      internal static let title = L10n.tr("Localizable", "popup.disconnectAction.title")
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
