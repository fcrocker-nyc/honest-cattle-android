import SwiftUI

struct WeightEstimatorView: View {
    @State private var heartGirth: Double = 70
    @State private var bodyLength: Double = 50
    @State private var selectedUnit: MeasurementUnit = .inches

    enum MeasurementUnit: String, CaseIterable {
        case inches = "Inches"
        case centimeters = "Centimeters"
    }

    private var estimatedWeight: Double {
        let girth: Double
        let length: Double

        if selectedUnit == .centimeters {
            girth = heartGirth / 2.54
            length = bodyLength / 2.54
        } else {
            girth = heartGirth
            length = bodyLength
        }

        let weight = (girth * girth * length) / 300
        return weight
    }

    private var girthRange: ClosedRange<Double> {
        selectedUnit == .inches ? 30...100 : 75...250
    }

    private var lengthRange: ClosedRange<Double> {
        selectedUnit == .inches ? 20...80 : 50...200
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.standardPadding) {
                resultSection

                instructionsSection

                inputSection
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Weight Estimator")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var resultSection: some View {
        VStack(spacing: 8) {
            Text("Estimated Weight")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(alignment: .top, spacing: 4) {
                Text("\(Int(estimatedWeight))")
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                Text("lbs")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.top, 12)
            }

            Text("Based on tape measurements")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.largePadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How to Measure")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                MeasurementInstructionRow(
                    number: 1,
                    title: "Heart Girth",
                    description: "Measure around the body just behind the front legs and shoulder"
                )

                MeasurementInstructionRow(
                    number: 2,
                    title: "Body Length",
                    description: "Measure from point of shoulder to point of hip (pin bone)"
                )
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var inputSection: some View {
        VStack(alignment: .leading, spacing: Theme.standardPadding) {
            HStack {
                Text("Measurements")
                    .font(.headline)

                Spacer()

                Picker("Unit", selection: $selectedUnit) {
                    ForEach(MeasurementUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 180)
            }

            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "circle.dashed")
                            .foregroundColor(Theme.earthGreen)
                        Text("Heart Girth")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(heartGirth)) \(selectedUnit == .inches ? "in" : "cm")")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                    Slider(value: $heartGirth, in: girthRange, step: 1)
                        .tint(Theme.earthGreen)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "arrow.left.and.right")
                            .foregroundColor(Theme.warmBrown)
                        Text("Body Length")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(bodyLength)) \(selectedUnit == .inches ? "in" : "cm")")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                    Slider(value: $bodyLength, in: lengthRange, step: 1)
                        .tint(Theme.warmBrown)
                }
            }
        }
        .cardStyle()

        VStack(alignment: .leading, spacing: 8) {
            Text("Formula")
                .font(.headline)

            Text("Weight = (Heart Girth² × Body Length) ÷ 300")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("This formula provides an estimate. Actual weight may vary by ±5-10% depending on body condition and breed.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .cardStyle()
    }
}

struct MeasurementInstructionRow: View {
    let number: Int
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(Theme.earthGreen)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WeightEstimatorView()
    }
}
