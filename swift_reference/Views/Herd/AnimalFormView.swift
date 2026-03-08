import SwiftUI
import SwiftData

struct AnimalFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let animal: Animal?

    @State private var tagNumber: String = ""
    @State private var breed: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var sex: AnimalSex = .steer
    @State private var status: AnimalStatus = .active
    @State private var sireTag: String = ""
    @State private var damTag: String = ""
    @State private var notes: String = ""
    @State private var hasPurchaseInfo: Bool = false
    @State private var purchaseDate: Date = Date()
    @State private var purchaseWeight: Double = 0
    @State private var purchasePrice: Double = 0

    @State private var showingValidationError = false
    @State private var validationMessage = ""

    private var isEditing: Bool {
        animal != nil
    }

    private let commonBreeds = [
        "Angus", "Hereford", "Charolais", "Simmental", "Limousin",
        "Red Angus", "Black Baldy", "Brahman", "Shorthorn", "Gelbvieh"
    ]

    var body: some View {
        Form {
            Section("Basic Information") {
                HStack {
                    Text("Tag Number")
                    Spacer()
                    TextField("Required", text: $tagNumber)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.characters)
                }
                .largeTapTarget()

                Picker("Sex", selection: $sex) {
                    ForEach(AnimalSex.allCases, id: \.self) { sex in
                        HStack {
                            Image(systemName: sex.icon)
                            Text(sex.rawValue)
                        }
                        .tag(sex)
                    }
                }
                .largeTapTarget()

                Picker("Status", selection: $status) {
                    ForEach(AnimalStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .largeTapTarget()

                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .largeTapTarget()
            }

            Section("Breed") {
                Picker("Breed", selection: $breed) {
                    Text("Select Breed").tag("")
                    ForEach(commonBreeds, id: \.self) { breedOption in
                        Text(breedOption).tag(breedOption)
                    }
                }
                .largeTapTarget()

                if breed.isEmpty {
                    HStack {
                        Text("Custom Breed")
                        Spacer()
                        TextField("Optional", text: $breed)
                            .multilineTextAlignment(.trailing)
                    }
                    .largeTapTarget()
                }
            }

            Section("Lineage") {
                HStack {
                    Text("Sire Tag")
                    Spacer()
                    TextField("Optional", text: $sireTag)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.characters)
                }
                .largeTapTarget()

                HStack {
                    Text("Dam Tag")
                    Spacer()
                    TextField("Optional", text: $damTag)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.characters)
                }
                .largeTapTarget()
            }

            Section {
                Toggle("Include Purchase Info", isOn: $hasPurchaseInfo)
                    .largeTapTarget()
                    .tint(Theme.earthGreen)

                if hasPurchaseInfo {
                    DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                        .largeTapTarget()

                    HStack {
                        Text("Purchase Weight")
                        Spacer()
                        TextField("lbs", value: $purchaseWeight, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                        Text("lbs")
                            .foregroundColor(.secondary)
                    }
                    .largeTapTarget()

                    HStack {
                        Text("Purchase Price")
                        Spacer()
                        Text("$")
                            .foregroundColor(.secondary)
                        TextField("0.00", value: $purchasePrice, format: .number.precision(.fractionLength(2)))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .frame(width: 100)
                    }
                    .largeTapTarget()
                }
            }

            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 80)
            }
        }
        .navigationTitle(isEditing ? "Edit Animal" : "Add Animal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveAnimal()
                }
                .fontWeight(.semibold)
                .disabled(tagNumber.isEmpty)
            }
        }
        .alert("Validation Error", isPresented: $showingValidationError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(validationMessage)
        }
        .onAppear {
            if let existingAnimal = animal {
                tagNumber = existingAnimal.tagNumber
                breed = existingAnimal.breed
                dateOfBirth = existingAnimal.dateOfBirth
                sex = existingAnimal.sex
                status = existingAnimal.status
                sireTag = existingAnimal.sireTag ?? ""
                damTag = existingAnimal.damTag ?? ""
                notes = existingAnimal.notes
                hasPurchaseInfo = existingAnimal.purchaseDate != nil
                purchaseDate = existingAnimal.purchaseDate ?? Date()
                purchaseWeight = existingAnimal.purchaseWeight ?? 0
                purchasePrice = existingAnimal.purchasePrice ?? 0
            }
        }
    }

    private func saveAnimal() {
        guard !tagNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationMessage = "Tag number is required"
            showingValidationError = true
            return
        }

        if let existingAnimal = animal {
            existingAnimal.tagNumber = tagNumber.trimmingCharacters(in: .whitespaces)
            existingAnimal.breed = breed
            existingAnimal.dateOfBirth = dateOfBirth
            existingAnimal.sex = sex
            existingAnimal.status = status
            existingAnimal.sireTag = sireTag.isEmpty ? nil : sireTag
            existingAnimal.damTag = damTag.isEmpty ? nil : damTag
            existingAnimal.notes = notes
            existingAnimal.purchaseDate = hasPurchaseInfo ? purchaseDate : nil
            existingAnimal.purchaseWeight = hasPurchaseInfo && purchaseWeight > 0 ? purchaseWeight : nil
            existingAnimal.purchasePrice = hasPurchaseInfo && purchasePrice > 0 ? purchasePrice : nil
            existingAnimal.updatedAt = Date()
        } else {
            let newAnimal = Animal(
                tagNumber: tagNumber.trimmingCharacters(in: .whitespaces),
                breed: breed,
                dateOfBirth: dateOfBirth,
                sex: sex,
                status: status,
                sireTag: sireTag.isEmpty ? nil : sireTag,
                damTag: damTag.isEmpty ? nil : damTag,
                notes: notes,
                purchaseDate: hasPurchaseInfo ? purchaseDate : nil,
                purchaseWeight: hasPurchaseInfo && purchaseWeight > 0 ? purchaseWeight : nil,
                purchasePrice: hasPurchaseInfo && purchasePrice > 0 ? purchasePrice : nil
            )
            modelContext.insert(newAnimal)
        }

        dismiss()
    }
}

#Preview {
    NavigationStack {
        AnimalFormView(animal: nil)
    }
    .modelContainer(for: [Animal.self], inMemory: true)
}
