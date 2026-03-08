import SwiftUI

struct DosageCalculatorView: View {
    @State private var selectedDrug: CattleDrug?
    @State private var animalWeight: Double = 500
    @State private var showingDrugPicker = false

    private var dosage: Double {
        guard let drug = selectedDrug else { return 0 }
        return (animalWeight / 100) * drug.dosagePerCwt
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.standardPadding) {
                drugSelectionSection

                if selectedDrug != nil {
                    weightInputSection

                    resultSection

                    drugInfoSection
                }
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Dosage Calculator")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingDrugPicker) {
            DrugPickerView(selectedDrug: $selectedDrug)
        }
    }

    @ViewBuilder
    private var drugSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Drug")
                .font(.headline)

            Button {
                showingDrugPicker = true
            } label: {
                HStack {
                    if let drug = selectedDrug {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(drug.name)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(drug.dosageDescription)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Text("Tap to select a drug")
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding(Theme.standardPadding)
                .background(Color(.systemBackground))
                .cornerRadius(Theme.cardCornerRadius)
            }
            .buttonStyle(.plain)

            Text("Common Drugs")
                .font(.subheadline)
                .foregroundColor(.secondary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 8) {
                ForEach(CattleDrug.commonDrugs.prefix(6)) { drug in
                    Button {
                        selectedDrug = drug
                    } label: {
                        Text(drug.name)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedDrug?.id == drug.id ? Theme.earthGreen : Color(.systemGray5))
                            .foregroundColor(selectedDrug?.id == drug.id ? .white : .primary)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    @ViewBuilder
    private var weightInputSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Animal Weight")
                .font(.headline)

            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Text("\(Int(animalWeight))")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                    Text("lbs")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Spacer()
                }

                Slider(value: $animalWeight, in: 100...2000, step: 25)
                    .tint(Theme.earthGreen)

                HStack {
                    ForEach([300, 500, 700, 900, 1200], id: \.self) { weight in
                        Button {
                            animalWeight = Double(weight)
                        } label: {
                            Text("\(weight)")
                                .font(.caption)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Int(animalWeight) == weight ? Theme.earthGreen.opacity(0.2) : Color(.systemGray6))
                                .foregroundColor(Int(animalWeight) == weight ? Theme.earthGreen : .primary)
                                .cornerRadius(6)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var resultSection: some View {
        if let drug = selectedDrug {
            VStack(spacing: 12) {
                Text("Recommended Dosage")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(alignment: .top, spacing: 4) {
                    Text(String(format: "%.1f", dosage))
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.earthGreen)
                    Text(drug.unit)
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding(.top, 12)
                }

                Text("\(drug.name) via \(drug.route.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(Theme.largePadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }

    @ViewBuilder
    private var drugInfoSection: some View {
        if let drug = selectedDrug {
            VStack(alignment: .leading, spacing: 12) {
                Text("Drug Information")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    InfoRow(label: "Route", value: drug.route.rawValue)
                    InfoRow(label: "Withdrawal", value: "\(drug.withdrawalDays) days")

                    if !drug.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(drug.notes)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .cardStyle()

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Important")
                        .font(.headline)
                }

                Text("Always verify dosage with product label and consult your veterinarian. This calculator is for reference only.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(Theme.standardPadding)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(Theme.cardCornerRadius)
        }
    }
}

struct DrugPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDrug: CattleDrug?

    var body: some View {
        NavigationStack {
            List {
                ForEach(CattleDrug.commonDrugs) { drug in
                    Button {
                        selectedDrug = drug
                        dismiss()
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(drug.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Text(drug.dosageDescription)
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 8) {
                                    Text(drug.route.rawValue)
                                        .font(.caption)

                                    Text("•")

                                    Text("\(drug.withdrawalDays) day withdrawal")
                                        .font(.caption)
                                }
                                .foregroundColor(.secondary)
                            }

                            Spacer()

                            if selectedDrug?.id == drug.id {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Theme.earthGreen)
                            }
                        }
                    }
                    .largeTapTarget()
                }
            }
            .navigationTitle("Select Drug")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DosageCalculatorView()
    }
}
