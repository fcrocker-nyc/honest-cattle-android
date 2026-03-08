import Foundation
import SwiftData

class DataExportService {
    static let shared = DataExportService()

    private init() {}

    func exportAnimalsToCSV(animals: [Animal]) -> String {
        var csv = "Tag Number,Breed,Date of Birth,Sex,Status,Sire Tag,Dam Tag,Notes,Purchase Date,Purchase Weight,Purchase Price,Created At\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for animal in animals {
            let row = [
                escapeCSV(animal.tagNumber),
                escapeCSV(animal.breed),
                dateFormatter.string(from: animal.dateOfBirth),
                animal.sex.rawValue,
                animal.status.rawValue,
                escapeCSV(animal.sireTag ?? ""),
                escapeCSV(animal.damTag ?? ""),
                escapeCSV(animal.notes),
                animal.purchaseDate.map { dateFormatter.string(from: $0) } ?? "",
                animal.purchaseWeight.map { String($0) } ?? "",
                animal.purchasePrice.map { String(format: "%.2f", $0) } ?? "",
                dateFormatter.string(from: animal.createdAt)
            ].joined(separator: ",")

            csv += row + "\n"
        }

        return csv
    }

    func exportCalvingRecordsToCSV(records: [CalvingRecord]) -> String {
        var csv = "Date,Dam Tag,Calf Tag,Calf Sex,Birth Weight,Calving Ease Score,Notes\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for record in records {
            let row = [
                dateFormatter.string(from: record.date),
                escapeCSV(record.animal?.tagNumber ?? "Unknown"),
                escapeCSV(record.calfTag),
                record.calfSex.rawValue,
                record.birthWeight.map { String($0) } ?? "",
                String(record.calvingEaseScore),
                escapeCSV(record.notes)
            ].joined(separator: ",")

            csv += row + "\n"
        }

        return csv
    }

    func exportTreatmentRecordsToCSV(records: [TreatmentRecord]) -> String {
        var csv = "Date,Animal Tag,Treatment,Dosage,Route,Reason,Withdrawal Days,Withdrawal Date,Notes\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for record in records {
            let row = [
                dateFormatter.string(from: record.date),
                escapeCSV(record.animal?.tagNumber ?? "Unknown"),
                escapeCSV(record.treatment),
                escapeCSV(record.dosage),
                record.route.rawValue,
                escapeCSV(record.reason),
                String(record.withdrawalDays),
                record.withdrawalDate.map { dateFormatter.string(from: $0) } ?? "",
                escapeCSV(record.notes)
            ].joined(separator: ",")

            csv += row + "\n"
        }

        return csv
    }

    func exportAllDataToCSV(animals: [Animal], calvingRecords: [CalvingRecord], treatmentRecords: [TreatmentRecord]) -> [String: String] {
        return [
            "animals.csv": exportAnimalsToCSV(animals: animals),
            "calving_records.csv": exportCalvingRecordsToCSV(records: calvingRecords),
            "treatment_records.csv": exportTreatmentRecordsToCSV(records: treatmentRecords)
        ]
    }

    private func escapeCSV(_ string: String) -> String {
        if string.contains(",") || string.contains("\"") || string.contains("\n") {
            let escaped = string.replacingOccurrences(of: "\"", with: "\"\"")
            return "\"\(escaped)\""
        }
        return string
    }

    func createExportURL(filename: String, content: String) throws -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent(filename)

        try content.write(to: fileURL, atomically: true, encoding: .utf8)

        return fileURL
    }
}
