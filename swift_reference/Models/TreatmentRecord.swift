import Foundation
import SwiftData

@Model
final class TreatmentRecord {
    var date: Date
    var treatment: String
    var dosage: String
    var route: TreatmentRoute
    var reason: String
    var withdrawalDays: Int
    var withdrawalDate: Date?
    var notes: String
    var createdAt: Date

    var animal: Animal?

    init(
        date: Date = Date(),
        treatment: String = "",
        dosage: String = "",
        route: TreatmentRoute = .subcutaneous,
        reason: String = "",
        withdrawalDays: Int = 0,
        notes: String = "",
        animal: Animal? = nil
    ) {
        self.date = date
        self.treatment = treatment
        self.dosage = dosage
        self.route = route
        self.reason = reason
        self.withdrawalDays = withdrawalDays
        self.notes = notes
        self.animal = animal
        self.createdAt = Date()

        if withdrawalDays > 0 {
            self.withdrawalDate = Calendar.current.date(byAdding: .day, value: withdrawalDays, to: date)
        }
    }

    var isWithdrawalActive: Bool {
        guard let withdrawalDate = withdrawalDate else { return false }
        return Date() < withdrawalDate
    }

    var daysUntilClear: Int {
        guard let withdrawalDate = withdrawalDate else { return 0 }
        return max(0, Calendar.current.dateComponents([.day], from: Date(), to: withdrawalDate).day ?? 0)
    }
}

enum TreatmentRoute: String, Codable, CaseIterable {
    case subcutaneous = "Subcutaneous (SQ)"
    case intramuscular = "Intramuscular (IM)"
    case intravenous = "Intravenous (IV)"
    case oral = "Oral"
    case topical = "Topical"
    case intranasal = "Intranasal"
}
