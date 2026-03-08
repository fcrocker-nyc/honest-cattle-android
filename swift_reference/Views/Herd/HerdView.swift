import SwiftUI
import SwiftData

struct HerdView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Animal.tagNumber) private var animals: [Animal]

    @State private var viewModel = HerdViewModel()
    @State private var showingAddAnimal = false
    @State private var showingQuickEntry = false
    @State private var showingFilters = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchAndFilterBar

                if viewModel.filteredAnimals(animals).isEmpty {
                    emptyStateView
                } else {
                    animalList
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Herd")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingQuickEntry = true
                    } label: {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Theme.earthGreen)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddAnimal = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Theme.earthGreen)
                    }
                }
            }
            .sheet(isPresented: $showingAddAnimal) {
                NavigationStack {
                    AnimalFormView(animal: nil)
                }
            }
            .sheet(isPresented: $showingQuickEntry) {
                NavigationStack {
                    QuickEntryView()
                }
            }
            .sheet(isPresented: $showingFilters) {
                FilterSheet(viewModel: viewModel)
            }
        }
    }

    @ViewBuilder
    private var searchAndFilterBar: some View {
        VStack(spacing: 12) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search by tag, breed, or notes", text: $viewModel.searchText)
                        .textFieldStyle(.plain)
                }
                .padding(12)
                .background(Color(.systemBackground))
                .cornerRadius(10)

                Button {
                    showingFilters = true
                } label: {
                    Image(systemName: viewModel.hasActiveFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                        .font(.title2)
                        .foregroundColor(viewModel.hasActiveFilters ? Theme.earthGreen : .secondary)
                }
            }

            HStack {
                Text("\(viewModel.filteredAnimals(animals).count) animals")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Menu {
                    ForEach(HerdViewModel.SortOrder.allCases, id: \.self) { order in
                        Button {
                            viewModel.sortOrder = order
                        } label: {
                            HStack {
                                Text(order.rawValue)
                                if viewModel.sortOrder == order {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("Sort: \(viewModel.sortOrder.rawValue)")
                            .font(.caption)
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                    }
                    .foregroundColor(Theme.earthGreen)
                }
            }

            if viewModel.hasActiveFilters {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        if let status = viewModel.selectedStatus {
                            FilterChip(text: status.rawValue) {
                                viewModel.selectedStatus = nil
                            }
                        }

                        if let sex = viewModel.selectedSex {
                            FilterChip(text: sex.rawValue) {
                                viewModel.selectedSex = nil
                            }
                        }

                        Button("Clear All") {
                            viewModel.clearFilters()
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(Theme.standardPadding)
    }

    @ViewBuilder
    private var animalList: some View {
        List {
            ForEach(viewModel.filteredAnimals(animals)) { animal in
                NavigationLink {
                    AnimalDetailView(animal: animal)
                } label: {
                    AnimalRowView(animal: animal)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }
            .onDelete(perform: deleteAnimals)
        }
        .listStyle(.plain)
    }

    @ViewBuilder
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "pawprint")
                .font(.system(size: 64))
                .foregroundColor(.secondary.opacity(0.5))

            if viewModel.hasActiveFilters {
                Text("No animals match your filters")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Button("Clear Filters") {
                    viewModel.clearFilters()
                }
                .buttonStyle(.primary)
                .frame(width: 160)
            } else {
                Text("No animals in your herd")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text("Add your first animal to get started")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button("Add Animal") {
                    showingAddAnimal = true
                }
                .buttonStyle(.primary)
                .frame(width: 160)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func deleteAnimals(at offsets: IndexSet) {
        let filtered = viewModel.filteredAnimals(animals)
        for index in offsets {
            let animal = filtered[index]
            modelContext.delete(animal)
        }
    }
}

struct AnimalRowView: View {
    let animal: Animal

    var body: some View {
        HStack(spacing: 12) {
            VStack {
                Image(systemName: animal.sex.icon)
                    .font(.title2)
                    .foregroundColor(Theme.earthGreen)
            }
            .frame(width: 44, height: 44)
            .background(Theme.earthGreen.opacity(0.1))
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(animal.tagNumber)
                        .font(.headline)

                    if animal.treatmentRecords.contains(where: { $0.isWithdrawalActive }) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                }

                HStack(spacing: 8) {
                    Text(animal.breed.isEmpty ? "Unknown breed" : animal.breed)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("•")
                        .foregroundColor(.secondary)

                    Text(animal.ageDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Text(animal.status.rawValue)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor(for: animal.status).opacity(0.1))
                .foregroundColor(statusColor(for: animal.status))
                .cornerRadius(4)
        }
        .padding(.vertical, 4)
    }

    private func statusColor(for status: AnimalStatus) -> Color {
        switch status {
        case .active: return .green
        case .sold: return Theme.warmBrown
        case .deceased: return .gray
        case .culled: return .orange
        case .breeding: return .blue
        case .calving: return .purple
        }
    }
}

struct FilterChip: View {
    let text: String
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Text(text)
                .font(.caption)

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.caption)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Theme.earthGreen.opacity(0.1))
        .foregroundColor(Theme.earthGreen)
        .cornerRadius(16)
    }
}

struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: HerdViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Status") {
                    ForEach(AnimalStatus.allCases, id: \.self) { status in
                        Button {
                            if viewModel.selectedStatus == status {
                                viewModel.selectedStatus = nil
                            } else {
                                viewModel.selectedStatus = status
                            }
                        } label: {
                            HStack {
                                Text(status.rawValue)
                                    .foregroundColor(.primary)
                                Spacer()
                                if viewModel.selectedStatus == status {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Theme.earthGreen)
                                }
                            }
                        }
                        .largeTapTarget()
                    }
                }

                Section("Sex") {
                    ForEach(AnimalSex.allCases, id: \.self) { sex in
                        Button {
                            if viewModel.selectedSex == sex {
                                viewModel.selectedSex = nil
                            } else {
                                viewModel.selectedSex = sex
                            }
                        } label: {
                            HStack {
                                Image(systemName: sex.icon)
                                    .foregroundColor(Theme.earthGreen)
                                Text(sex.rawValue)
                                    .foregroundColor(.primary)
                                Spacer()
                                if viewModel.selectedSex == sex {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Theme.earthGreen)
                                }
                            }
                        }
                        .largeTapTarget()
                    }
                }

                Section {
                    Button("Clear All Filters") {
                        viewModel.clearFilters()
                    }
                    .foregroundColor(.red)
                    .largeTapTarget()
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    HerdView()
        .modelContainer(for: [Animal.self, CalvingRecord.self, TreatmentRecord.self], inMemory: true)
}
