// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Generic {
    /// Add
    static let add = L10n.tr("Localizable", "generic.add")
    /// All
    static let all = L10n.tr("Localizable", "generic.all")
    /// Completed
    static let completed = L10n.tr("Localizable", "generic.completed")
    /// Do First
    static let doFirst = L10n.tr("Localizable", "generic.doFirst")
    /// Incomplete
    static let incomplete = L10n.tr("Localizable", "generic.incomplete")
    /// Matrix
    static let matrix = L10n.tr("Localizable", "generic.matrix")
    /// To Delegate
    static let toDelegate = L10n.tr("Localizable", "generic.toDelegate")
    /// To Not Do
    static let toNotDo = L10n.tr("Localizable", "generic.toNotDo")
    /// To Schedule
    static let toSchedule = L10n.tr("Localizable", "generic.toSchedule")
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
