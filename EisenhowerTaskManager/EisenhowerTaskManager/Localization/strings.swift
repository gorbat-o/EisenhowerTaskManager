// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Action {
    /// Choose the category
    static let chooseTheCategory = L10n.tr("Localizable", "action.chooseTheCategory")
    /// Put a title
    static let putATitle = L10n.tr("Localizable", "action.putATitle")
  }

  enum Error {
    /// Email field is empty
    static let emptyEmailField = L10n.tr("Localizable", "error.emptyEmailField")
    /// Password field is empty
    static let emptyPasswordField = L10n.tr("Localizable", "error.emptyPasswordField")
  }

  enum Generic {
    /// Add
    static let add = L10n.tr("Localizable", "generic.add")
    /// All
    static let all = L10n.tr("Localizable", "generic.all")
    /// Cancel
    static let cancel = L10n.tr("Localizable", "generic.cancel")
    /// Category
    static let category = L10n.tr("Localizable", "generic.category")
    /// Completed
    static let completed = L10n.tr("Localizable", "generic.completed")
    /// Description
    static let description = L10n.tr("Localizable", "generic.description")
    /// Do First
    static let doFirst = L10n.tr("Localizable", "generic.doFirst")
    /// Done
    static let done = L10n.tr("Localizable", "generic.done")
    /// Email
    static let email = L10n.tr("Localizable", "generic.email")
    /// For
    static let `for` = L10n.tr("Localizable", "generic.for")
    /// Incomplete
    static let incomplete = L10n.tr("Localizable", "generic.incomplete")
    /// Matrix
    static let matrix = L10n.tr("Localizable", "generic.matrix")
    /// Password
    static let password = L10n.tr("Localizable", "generic.password")
    /// Settings
    static let settings = L10n.tr("Localizable", "generic.settings")
    /// Sign In
    static let signIn = L10n.tr("Localizable", "generic.signIn")
    /// Sign Up
    static let signUp = L10n.tr("Localizable", "generic.signUp")
    /// Task
    static let task = L10n.tr("Localizable", "generic.task")
    /// Task creation
    static let taskCreation = L10n.tr("Localizable", "generic.taskCreation")
    /// Title
    static let title = L10n.tr("Localizable", "generic.title")
    /// To Delegate
    static let toDelegate = L10n.tr("Localizable", "generic.toDelegate")
    /// To Not Do
    static let toNotDo = L10n.tr("Localizable", "generic.toNotDo")
    /// To Schedule
    static let toSchedule = L10n.tr("Localizable", "generic.toSchedule")
    /// Welcome
    static let welcome = L10n.tr("Localizable", "generic.welcome")
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
