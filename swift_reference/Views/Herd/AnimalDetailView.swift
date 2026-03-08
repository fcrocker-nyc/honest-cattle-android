import SwiftUI
import SwiftData

struct AnimalDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var animal: Animal

    @State private var showingEditAnimal = false
    @State private var showingAddCalving = false
    @State private var showingAddTreatment = false
    @State private var showingDeleteConfirmation = false

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.standardPadding) {
                headerSection

                infoSection

                if !animal.calvingRecords.isEmpty || animal.sex == .cow {
                    calvingSection
                }

                treatmentSection

                notesSection

                deleteSection
            }
            .padding(Theme.standardPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Animal Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditAnimal = true
                }
                .foregroundColor(Theme.earthGreen)
            }
        }
        .sheet(isPresented: $showingEditAnimal) {
            NavigationStack {
                AnimalFormView(animal: animal)
            }
        }
        .sheet(isPresented: $showingAddCalving) {
            NavigationStack {
                CalvingRecordView(record: nil, animal: animal)
            }
        }
        .sheet(isPresented: $showingAddTreatment) {
            NavigationStack {
                TreatmentRecordView(record: nil, animal: animal)
            }
        }
        .confirmationDialog("Delete Animal", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                deleteAnimal()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete \(animal.tagNumber)? This action cannot be undone.")
        }
    }

    @ViewBuilder
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: animal.sex.icon)
                    .font(.system(size: 44))
                    .foregroundColor(Theme.earthGreen)
                    .frame(width: 80, height: 80)
                    .background(Theme.earthGreen.opacity(0.1))
                    .cornerRadius(16)

                VStack(alignment: .leading, spacing: 8) {
                    Text(animal.tagNumber)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack(spacing: 8) {
                        Text(animal.sex.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        if !animal.breed.isEmpty {
                            Text("•")
                                .foregroundColor(.secondary)
                            Text(animal.breed)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    Text(animal.status.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(statusColor.opacity(0.1))
                        .foregroundColor(statusColor)
                        .cornerRadius(6)
                }

                Spacer()
            }

            if animal.treatmentRecords.contains(where: { $0.isWithdrawalActive }) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Active withdrawal period")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    Spacer()
                }
                .padding(12)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Information")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                InfoRow(label: "Date of Birth", value: dateFormatter.string(from: animal.dateOfBirth))
                InfoRow(label: "Age", value: animal.ageDescription)

                if let sireTag = animal.sireTag, !sireTag.isEmpty {
                    InfoRow(label: "Sire", value: sireTag)
                }

                if let damTag = animal.damTag, !damTag.isEmpty {
                    InfoRow(label: "Dam", value: damTag)
                }

                if let purchaseDate = animal.purchaseDate {
                    InfoRow(label: "Purchase Date", value: dateFormatter.string(from: purchaseDate))
                }

                if let purchaseWeight = animal.purchaseWeight {
                    InfoRow(label: "Purchase Weight", value: "\(Int(purchaseWeight)) lbs")
                }

                if let purchasePrice = animal.purchasePrice {
                    InfoRow(label: "Purchase Price", value: String(format: "$%.2f", purchasePrice))
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var calvingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Calving Records")
                    .font(.headline)

                Spacer()

                Button {
                    showingAddCalving = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Theme.earthGreen)
                }
            }

            if animal.calvingRecords.isEmpty {
                Text("No calving records")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                ForEach(animal.calvingRecords.sorted { $0.date > $1.date }) { record in
                    CalvingRecordRow(record: record)
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var treatmentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Treatment Records")
                    .font(.headline)

                Spacer()

                Button {
                    showingAddTreatment = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Theme.earthGreen)
                }
            }

            if animal.treatmentRecords.isEmpty {
                Text("No treatment records")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                ForEach(animal.treatmentRecords.sorted { $0.date > $1.date }) { record in
                    TreatmentRecordRow(record: record)
                }
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var notesSection: some View {
        if !animal.notes.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Notes")
                    .font(.headline)

                Text(animal.notes)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
    }

    @ViewBuilder
    private var deleteSection: some View {
        Button(role: .destructive) {
            showingDeleteConfirmation = true
        } label: {
            HStack {
                Spacer()
                Text("Delete Animal")
                Spacer()
            }
        }
        .frame(minHeight: Theme.minTapTarget)
        .cardStyle()
    }

    private var statusColor: Color {
        switch animal.status {
        case .active: return .green
        case .sold: return Theme.warmBrown
        case .deceased: return .gray
        case .culled: return .orange
        case .breeding: return .blue
        case .calving: return .purple
        }
    }

    private func deleteAnimal() {
        modelContext.delete(animal)
        dismiss()
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CalvingRecordRow: View {
    let record: CalvingRecord

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(dateFormatter.string(from: record.date))
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                Text("Ease: \(record.calvingEaseScore)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(calvingEaseColor.opacity(0.1))
                    .foregroundColor(calvingEaseColor)
                    .cornerRadius(4)
            }

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "tag.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(record.calfTag)
                        .font(.caption)
                }

                HStack(spacing: 4) {
                    Image(systemName: record.calfSex.icon)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(record.calfSex.rawValue)
                        .font(.caption)
                }

                if let weight = record.birthWeight {
                    HStack(spacing: 4) {
                        Image(systemName: "scalemass.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(weight)) lbs")
                            .font(.caption)
                    }
                }
            }
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }

    private var calvingEaseColor: Color {
        switch record.calvingEaseScore {
        case 1: return .green
        case 2: return .blue
        case 3: return .yellow
        case 4: return .orange
        case 5: return .red
        default: return .gray
        }
    }
}

struct TreatmentRecordRow: View {
    let record: TreatmentRecord

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(record.treatment)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                if record.isWithdrawalActive {
                    Text("\(record.daysUntilClear) days")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.orange.opacity(0.1))
                        .foregroundColor(.orange)
                        .cornerRadius(4)
                }
            }

            HStack(spacing: 16) {
                Text(dateFormatter.string(from: record.date))
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(record.dosage)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(record.route.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if !record.reason.isEmpty {
                Text(record.reason)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        AnimalDetailView(animal: Animal(tagNumber: "A001", breed: "Angus", sex: .cow, status: .active))
    }
    .modelContainer(for: [Animal.self, CalvingRecord.self, TreatmentRecord.self], inMemory: true)
}
