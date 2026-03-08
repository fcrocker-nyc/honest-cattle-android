import SwiftUI

struct WindChillCalculatorView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var temperature: Double = 32
    @State private var windSpeed: Double = 15

    private var windChill: Double {
        guard temperature <= 50 && windSpeed > 3 else {
            return temperature
        }

        return 35.74 + (0.6215 * temperature) - (35.75 * pow(windSpeed, 0.16)) + (0.4275 * temperature * pow(windSpeed, 0.16))
    }

    private var frostbiteRisk: FrostbiteRisk {
        let chill = windChill
        if chill > 0 {
            return .low
        } else if chill > -18 {
            return .moderate
        } else if chill > -32 {
            return .high
        } else {
            return .extreme
        }
    }

    private var calvingRisk: CalvingRisk {
        let chill = windChill
        if chill > 32 {
            return .low
        } else if chill > 15 {
            return .moderate
        } else if chill > 0 {
            return .high
        } else {
            return .critical
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.largePadding) {
                resultSection

                inputSection

                riskSection

                calvingGuidelinesSection
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Wind Chill")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }

    @ViewBuilder
    private var resultSection: some View {
        VStack(spacing: 8) {
            Text("Feels Like")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(alignment: .top, spacing: 4) {
                Text("\(Int(windChill))")
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(windChillColor)
                Text("°F")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.top, 12)
            }

            if temperature <= 50 && windSpeed > 3 {
                Text("Wind chill effect: \(Int(temperature - windChill))° colder")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text("No wind chill effect")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.largePadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private var inputSection: some View {
        VStack(spacing: Theme.standardPadding) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "thermometer.medium")
                        .foregroundColor(Theme.earthGreen)
                    Text("Temperature")
                        .font(.headline)
                    Spacer()
                    Text("\(Int(temperature))°F")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                Slider(value: $temperature, in: -40...60, step: 1)
                    .tint(Theme.earthGreen)
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "wind")
                        .foregroundColor(Theme.earthGreen)
                    Text("Wind Speed")
                        .font(.headline)
                    Spacer()
                    Text("\(Int(windSpeed)) mph")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                Slider(value: $windSpeed, in: 0...60, step: 1)
                    .tint(Theme.earthGreen)
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
        }
    }

    @ViewBuilder
    private var riskSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Risk Assessment")
                .font(.headline)

            HStack(spacing: 12) {
                RiskCard(
                    title: "Frostbite Risk",
                    level: frostbiteRisk.rawValue,
                    color: frostbiteRisk.color,
                    icon: "hand.raised.fill"
                )

                RiskCard(
                    title: "Calving Risk",
                    level: calvingRisk.rawValue,
                    color: calvingRisk.color,
                    icon: "pawprint.fill"
                )
            }
        }
    }

    @ViewBuilder
    private var calvingGuidelinesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Calving Guidelines")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                GuidelineRow(
                    condition: "Above 32°F",
                    recommendation: "Normal monitoring",
                    color: .green
                )

                GuidelineRow(
                    condition: "15-32°F",
                    recommendation: "Increase checks, prepare shelter",
                    color: .yellow
                )

                GuidelineRow(
                    condition: "0-15°F",
                    recommendation: "Move to shelter, dry calves immediately",
                    color: .orange
                )

                GuidelineRow(
                    condition: "Below 0°F",
                    recommendation: "Warm calves, risk of hypothermia",
                    color: .red
                )
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
        }
    }

    private var windChillColor: Color {
        if windChill > 32 {
            return .primary
        } else if windChill > 15 {
            return .yellow
        } else if windChill > 0 {
            return .orange
        } else {
            return .red
        }
    }
}

struct RiskCard: View {
    let title: String
    let level: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(level)
                .font(.headline)
                .foregroundColor(color)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.standardPadding)
        .background(color.opacity(0.1))
        .cornerRadius(Theme.cardCornerRadius)
    }
}

struct GuidelineRow: View {
    let condition: String
    let recommendation: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .padding(.top, 6)

            VStack(alignment: .leading, spacing: 2) {
                Text(condition)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(recommendation)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

enum FrostbiteRisk: String {
    case low = "Low"
    case moderate = "Moderate"
    case high = "High"
    case extreme = "Extreme"

    var color: Color {
        switch self {
        case .low: return .green
        case .moderate: return .yellow
        case .high: return .orange
        case .extreme: return .red
        }
    }
}

enum CalvingRisk: String {
    case low = "Low"
    case moderate = "Moderate"
    case high = "High"
    case critical = "Critical"

    var color: Color {
        switch self {
        case .low: return .green
        case .moderate: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
}

#Preview {
    NavigationStack {
        WindChillCalculatorView()
    }
}
