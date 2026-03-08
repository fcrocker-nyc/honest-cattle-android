import SwiftUI

struct BreakevenCalculatorView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var purchaseWeight: Double = 550
    @State private var purchasePrice: Double = 250
    @State private var costOfGain: Double = 0.90
    @State private var targetWeight: Double = 750
    @State private var additionalCosts: Double = 50
    @State private var deathLoss: Double = 1.5

    private var weightGain: Double {
        max(0, targetWeight - purchaseWeight)
    }

    private var purchaseCost: Double {
        (purchaseWeight / 100) * purchasePrice
    }

    private var feedCost: Double {
        weightGain * costOfGain
    }

    private var totalCost: Double {
        purchaseCost + feedCost + additionalCosts
    }

    private var adjustedCost: Double {
        totalCost / (1 - (deathLoss / 100))
    }

    private var breakevenPrice: Double {
        guard targetWeight > 0 else { return 0 }
        return (adjustedCost / targetWeight) * 100
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.standardPadding) {
                resultSection

                inputsSection

                breakdownSection
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Breakeven Calculator")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var resultSection: some View {
        VStack(spacing: 8) {
            Text("Breakeven Price")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(alignment: .top, spacing: 4) {
                Text("$")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)

                Text(String(format: "%.2f", breakevenPrice))
                    .font(.system(size: 56, weight: .bold, design: .rounded))
            }

            Text("per cwt at \(Int(targetWeight)) lbs")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.largePadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private var inputsSection: some View {
        VStack(alignment: .leading, spacing: Theme.standardPadding) {
            Text("Inputs")
                .font(.headline)

            VStack(spacing: 16) {
                SliderInputRow(
                    label: "Purchase Weight",
                    value: $purchaseWeight,
                    range: 300...900,
                    step: 25,
                    unit: "lbs",
                    format: "%.0f"
                )

                SliderInputRow(
                    label: "Purchase Price",
                    value: $purchasePrice,
                    range: 100...400,
                    step: 5,
                    unit: "$/cwt",
                    format: "%.0f"
                )

                SliderInputRow(
                    label: "Target Weight",
                    value: $targetWeight,
                    range: 400...1200,
                    step: 25,
                    unit: "lbs",
                    format: "%.0f"
                )

                SliderInputRow(
                    label: "Cost of Gain",
                    value: $costOfGain,
                    range: 0.50...2.00,
                    step: 0.05,
                    unit: "$/lb",
                    format: "%.2f"
                )

                SliderInputRow(
                    label: "Additional Costs",
                    value: $additionalCosts,
                    range: 0...200,
                    step: 10,
                    unit: "$",
                    format: "%.0f"
                )

                SliderInputRow(
                    label: "Death Loss",
                    value: $deathLoss,
                    range: 0...5,
                    step: 0.5,
                    unit: "%",
                    format: "%.1f"
                )
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var breakdownSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cost Breakdown")
                .font(.headline)

            VStack(spacing: 8) {
                CostRow(label: "Purchase Cost", value: purchaseCost, note: "\(Int(purchaseWeight)) lbs @ $\(String(format: "%.0f", purchasePrice))/cwt")
                CostRow(label: "Feed Cost", value: feedCost, note: "\(Int(weightGain)) lbs gain @ $\(String(format: "%.2f", costOfGain))/lb")
                CostRow(label: "Additional Costs", value: additionalCosts, note: "Vet, hauling, yardage, etc.")

                Divider()

                CostRow(label: "Subtotal", value: totalCost, isTotal: true)
                CostRow(label: "Adjusted for \(String(format: "%.1f", deathLoss))% death loss", value: adjustedCost, isTotal: true)
            }
        }
        .cardStyle()
    }
}

struct SliderInputRow: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let unit: String
    let format: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.subheadline)
                Spacer()
                Text("\(String(format: format, value)) \(unit)")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }

            Slider(value: $value, in: range, step: step)
                .tint(Theme.earthGreen)
        }
    }
}

struct CostRow: View {
    let label: String
    let value: Double
    var note: String? = nil
    var isTotal: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(label)
                    .font(isTotal ? .subheadline.bold() : .subheadline)

                Spacer()

                Text(String(format: "$%.2f", value))
                    .font(isTotal ? .subheadline.bold() : .subheadline)
                    .foregroundColor(isTotal ? Theme.earthGreen : .primary)
            }

            if let note = note {
                Text(note)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        BreakevenCalculatorView()
    }
}
