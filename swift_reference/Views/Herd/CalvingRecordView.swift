import SwiftUI
import SwiftData

struct CalvingRecordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let record: CalvingRecord?
    let animal: Animal

    @State private var date: Date = Date()
    @State private var calfTag: String = ""
    @State private var calfSex: AnimalSex = .calf
    @State private var birthWeight: Double = 0
    @State private var calvingEaseScore: Int = 1
    @State private var notes: String = ""
    @State private var createCalfRecord: Bool = true

    private var isEditing: Bool {
        record != nil
    }

    var body: some View {
        Form {
            Section("Calving Information") {
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .largeTapTarget()

                HStack {
                    Text("Calf Tag")
                    Spacer()
                    TextField("Required", text: $calfTag)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.characters)
                }
                .largeTapTarget()

                Picker("Calf Sex", selection: $calfSex) {
                    Text("Bull Calf").tag(AnimalSex.bull)
                    Text("Heifer Calf").tag(AnimalSex.heifer)
                    Text("Unknown").tag(AnimalSex.calf)
                }
                .largeTapTarget()

                HStack {
                    Text("Birth Weight")
                    Spacer()
                    TextField("lbs", value: $birthWeight, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                    Text("lbs")
                        .foregroundColor(.secondary)
                }
                .largeTapTarget()
            }

            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Calving Ease Score")
                        .font(.headline)

                    Picker("", selection: $calvingEaseScore) {
                        ForEach(1...5, id: \.self) { score in
                            Text("\(score)").tag(score)
                        }
                    }
                    .pickerStyle(.segmented)

                    Text(calvingEaseDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .largeTapTarget()
            }

            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 80)
            }

            if !isEditing {
                Section {
                    Toggle("Create calf record", isOn: $createCalfRecord)
                        .largeTapTarget()
                        .tint(Theme.earthGreen)

                    if createCalfRecord {
                        Text("A new animal record will be created for the calf with the dam linked to \(animal.tagNumber)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            if isEditing {
                Section {
                    Button(role: .destructive) {
                        deleteRecord()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Record")
                            Spacer()
                        }
                    }
                    .frame(minHeight: Theme.minTapTarget)
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Calving" : "Add Calving")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveRecord()
                }
                .fontWeight(.semibold)
                .disabled(calfTag.isEmpty)
            }
        }
        .onAppear {
            if let existingRecord = record {
                date = existingRecord.date
                calfTag = existingRecord.calfTag
                calfSex = existingRecord.calfSex
                birthWeight = existingRecord.birthWeight ?? 0
                calvingEaseScore = existingRecord.calvingEaseScore
                notes = existingRecord.notes
            }
        }
    }

    private var calvingEaseDescription: String {
        switch calvingEaseScore {
        case 1: return "1 - No assistance required"
        case 2: return "2 - Easy pull (one person)"
        case 3: return "3 - Mechanical assistance"
        case 4: return "4 - Hard pull (multiple people)"
        case 5: return "5 - Cesarean section"
        default: return ""
        }
    }

    private func saveRecord() {
        if let existingRecord = record {
            existingRecord.date = date
            existingRecord.calfTag = calfTag.trimmingCharacters(in: .whitespaces)
            existingRecord.calfSex = calfSex
            existingRecord.birthWeight = birthWeight > 0 ? birthWeight : nil
            existingRecord.calvingEaseScore = calvingEaseScore
            existingRecord.notes = notes
        } else {
            let newRecord = CalvingRecord(
                date: date,
                calfTag: calfTag.trimmingCharacters(in: .whitespaces),
                calfSex: calfSex,
                birthWeight: birthWeight > 0 ? birthWeight : nil,
                calvingEaseScore: calvingEaseScore,
                notes: notes,
                animal: animal
            )
            modelContext.insert(newRecord)

            if createCalfRecord {
                let calfAnimal = Animal(
                    tagNumber: calfTag.trimmingCharacters(in: .whitespaces),
                    breed: animal.breed,
                    dateOfBirth: date,
                    sex: calfSex == .bull ? .bull : (calfSex == .heifer ? .heifer : .calf),
                    status: .active,
                    sireTag: animal.sireTag,
                    damTag: animal.tagNumber,
                    notes: "Born to \(animal.tagNumber)"
                )
                modelContext.insert(calfAnimal)
            }
        }

        dismiss()
    }

    private func deleteRecord() {
        if let existingRecord = record {
            modelContext.delete(existingRecord)
        }
        dismiss()
    }
}

#Preview {
    NavigationStack {
        CalvingRecordView(record: nil, animal: Animal(tagNumber: "A001", sex: .cow))
    }
    .modelContainer(for: [Animal.self, CalvingRecord.self], inMemory: true)
}
