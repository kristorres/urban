import SwiftUI

/// A text field style that conforms to the current app theme.
///
/// You can also use `.urban` to construct this style.
public struct UrbanTextFieldStyle: TextFieldStyle {
    
    /// Creates a text field style that conforms to the current app theme.
    ///
    /// - Parameter isOutlined: Indicates whether the text field has a border.
    ///                         The default is `false`.
    public init(outlined isOutlined: Bool = false) {
        self.isOutlined = isOutlined
    }
    
    /// Indicates whether the text field has a border.
    private let isOutlined: Bool
    
    /// The Urban theme.
    @Environment(\.urbanTheme) private var theme
    
    /// The color scheme of the text field.
    @Environment(\.colorScheme) private var colorScheme
    
    /// Indicates whether the text field allows user interaction.
    @Environment(\.isEnabled) private var textFieldIsEnabled
    
    public func _body(configuration: TextField<_Label>) -> some View {
        return configuration
            .textFieldStyle(.plain)
            .foregroundColor(foregroundColor)
            .padding(.vertical, Constants.verticalPadding)
            .padding(.horizontal, Constants.horizontalPadding)
            .background(backgroundColor)
            .clipShape(shape)
            .overlay(borderLayer)
            .animation(.default, value: textFieldIsEnabled)
    }
    
    /// The background color of the text field.
    private var backgroundColor: Color {
        if isOutlined {
            return .clear
        }
        
        let baseColor = (colorScheme == .dark)
            ? Color.white
            : Color.black
        
        return baseColor.opacity(Constants.defaultOpacity)
    }
    
    /// The border “layer” of the text field.
    private var borderLayer: some View {
        let borderColor = textFieldIsEnabled
            ? theme.palette.primary.main
            : theme.palette.disabled.content
        
        return Group {
            if isOutlined {
                shape.stroke(borderColor, lineWidth: Constants.borderWidth)
            }
        }
    }
    
    /// The foreground color of the text field.
    private var foregroundColor: Color {
        if !textFieldIsEnabled {
            return theme.palette.disabled.content
        }
        
        return .primary
    }
    
    /// The text field shape.
    private var shape: some Shape {
        RoundedRectangle(cornerRadius: theme.cornerRadius)
    }
    
    /// An internal enum that contains drawing constants.
    private enum Constants {
        static let borderWidth: CGFloat = 2
        static let defaultOpacity: Double = 0.125
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 12
    }
}

public extension TextFieldStyle where Self == UrbanTextFieldStyle {
    
    /// Returns a text field style that conforms to the current app theme.
    ///
    /// To apply this style to a text field, or to a view that contains text
    /// fields, use the `textFieldStyle(_:)` modifier.
    ///
    /// - Parameter isOutlined: Indicates whether the text field has a border.
    ///                         The default is `false`.
    ///
    /// - Returns: The text field style.
    static func urban(outlined isOutlined: Bool = false) -> Self {
        return .init(outlined: isOutlined)
    }
}

#if os(macOS)
import AppKit

extension NSTextField {
    override open var focusRingType: NSFocusRingType {
        get { return .none }
        set {}
    }
}
#endif

struct UrbanTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(spacing: 16) {
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban())
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban(outlined: true))
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban())
                    .disabled(true)
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban(outlined: true))
                    .disabled(true)
            }
                .padding()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("UrbanTextField (Light Mode)")
            
            VStack(spacing: 16) {
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban())
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban(outlined: true))
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban())
                    .disabled(true)
                TextField("Type Input Here", text: .constant("Text Input"))
                    .textFieldStyle(.urban(outlined: true))
                    .disabled(true)
            }
                .padding()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("UrbanTextField (Dark Mode)")
        }
    }
}
