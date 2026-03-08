import Foundation
import SwiftData

@Model
final class CalvingRecord {
    var date: Date
    var calfTag: String
    var calfSex: AnimalSex
    var birthWeight: Double?
    var calvingEaseScore: Int
    var notes: String
    var createdAt: Date

    var animal: Animal?

    init(
        date: Date = Date(),
        calfTag: String = "",
        calfSex: AnimalSex = .calf,
        birthWeight: Double? = nil,
        calvingEaseScore: Int = 1,
        notes: String = "",
        animal: Animal? = nil
    ) {
        self.date = date
        self.calfTag = calfTag
        self.calfSex = calfSex
        self.birthWeight = birthWeight
        self.calvingEaseScore = calvingEaseScore
        self.notes = notes
        self.animal = animal
        self.createdAt = Date()
    }

    var calvingEaseDescription: String {
        switch calvingEaseScore {
        case 1: return "No assistance"
        case 2: return "Easy pull"
        case 3: return "Mechanical pull"
        case 4: return "Hard pull"
        case 5: return "C-section"
        default: return "Unknown"
        }
    }
}
