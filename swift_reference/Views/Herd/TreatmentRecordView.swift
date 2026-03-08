import SwiftUI
import SwiftData

struct TreatmentRecordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let record: TreatmentRecord?
    let animal: Animal

    @State private var date: Date = Date()
    @State private var treatment: String = ""
    @State private var dosage: String = ""
    @State private var route: TreatmentRoute = .subcutaneous
    @State private var reason: String = ""
    @State private var withdrawalDays: Int = 0
    @State private var notes: String = ""
    @State private var selectedDrug: CattleDrug?

    private var isEditing: Bool {
        record != nil
    }

    private var withdrawalDate: Date? {
        guard withdrawalDays > 0 else { return nil }
        return Calendar.current.date(byAdding: .day, value: withdrawalDays, to: date)
    }

    var body: some View {
        Form {
            Section("Quick Select") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(CattleDrug.commonDrugs) { drug in
                            Button {
                                selectDrug(drug)
                            } label: {
                                Text(drug.name)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedDrug?.id == drug.id ? Theme.earthGreen : Color(.systemGray5))
                                    .foregroundColor(selectedDrug?.id == drug.id ? .white : .primary)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            Section("Treatment Details") {
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .largeTapTarget()

                HStack {
                    Text("Treatment")
                    Spacer()
                    TextField("Required", text: $treatment)
                        .multilineTextAlignment(.trailing)
                }
                .largeTapTarget()

                HStack {
                    Text("Dosage")
                    Spacer()
                    TextField("e.g., 5 mL", text: $dosage)
                        .multilineTextAlignment(.trailing)
                }
                .largeTapTarget()

                Picker("Route", selection: $route) {
                    ForEach(TreatmentRoute.allCases, id: \.self) { route in
                        Text(route.rawValue).tag(route)
                    }
                }
                .largeTapTarget()
            }

            Section("Reason") {
                TextField("e.g., BRD, Pinkeye, Footrot", text: $reason)
                    .largeTapTarget()
            }

            Section {
                Stepper("Withdrawal: \(withdrawalDays) days", value: $withdrawalDays, in: 0...90)
                    .largeTapTarget()

                if let withdrawalDate = withdrawalDate {
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(.orange)
                        Text("Clear date: \(withdrawalDate, format: .dateTime.month().day().year())")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
            } header: {
                Text("Withdrawal Period")
            } footer: {
                Text("Animal cannot be marketed until withdrawal period ends")
            }

            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 60)
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
        .navigationTitle(isEditing ? "Edit Treatment" : "Add Treatment")
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
                .disabled(treatment.isEmpty)
            }
        }
        .onAppear {
            if let existingRecord = record {
                date = existingRecord.date
                treatment = existingRecord.treatment
                dosage = existingRecord.dosage
                route = existingRecord.route
                reason = existingRecord.reason
                withdrawalDays = existingRecord.withdrawalDays
                notes = existingRecord.notes
            }
        }
    }

    private func selectDrug(_ drug: CattleDrug) {
        selectedDrug = drug
        treatment = drug.name
        route = drug.route
        withdrawalDays = drug.withdrawalDays
        reason = drug.notes

        let weight = animal.purchaseWeight ?? 500
            let doseAmount = (weight / 100) * drug.dosagePerCwt
            dosage = "\(String(format: "%.1f", doseAmount)) \(drug.unit)"
    }

    private func saveRecord() {
        if let existingRecord = record {
            existingRecord.date = date
            existingRecord.treatment = treatment.trimmingCharacters(in: .whitespaces)
            existingRecord.dosage = dosage
            existingRecord.route = route
            existingRecord.reason = reason
            existingRecord.withdrawalDays = withdrawalDays
            existingRecord.notes = notes

            if withdrawalDays > 0 {
                existingRecord.withdrawalDate = Calendar.current.date(byAdding: .day, value: withdrawalDays, to: date)
            } else {
                existingRecord.withdrawalDate = nil
            }
        } else {
            let newRecord = TreatmentRecord(
                date: date,
                treatment: treatment.trimmingCharacters(in: .whitespaces),
                dosage: dosage,
                route: route,
                reason: reason,
                withdrawalDays: withdrawalDays,
                notes: notes,
                animal: animal
            )
            modelContext.insert(newRecord)
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
        TreatmentRecordView(record: nil, animal: Animal(tagNumber: "A001"))
    }
    .modelContainer(for: [Animal.self, TreatmentRecord.self], inMemory: true)
}
