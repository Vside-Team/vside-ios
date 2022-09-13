//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `yellow`.
    static let yellow = Rswift.ColorResource(bundle: R.hostingBundle, name: "yellow")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "yellow", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func yellow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.yellow, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "yellow", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func yellow(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.yellow.name)
    }
    #endif

    /// This `R.color.grayscale` struct is generated, and contains static references to 12 colors.
    struct grayscale {
      /// Color `_100`.
      static let _100 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_100")
      /// Color `_200`.
      static let _200 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_200")
      /// Color `_25`.
      static let _25 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_25")
      /// Color `_300`.
      static let _300 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_300")
      /// Color `_400`.
      static let _400 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_400")
      /// Color `_500`.
      static let _500 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_500")
      /// Color `_50`.
      static let _50 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_50")
      /// Color `_600`.
      static let _600 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_600")
      /// Color `_700`.
      static let _700 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_700")
      /// Color `_800`.
      static let _800 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_800")
      /// Color `_900`.
      static let _900 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_900")
      /// Color `_950`.
      static let _950 = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayscale/_950")

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _100(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._100, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_200", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _200(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._200, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_25", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _25(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._25, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_300", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _300(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._300, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_400", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _400(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._400, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_50", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _50(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._50, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_500", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _500(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._500, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_600", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _600(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._600, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_700", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _700(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._700, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_800", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _800(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._800, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_900", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _900(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._900, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_950", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _950(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.grayscale._950, compatibleWith: traitCollection)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _100(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._100.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_200", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _200(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._200.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_25", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _25(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._25.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_300", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _300(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._300.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_400", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _400(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._400.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_50", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _50(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._50.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_500", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _500(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._500.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_600", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _600(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._600.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_700", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _700(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._700.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_800", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _800(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._800.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_900", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _900(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._900.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_950", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _950(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.grayscale._950.name)
      }
      #endif

      fileprivate init() {}
    }

    /// This `R.color.main` struct is generated, and contains static references to 5 colors.
    struct main {
      /// Color `_100`.
      static let _100 = Rswift.ColorResource(bundle: R.hostingBundle, name: "main/_100")
      /// Color `_200`.
      static let _200 = Rswift.ColorResource(bundle: R.hostingBundle, name: "main/_200")
      /// Color `_300`.
      static let _300 = Rswift.ColorResource(bundle: R.hostingBundle, name: "main/_300")
      /// Color `_400`.
      static let _400 = Rswift.ColorResource(bundle: R.hostingBundle, name: "main/_400")
      /// Color `_500`.
      static let _500 = Rswift.ColorResource(bundle: R.hostingBundle, name: "main/_500")

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _100(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.main._100, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_200", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _200(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.main._200, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_300", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _300(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.main._300, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_400", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _400(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.main._400, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_500", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _500(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.main._500, compatibleWith: traitCollection)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _100(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.main._100.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_200", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _200(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.main._200.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_300", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _300(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.main._300.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_400", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _400(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.main._400.name)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_500", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _500(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.main._500.name)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    struct comAppleDeveloperApplesignin {
      static let `default` = infoPlistString(path: ["com.apple.developer.applesignin"], key: "Default") ?? "Default"

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 6 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `Montserrat-ExtraBold.otf`.
    static let montserratExtraBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Montserrat-ExtraBold", pathExtension: "otf")
    /// Resource file `Montserrat-SemiBold.otf`.
    static let montserratSemiBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Montserrat-SemiBold", pathExtension: "otf")
    /// Resource file `Montserrat-Spoqa-Bold.otf`.
    static let montserratSpoqaBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Montserrat-Spoqa-Bold", pathExtension: "otf")
    /// Resource file `Montserrat-Spoqa-Medium.otf`.
    static let montserratSpoqaMediumOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Montserrat-Spoqa-Medium", pathExtension: "otf")
    /// Resource file `Montserrat-Spoqa-Regular.otf`.
    static let montserratSpoqaRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Montserrat-Spoqa-Regular", pathExtension: "otf")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Montserrat-ExtraBold", withExtension: "otf")`
    static func montserratExtraBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratExtraBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Montserrat-SemiBold", withExtension: "otf")`
    static func montserratSemiBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratSemiBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Montserrat-Spoqa-Bold", withExtension: "otf")`
    static func montserratSpoqaBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratSpoqaBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Montserrat-Spoqa-Medium", withExtension: "otf")`
    static func montserratSpoqaMediumOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratSpoqaMediumOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Montserrat-Spoqa-Regular", withExtension: "otf")`
    static func montserratSpoqaRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratSpoqaRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 5 fonts.
  struct font: Rswift.Validatable {
    /// Font `Montserrat-ExtraBold`.
    static let montserratExtraBold = Rswift.FontResource(fontName: "Montserrat-ExtraBold")
    /// Font `Montserrat-SemiBold`.
    static let montserratSemiBold = Rswift.FontResource(fontName: "Montserrat-SemiBold")
    /// Font `Montserrat-Spoqa-Bold`.
    static let montserratSpoqaBold = Rswift.FontResource(fontName: "Montserrat-Spoqa-Bold")
    /// Font `Montserrat-Spoqa-Medium`.
    static let montserratSpoqaMedium = Rswift.FontResource(fontName: "Montserrat-Spoqa-Medium")
    /// Font `Montserrat-Spoqa-Regular`.
    static let montserratSpoqaRegular = Rswift.FontResource(fontName: "Montserrat-Spoqa-Regular")

    /// `UIFont(name: "Montserrat-ExtraBold", size: ...)`
    static func montserratExtraBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratExtraBold, size: size)
    }

    /// `UIFont(name: "Montserrat-SemiBold", size: ...)`
    static func montserratSemiBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratSemiBold, size: size)
    }

    /// `UIFont(name: "Montserrat-Spoqa-Bold", size: ...)`
    static func montserratSpoqaBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratSpoqaBold, size: size)
    }

    /// `UIFont(name: "Montserrat-Spoqa-Medium", size: ...)`
    static func montserratSpoqaMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratSpoqaMedium, size: size)
    }

    /// `UIFont(name: "Montserrat-Spoqa-Regular", size: ...)`
    static func montserratSpoqaRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratSpoqaRegular, size: size)
    }

    static func validate() throws {
      if R.font.montserratExtraBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-ExtraBold' could not be loaded, is 'Montserrat-ExtraBold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratSemiBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-SemiBold' could not be loaded, is 'Montserrat-SemiBold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratSpoqaBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Spoqa-Bold' could not be loaded, is 'Montserrat-Spoqa-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratSpoqaMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Spoqa-Medium' could not be loaded, is 'Montserrat-Spoqa-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratSpoqaRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Spoqa-Regular' could not be loaded, is 'Montserrat-Spoqa-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `apple`.
    static let apple = Rswift.ImageResource(bundle: R.hostingBundle, name: "apple")
    /// Image `kakao`.
    static let kakao = Rswift.ImageResource(bundle: R.hostingBundle, name: "kakao")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "apple", bundle: ..., traitCollection: ...)`
    static func apple(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.apple, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "kakao", bundle: ..., traitCollection: ...)`
    static func kakao(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.kakao, compatibleWith: traitCollection)
    }
    #endif

    /// This `R.image.tab` struct is generated, and contains static references to 0 images.
    struct tab {
      /// This `R.image.tab.home` struct is generated, and contains static references to 2 images.
      struct home {
        /// Image `normal`.
        static let normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/home/normal")
        /// Image `selected`.
        static let selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/home/selected")

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "normal", bundle: ..., traitCollection: ...)`
        static func normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.home.normal, compatibleWith: traitCollection)
        }
        #endif

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "selected", bundle: ..., traitCollection: ...)`
        static func selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.home.selected, compatibleWith: traitCollection)
        }
        #endif

        fileprivate init() {}
      }

      /// This `R.image.tab.my` struct is generated, and contains static references to 2 images.
      struct my {
        /// Image `normal`.
        static let normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/my/normal")
        /// Image `selected`.
        static let selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/my/selected")

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "normal", bundle: ..., traitCollection: ...)`
        static func normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.my.normal, compatibleWith: traitCollection)
        }
        #endif

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "selected", bundle: ..., traitCollection: ...)`
        static func selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.my.selected, compatibleWith: traitCollection)
        }
        #endif

        fileprivate init() {}
      }

      /// This `R.image.tab.search` struct is generated, and contains static references to 2 images.
      struct search {
        /// Image `normal`.
        static let normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/search/normal")
        /// Image `selected`.
        static let selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab/search/selected")

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "normal", bundle: ..., traitCollection: ...)`
        static func normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.search.normal, compatibleWith: traitCollection)
        }
        #endif

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "selected", bundle: ..., traitCollection: ...)`
        static func selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.tab.search.selected, compatibleWith: traitCollection)
        }
        #endif

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
