import SwiftUI
import SwiftData

struct PriceAlertView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let alert: PriceAlert?

    @State private var alertType: PriceAlertType = .feederCattle
    @State private var weightClass: WeightClass = .medium
    @State private var targetPrice: Double = 200.0
    @State private var isAboveTarget: Bool = true
    @State private var isEnabled: Bool = true

    private var isEditing: Bool {
        alert != nil
    }

    var body: some View {
        Form {
            Section {
                Picker("Alert Type", selection: $alertType) {
                    ForEach(PriceAlertType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .largeTapTarget()

                Picker("Weight Class", selection: $weightClass) {
                    ForEach(WeightClass.allCases, id: \.self) { weight in
                        Text(weight.label).tag(weight)
                    }
                }
                .largeTapTarget()
            }

            Section("Price Target") {
                HStack {
                    Text("$")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    TextField("Price", value: $targetPrice, format: .number.precision(.fractionLength(2)))
                        .font(.title2)
                        .fontWeight(.bold)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: Theme.minTapTarget)
                }

                Picker("Notify When", selection: $isAboveTarget) {
                    Text("Price goes above").tag(true)
                    Text("Price goes below").tag(false)
                }
                .pickerStyle(.segmented)
                .largeTapTarget()
            }

            Section {
                HStack {
                    Text("Alert Summary")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(alertSummary)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }

            Section {
                Toggle("Enable Alert", isOn: $isEnabled)
                    .largeTapTarget()
                    .tint(Theme.earthGreen)
            }

            if isEditing {
                Section {
                    Button(role: .destructive) {
                        deleteAlert()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Alert")
                            Spacer()
                        }
                    }
                    .frame(minHeight: Theme.minTapTarget)
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Alert" : "New Price Alert")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveAlert()
                }
                .fontWeight(.semibold)
            }
        }
        .onAppear {
            if let existingAlert = alert {
                alertType = existingAlert.alertType
                weightClass = existingAlert.weightClass
                targetPrice = existingAlert.targetPrice
                isAboveTarget = existingAlert.isAboveTarget
                isEnabled = existingAlert.isEnabled
            }
        }
    }

    private var alertSummary: String {
        let direction = isAboveTarget ? "above" : "below"
        return "Notify when \(weightClass.label) \(alertType.rawValue) goes \(direction) $\(String(format: "%.2f", targetPrice))"
    }

    private func saveAlert() {
        if let existingAlert = alert {
            existingAlert.alertType = alertType
            existingAlert.weightClass = weightClass
            existingAlert.targetPrice = targetPrice
            existingAlert.isAboveTarget = isAboveTarget
            existingAlert.isEnabled = isEnabled
        } else {
            let newAlert = PriceAlert(
                alertType: alertType,
                weightClass: weightClass,
                targetPrice: targetPrice,
                isAboveTarget: isAboveTarget,
                isEnabled: isEnabled
            )
            modelContext.insert(newAlert)
        }

        dismiss()
    }

    private func deleteAlert() {
        if let existingAlert = alert {
            modelContext.delete(existingAlert)
        }
        dismiss()
    }
}

#Preview {
    NavigationStack {
        PriceAlertView(alert: nil)
    }
    .modelContainer(for: [PriceAlert.self], inMemory: true)
}
