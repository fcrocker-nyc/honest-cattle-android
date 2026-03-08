import SwiftUI
import SwiftData

struct QuickEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var entryMode: QuickEntryMode = .animal
    @State private var entriesAdded: Int = 0

    @State private var tagNumber: String = ""
    @State private var sex: AnimalSex = .steer
    @State private var breed: String = "Angus"

    @Query(sort: \Animal.tagNumber) private var animals: [Animal]
    @State private var selectedAnimalTag: String = ""
    @State private var treatment: String = ""
    @State private var selectedDrug: CattleDrug?

    enum QuickEntryMode: String, CaseIterable {
        case animal = "Animals"
        case treatment = "Treatments"
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("Mode", selection: $entryMode) {
                ForEach(QuickEntryMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            switch entryMode {
            case .animal:
                quickAnimalEntry
            case .treatment:
                quickTreatmentEntry
            }

            Spacer()

            if entriesAdded > 0 {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("\(entriesAdded) entries added")
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.1))
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Quick Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }

    @ViewBuilder
    private var quickAnimalEntry: some View {
        VStack(spacing: Theme.standardPadding) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Add Animal")
                    .font(.headline)

                HStack {
                    TextField("Tag Number", text: $tagNumber)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.characters)
                        .frame(minHeight: Theme.minTapTarget)

                    Button {
                        addAnimal()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(Theme.earthGreen)
                    }
                    .disabled(tagNumber.isEmpty)
                }

                HStack(spacing: 12) {
                    ForEach([AnimalSex.steer, .heifer, .bull, .cow], id: \.self) { sexOption in
                        Button {
                            sex = sexOption
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: sexOption.icon)
                                    .font(.title2)
                                Text(sexOption.rawValue)
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(sex == sexOption ? Theme.earthGreen : Color(.systemGray5))
                            .foregroundColor(sex == sexOption ? .white : .primary)
                            .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(["Angus", "Hereford", "Charolais", "Red Angus", "Black Baldy"], id: \.self) { breedOption in
                            Button {
                                breed = breedOption
                            } label: {
                                Text(breedOption)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(breed == breedOption ? Theme.warmBrown : Color(.systemGray5))
                                    .foregroundColor(breed == breedOption ? .white : .primary)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
        }
        .padding(Theme.standardPadding)
    }

    @ViewBuilder
    private var quickTreatmentEntry: some View {
        VStack(spacing: Theme.standardPadding) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Add Treatment")
                    .font(.headline)

                Picker("Animal", selection: $selectedAnimalTag) {
                    Text("Select Animal").tag("")
                    ForEach(animals) { animal in
                        Text(animal.tagNumber).tag(animal.tagNumber)
                    }
                }
                .pickerStyle(.menu)
                .frame(minHeight: Theme.minTapTarget)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(8)

                Text("Quick Select Drug")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                    ForEach(CattleDrug.commonDrugs.prefix(8)) { drug in
                        Button {
                            selectedDrug = drug
                            treatment = drug.name
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

                Button {
                    addTreatment()
                } label: {
                    Text("Add Treatment")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.primary)
                .disabled(selectedAnimalTag.isEmpty || treatment.isEmpty)
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
        }
        .padding(Theme.standardPadding)
    }

    private func addAnimal() {
        guard !tagNumber.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let newAnimal = Animal(
            tagNumber: tagNumber.trimmingCharacters(in: .whitespaces),
            breed: breed,
            dateOfBirth: Date(),
            sex: sex,
            status: .active
        )
        modelContext.insert(newAnimal)

        tagNumber = ""
        entriesAdded += 1

        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }

    private func addTreatment() {
        guard !selectedAnimalTag.isEmpty,
              let animal = animals.first(where: { $0.tagNumber == selectedAnimalTag }),
              !treatment.isEmpty else { return }

        var dosage = ""
        var route: TreatmentRoute = .subcutaneous
        var withdrawalDays = 0
        var reason = ""

        if let drug = selectedDrug {
            let weight = animal.purchaseWeight ?? 500
            let doseAmount = (weight / 100) * drug.dosagePerCwt
            dosage = "\(String(format: "%.1f", doseAmount)) \(drug.unit)"
            route = drug.route
            withdrawalDays = drug.withdrawalDays
            reason = drug.notes
        }

        let newRecord = TreatmentRecord(
            date: Date(),
            treatment: treatment,
            dosage: dosage,
            route: route,
            reason: reason,
            withdrawalDays: withdrawalDays,
            animal: animal
        )
        modelContext.insert(newRecord)

        selectedAnimalTag = ""
        treatment = ""
        selectedDrug = nil
        entriesAdded += 1

        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

#Preview {
    NavigationStack {
        QuickEntryView()
    }
    .modelContainer(for: [Animal.self, TreatmentRecord.self], inMemory: true)
}
