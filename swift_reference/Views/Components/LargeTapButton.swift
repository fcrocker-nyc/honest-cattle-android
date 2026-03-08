import SwiftUI

struct LargeTapButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    init(
        title: String,
        icon: String,
        color: Color = Theme.earthGreen,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(color)

                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 90)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(.plain)
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String
    let iconColor: Color

    init(
        title: String,
        value: String,
        subtitle: String? = nil,
        icon: String,
        iconColor: Color = Theme.earthGreen
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct PriceCard: View {
    let title: String
    let price: String
    let change: String
    let isPositive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(price)
                .font(.title3)
                .fontWeight(.bold)

            HStack(spacing: 4) {
                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption)
                Text(change)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(isPositive ? .green : .red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct LoadingCard: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 80)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct ErrorCard: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.title2)
                .foregroundColor(.orange)

            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button("Retry") {
                retryAction()
            }
            .font(.caption)
            .foregroundColor(Theme.earthGreen)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            LargeTapButton(title: "Add Animal", icon: "plus.circle.fill") {}
            LargeTapButton(title: "Calculator", icon: "function") {}
        }

        HStack(spacing: 12) {
            InfoCard(
                title: "Temperature",
                value: "42°F",
                subtitle: "Feels like 35°F",
                icon: "thermometer.medium"
            )

            PriceCard(
                title: "Feeder Cattle",
                price: "$245.50",
                change: "+1.25 (0.51%)",
                isPositive: true
            )
        }

        LoadingCard(title: "Loading weather...")

        ErrorCard(message: "Unable to load data") {}
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
