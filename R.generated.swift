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
    /// Color `main`.
    static let main = Rswift.ColorResource(bundle: R.hostingBundle, name: "main")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "main", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func main(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.main, compatibleWith: traitCollection)
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
    /// `UIColor(named: "main", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func main(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.main.name)
    }
    #endif

    /// This `R.color.lemon` struct is generated, and contains static references to 1 colors.
    struct lemon {
      /// Color `_100`.
      static let _100 = Rswift.ColorResource(bundle: R.hostingBundle, name: "lemon/_100")

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _100(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.lemon._100, compatibleWith: traitCollection)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _100(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.lemon._100.name)
      }
      #endif

      fileprivate init() {}
    }

    /// This `R.color.red` struct is generated, and contains static references to 1 colors.
    struct red {
      /// Color `_100`.
      static let _100 = Rswift.ColorResource(bundle: R.hostingBundle, name: "red/_100")

      #if os(iOS) || os(tvOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(tvOS 11.0, *)
      @available(iOS 11.0, *)
      static func _100(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
        return UIKit.UIColor(resource: R.color.red._100, compatibleWith: traitCollection)
      }
      #endif

      #if os(watchOS)
      /// `UIColor(named: "_100", bundle: ..., traitCollection: ...)`
      @available(watchOSApplicationExtension 4.0, *)
      static func _100(_: Void = ()) -> UIKit.UIColor? {
        return UIKit.UIColor(named: R.color.red._100.name)
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
    /// Resource file `SpoqaHanSansNeo-Bold.otf`.
    static let spoqaHanSansNeoBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SpoqaHanSansNeo-Bold", pathExtension: "otf")
    /// Resource file `SpoqaHanSansNeo-Light.otf`.
    static let spoqaHanSansNeoLightOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SpoqaHanSansNeo-Light", pathExtension: "otf")
    /// Resource file `SpoqaHanSansNeo-Medium.otf`.
    static let spoqaHanSansNeoMediumOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SpoqaHanSansNeo-Medium", pathExtension: "otf")
    /// Resource file `SpoqaHanSansNeo-Regular.otf`.
    static let spoqaHanSansNeoRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SpoqaHanSansNeo-Regular", pathExtension: "otf")
    /// Resource file `SpoqaHanSansNeo-Thin.otf`.
    static let spoqaHanSansNeoThinOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SpoqaHanSansNeo-Thin", pathExtension: "otf")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SpoqaHanSansNeo-Bold", withExtension: "otf")`
    static func spoqaHanSansNeoBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.spoqaHanSansNeoBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SpoqaHanSansNeo-Light", withExtension: "otf")`
    static func spoqaHanSansNeoLightOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.spoqaHanSansNeoLightOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SpoqaHanSansNeo-Medium", withExtension: "otf")`
    static func spoqaHanSansNeoMediumOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.spoqaHanSansNeoMediumOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SpoqaHanSansNeo-Regular", withExtension: "otf")`
    static func spoqaHanSansNeoRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.spoqaHanSansNeoRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SpoqaHanSansNeo-Thin", withExtension: "otf")`
    static func spoqaHanSansNeoThinOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.spoqaHanSansNeoThinOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 5 fonts.
  struct font: Rswift.Validatable {
    /// Font `SpoqaHanSansNeo-Bold`.
    static let spoqaHanSansNeoBold = Rswift.FontResource(fontName: "SpoqaHanSansNeo-Bold")
    /// Font `SpoqaHanSansNeo-Light`.
    static let spoqaHanSansNeoLight = Rswift.FontResource(fontName: "SpoqaHanSansNeo-Light")
    /// Font `SpoqaHanSansNeo-Medium`.
    static let spoqaHanSansNeoMedium = Rswift.FontResource(fontName: "SpoqaHanSansNeo-Medium")
    /// Font `SpoqaHanSansNeo-Regular`.
    static let spoqaHanSansNeoRegular = Rswift.FontResource(fontName: "SpoqaHanSansNeo-Regular")
    /// Font `SpoqaHanSansNeo-Thin`.
    static let spoqaHanSansNeoThin = Rswift.FontResource(fontName: "SpoqaHanSansNeo-Thin")

    /// `UIFont(name: "SpoqaHanSansNeo-Bold", size: ...)`
    static func spoqaHanSansNeoBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: spoqaHanSansNeoBold, size: size)
    }

    /// `UIFont(name: "SpoqaHanSansNeo-Light", size: ...)`
    static func spoqaHanSansNeoLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: spoqaHanSansNeoLight, size: size)
    }

    /// `UIFont(name: "SpoqaHanSansNeo-Medium", size: ...)`
    static func spoqaHanSansNeoMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: spoqaHanSansNeoMedium, size: size)
    }

    /// `UIFont(name: "SpoqaHanSansNeo-Regular", size: ...)`
    static func spoqaHanSansNeoRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: spoqaHanSansNeoRegular, size: size)
    }

    /// `UIFont(name: "SpoqaHanSansNeo-Thin", size: ...)`
    static func spoqaHanSansNeoThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: spoqaHanSansNeoThin, size: size)
    }

    static func validate() throws {
      if R.font.spoqaHanSansNeoBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SpoqaHanSansNeo-Bold' could not be loaded, is 'SpoqaHanSansNeo-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.spoqaHanSansNeoLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SpoqaHanSansNeo-Light' could not be loaded, is 'SpoqaHanSansNeo-Light.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.spoqaHanSansNeoMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SpoqaHanSansNeo-Medium' could not be loaded, is 'SpoqaHanSansNeo-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.spoqaHanSansNeoRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SpoqaHanSansNeo-Regular' could not be loaded, is 'SpoqaHanSansNeo-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.spoqaHanSansNeoThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SpoqaHanSansNeo-Thin' could not be loaded, is 'SpoqaHanSansNeo-Thin.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `ic_apple 1`.
    static let ic_apple1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_apple 1")
    /// Image `kakao`.
    static let kakao = Rswift.ImageResource(bundle: R.hostingBundle, name: "kakao")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_apple 1", bundle: ..., traitCollection: ...)`
    static func ic_apple1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_apple1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "kakao", bundle: ..., traitCollection: ...)`
    static func kakao(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.kakao, compatibleWith: traitCollection)
    }
    #endif

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
      typealias InitialController = ViewController

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
