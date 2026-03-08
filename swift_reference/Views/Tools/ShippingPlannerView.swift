import SwiftUI

struct ShippingPlannerView: View {
    @State private var targetShipDate: Date = Calendar.current.date(byAdding: .month, value: 3, to: Date()) ?? Date()
    @State private var currentWeight: Double = 550
    @State private var targetWeight: Double = 750
    @State private var expectedADG: Double = 2.5

    private var daysUntilShip: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: targetShipDate).day ?? 0
    }

    private var weightToGain: Double {
        max(0, targetWeight - currentWeight)
    }

    private var requiredADG: Double {
        guard daysUntilShip > 0 else { return 0 }
        return weightToGain / Double(daysUntilShip)
    }

    private var daysNeeded: Int {
        guard expectedADG > 0 else { return 0 }
        return Int(ceil(weightToGain / expectedADG))
    }

    private var recommendedShipDate: Date {
        Calendar.current.date(byAdding: .day, value: daysNeeded, to: Date()) ?? Date()
    }

    private var isOnTrack: Bool {
        requiredADG <= expectedADG
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.standardPadding) {
                summarySection

                targetSection

                weightsSection

                adgSection

                timelineSection
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Shipping Planner")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var summarySection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                VStack(spacing: 4) {
                    Text("\(daysUntilShip)")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(isOnTrack ? Theme.earthGreen : .orange)
                    Text("days to ship")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 4) {
                    Text("\(Int(weightToGain))")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                    Text("lbs to gain")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if !isOnTrack {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Need \(String(format: "%.2f", requiredADG)) lb/day ADG to meet target")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
            } else {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("On track to meet target weight")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var targetSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Target Ship Date")
                .font(.headline)

            DatePicker(
                "Ship Date",
                selection: $targetShipDate,
                in: Date()...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .tint(Theme.earthGreen)
        }
        .cardStyle()
    }

    @ViewBuilder
    private var weightsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Weights")
                .font(.headline)

            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Current Weight")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(currentWeight)) lbs")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                    Slider(value: $currentWeight, in: 300...1000, step: 25)
                        .tint(Theme.earthGreen)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Target Weight")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(targetWeight)) lbs")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                    Slider(value: $targetWeight, in: 400...1200, step: 25)
                        .tint(Theme.warmBrown)
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var adgSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Average Daily Gain")
                .font(.headline)

            VStack(spacing: 8) {
                HStack {
                    Text("Expected ADG")
                        .font(.subheadline)
                    Spacer()
                    Text("\(String(format: "%.2f", expectedADG)) lb/day")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }

                Slider(value: $expectedADG, in: 1.0...4.0, step: 0.1)
                    .tint(Theme.earthGreen)

                HStack {
                    Text("Required ADG")
                        .font(.subheadline)
                    Spacer()
                    Text("\(String(format: "%.2f", requiredADG)) lb/day")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(isOnTrack ? .green : .orange)
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Timeline")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                TimelineRow(
                    date: Date(),
                    label: "Today",
                    detail: "\(Int(currentWeight)) lbs",
                    isHighlighted: true
                )

                TimelineRow(
                    date: recommendedShipDate,
                    label: "Recommended Ship",
                    detail: "Based on \(String(format: "%.1f", expectedADG)) ADG",
                    isHighlighted: false
                )

                TimelineRow(
                    date: targetShipDate,
                    label: "Target Ship Date",
                    detail: "\(Int(targetWeight)) lbs target",
                    isHighlighted: !isOnTrack
                )
            }
        }
        .cardStyle()
    }
}

struct TimelineRow: View {
    let date: Date
    let label: String
    let detail: String
    let isHighlighted: Bool

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(isHighlighted ? Theme.earthGreen : Color(.systemGray4))
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(detail)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(dateFormatter.string(from: date))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        ShippingPlannerView()
    }
}
