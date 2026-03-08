import Foundation
import SwiftData

@Model
final class Animal {
    var tagNumber: String
    var breed: String
    var dateOfBirth: Date
    var sex: AnimalSex
    var status: AnimalStatus
    var sireTag: String?
    var damTag: String?
    var notes: String
    var purchaseDate: Date?
    var purchaseWeight: Double?
    var purchasePrice: Double?
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \CalvingRecord.animal)
    var calvingRecords: [CalvingRecord] = []

    @Relationship(deleteRule: .cascade, inverse: \TreatmentRecord.animal)
    var treatmentRecords: [TreatmentRecord] = []

    init(
        tagNumber: String,
        breed: String = "",
        dateOfBirth: Date = Date(),
        sex: AnimalSex = .steer,
        status: AnimalStatus = .active,
        sireTag: String? = nil,
        damTag: String? = nil,
        notes: String = "",
        purchaseDate: Date? = nil,
        purchaseWeight: Double? = nil,
        purchasePrice: Double? = nil
    ) {
        self.tagNumber = tagNumber
        self.breed = breed
        self.dateOfBirth = dateOfBirth
        self.sex = sex
        self.status = status
        self.sireTag = sireTag
        self.damTag = damTag
        self.notes = notes
        self.purchaseDate = purchaseDate
        self.purchaseWeight = purchaseWeight
        self.purchasePrice = purchasePrice
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    var ageInMonths: Int {
        Calendar.current.dateComponents([.month], from: dateOfBirth, to: Date()).month ?? 0
    }

    var ageDescription: String {
        let months = ageInMonths
        if months < 12 {
            return "\(months) mo"
        } else {
            let years = months / 12
            let remainingMonths = months % 12
            if remainingMonths == 0 {
                return "\(years) yr"
            }
            return "\(years) yr \(remainingMonths) mo"
        }
    }
}

enum AnimalSex: String, Codable, CaseIterable {
    case bull = "Bull"
    case cow = "Cow"
    case heifer = "Heifer"
    case steer = "Steer"
    case calf = "Calf"

    var icon: String {
        switch self {
        case .bull: return "circle.fill"
        case .cow: return "circle"
        case .heifer: return "circle.bottomhalf.filled"
        case .steer: return "square.fill"
        case .calf: return "square"
        }
    }
}

enum AnimalStatus: String, Codable, CaseIterable {
    case active = "Active"
    case sold = "Sold"
    case deceased = "Deceased"
    case culled = "Culled"
    case breeding = "Breeding"
    case calving = "Calving"

    var color: String {
        switch self {
        case .active: return "EarthGreen"
        case .sold: return "WarmBrown"
        case .deceased: return "gray"
        case .culled: return "orange"
        case .breeding: return "blue"
        case .calving: return "purple"
        }
    }
}
