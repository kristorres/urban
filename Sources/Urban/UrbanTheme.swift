import SwiftUI

/// A main/content color pair.
public typealias MCColorPair = (main: Color, content: Color)

/// An Urban theme.
///
/// The purpose of the theme is to apply a consistent tone to the app. You can
/// customize design aspects such as the colors, typography, and more.
///
/// The conventional way to create a new theme from an already existing theme is
/// to extend the `UrbanTheme` type and customize any of the properties.
///
/// ```
/// extension UrbanTheme {
///     static let sana: UrbanTheme = {
///         var theme = UrbanTheme()
///         theme.palette.primary.main = .pink
///         theme.palette.secondary.main = .purple
///         // …
///
///         return theme
///     }()
/// }
/// ```
///
/// You can then use an environment value to dynamically control the theme of a
/// SwiftUI view (and its children).
///
/// ```
/// // Setting the theme
/// MyView().urbanTheme(.sana)
///
/// // Getting the theme
/// @Environment(\.urbanTheme) private var theme
/// ```
public struct UrbanTheme {
    
    /// Creates a default Urban theme.
    public init() {}
    
    /// The color palette.
    public var palette = Palette()
    
    /// The font set.
    public var typography = FontSet()
    
    /// The standard corner radius of the components.
    public var cornerRadius: CGFloat = 4
    
    /// A set of fonts that present the app’s content as clearly and efficiently
    /// as possible.
    public struct FontSet {
        
        /// Creates a default font set.
        public init() {
            if #available(iOS 13, macOS 11, *) {
                subheader = .title2
                return
            }
            
            subheader = .headline
        }
        
        /// The title font.
        public var title = Font.largeTitle
        
        /// The header font.
        public var header = Font.title
        
        /// The subheader font.
        public var subheader: Font
        
        /// The font for body text.
        public var body = Font.body
        
        /// The font for button titles.
        public var button = Font.body.bold()
    }
    
    /// A color palette that reflects the app’s brand or style.
    public struct Palette {
        
        /// Creates a default color palette.
        public init() {}
        
        /// The main/content color pair used most frequently across the app.
        public var primary: MCColorPair = (
            .torresBlue,
            Color("default-primary-content", bundle: .module)
        )
        
        /// The main/content color pair used to accent and distinguish the app.
        public var secondary: MCColorPair = (.torresGold, .black)
        
        /// The main/content color pair used to indicate warnings, errors, or
        /// other destructive actions.
        public var danger: MCColorPair = (
            Color("default-danger-main", bundle: .module),
            Color("default-danger-content", bundle: .module)
        )
        
        /// The main/content color pair used on surface components, such as
        /// cards, sheets, and menus.
        public var surface: MCColorPair = (
            Color("default-surface-main", bundle: .module),
            Color("default-surface-content", bundle: .module)
        )
        
        /// The main/content color pair used on screen backgrounds.
        public var background: MCColorPair = (
            Color("default-background-main", bundle: .module),
            Color("default-background-content", bundle: .module)
        )
        
        /// The main/content color pair used on disabled controls.
        public var disabled: MCColorPair = (
            Color("default-disabled-main", bundle: .module),
            Color("default-disabled-content", bundle: .module)
        )
    }
}

public extension EnvironmentValues {
    
    /// The Urban theme.
    var urbanTheme: UrbanTheme {
        get {
            self[UrbanThemeKey.self]
        }
        set {
            self[UrbanThemeKey.self] = newValue
        }
    }
    
    private enum UrbanThemeKey: EnvironmentKey {
        static let defaultValue = UrbanTheme()
    }
}

public extension View {
    
    /// Sets the Urban theme for the view.
    ///
    /// - Parameter theme: The Urban theme.
    ///
    /// - Returns: The modified view.
    func urbanTheme(_ theme: UrbanTheme) -> some View {
        return environment(\.urbanTheme, theme)
    }
}
