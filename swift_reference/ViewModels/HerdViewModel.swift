import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
class HerdViewModel {
    var searchText = ""
    var selectedStatus: AnimalStatus?
    var selectedSex: AnimalSex?
    var sortOrder: SortOrder = .tagNumber

    enum SortOrder: String, CaseIterable {
        case tagNumber = "Tag #"
        case dateOfBirth = "Age"
        case status = "Status"
        case recentlyAdded = "Recent"
    }

    func filteredAnimals(_ animals: [Animal]) -> [Animal] {
        var filtered = animals

        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.tagNumber.localizedCaseInsensitiveContains(searchText) ||
                $0.breed.localizedCaseInsensitiveContains(searchText) ||
                $0.notes.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let status = selectedStatus {
            filtered = filtered.filter { $0.status == status }
        }

        if let sex = selectedSex {
            filtered = filtered.filter { $0.sex == sex }
        }

        switch sortOrder {
        case .tagNumber:
            filtered.sort { $0.tagNumber.localizedStandardCompare($1.tagNumber) == .orderedAscending }
        case .dateOfBirth:
            filtered.sort { $0.dateOfBirth < $1.dateOfBirth }
        case .status:
            filtered.sort { $0.status.rawValue < $1.status.rawValue }
        case .recentlyAdded:
            filtered.sort { $0.createdAt > $1.createdAt }
        }

        return filtered
    }

    func clearFilters() {
        searchText = ""
        selectedStatus = nil
        selectedSex = nil
    }

    var hasActiveFilters: Bool {
        !searchText.isEmpty || selectedStatus != nil || selectedSex != nil
    }

    func countByStatus(_ animals: [Animal]) -> [AnimalStatus: Int] {
        var counts: [AnimalStatus: Int] = [:]
        for status in AnimalStatus.allCases {
            counts[status] = animals.filter { $0.status == status }.count
        }
        return counts
    }

    func animalsWithActiveWithdrawal(_ animals: [Animal]) -> [Animal] {
        animals.filter { animal in
            animal.treatmentRecords.contains { $0.isWithdrawalActive }
        }
    }
}
