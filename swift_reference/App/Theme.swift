import SwiftUI

enum Theme {
    static let earthGreen = Color("EarthGreen")
    static let warmBrown = Color("WarmBrown")
    static let creamBackground = Color("CreamBackground")
    static let accentColor = Color("AccentColor")
    static let backgroundColor = Color("BackgroundColor")

    static let minTapTarget: CGFloat = 48

    static let cardCornerRadius: CGFloat = 12
    static let buttonCornerRadius: CGFloat = 10

    static let standardPadding: CGFloat = 16
    static let compactPadding: CGFloat = 8
    static let largePadding: CGFloat = 24

    static let titleFont: Font = .title2.bold()
    static let headlineFont: Font = .headline
    static let bodyFont: Font = .body
    static let captionFont: Font = .caption
    static let largeNumberFont: Font = .system(size: 36, weight: .bold, design: .rounded)
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct LargeTapTargetStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minHeight: Theme.minTapTarget)
            .contentShape(Rectangle())
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }

    func largeTapTarget() -> some View {
        modifier(LargeTapTargetStyle())
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(minHeight: Theme.minTapTarget)
            .background(Theme.earthGreen)
            .cornerRadius(Theme.buttonCornerRadius)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(Theme.earthGreen)
            .frame(maxWidth: .infinity)
            .frame(minHeight: Theme.minTapTarget)
            .background(Theme.earthGreen.opacity(0.1))
            .cornerRadius(Theme.buttonCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.buttonCornerRadius)
                    .stroke(Theme.earthGreen, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct QuickActionButtonStyle: ButtonStyle {
    let icon: String
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)

            configuration.label
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 80)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { SecondaryButtonStyle() }
}
