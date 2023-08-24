// swiftlint:disable all
// This file was generated with Lingua command line tool. Please do not change it!
// Source: https://github.com/poviolabs/Lingua

import Foundation

enum Lingua {
	enum General {
		/// Choose
		static let choose = tr("General", "choose")
		/// Delete
		static let delete = tr("General", "delete")
		/// Duplicate
		static let duplicate = tr("General", "duplicate")
		/// Error
		static let error = tr("General", "error")
		/// Save
		static let save = tr("General", "save")
		/// Success
		static let success = tr("General", "success")
		/// this
		static let this = tr("General", "this")
	}

	enum ProjectForm {
		/// Configuration
		static let configurationSection = tr("ProjectForm", "configuration_section")
		/// Info
		static let infoHeader = tr("ProjectForm", "info_header")
		/// API Key *
		static let inputApiKey = tr("ProjectForm", "input_api_key")
		/// Choose Directory
		static let inputDirectoryButton = tr("ProjectForm", "input_directory_button")
		/// Output directory *
		static let inputDirectoryOutput = tr("ProjectForm", "input_directory_output")
		/// Name *
		static let inputProjectName = tr("ProjectForm", "input_project_name")
		/// Sheet ID *
		static let inputSheetId = tr("ProjectForm", "input_sheet_id")
		/// After you "Localize", you have to Add files to "%@"... in Xcode, if they are not added already
		static func iosLocalizationInfoMessage(_ param1: String) -> String {
			return tr("ProjectForm", "ios_localization_info_message", param1)
		}
		/// Lingua.swift Directory *
		static let linguaSwiftOutputDirectory = tr("ProjectForm", "lingua_swift_output_directory")
		/// Localize
		static let localizeButton = tr("ProjectForm", "localize_button")
		/// Platform *
		static let platformPickerTitle = tr("ProjectForm", "platform_picker_title")
		/// .strings Directory *
		static let stringsDirectory = tr("ProjectForm", "strings_directory")
		/// Since iOS does not have a built in feature to access the localization safely, we have made this possible using Lingua tool. Below you have to provide the path where the Swift file you want to be created. With that the tool will create Lingua.swift with an enumeration to easily access localizations in your app.
		static let swiftCodeDescription = tr("ProjectForm", "swift_code_description")
		/// iOS Swift Code Settings
		static let swiftCodeSection = tr("ProjectForm", "swift_code_section")
		/// Generate Swift Code
		static let swiftCodeToggleTitle = tr("ProjectForm", "swift_code_toggle_title")
	}

	enum Projects {
		/// %@ copy
		static func copyProject(_ param1: String) -> String {
			return tr("Projects", "copy_project", param1)
		}
		/// Are you sure you want to delete "%@" project?
		static func deleteAlertMessage(_ param1: String) -> String {
			return tr("Projects", "delete_alert_message", param1)
		}
		/// Confirmation
		static let deleteAlertTitle = tr("Projects", "delete_alert_title")
		/// "%@" has been successfully localized.
		static func localizedMessage(_ param1: String) -> String {
			return tr("Projects", "localized_message", param1)
		}
		/// Localizing...
		static let localizing = tr("Projects", "localizing")
		/// New project
		static let newProject = tr("Projects", "new_project")
		/// Select a project or add a new one.
		static let placeholder = tr("Projects", "placeholder")
	}
    
	private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
		let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
		return String(format: format, locale: Locale.current, arguments: args)
	}
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable all
