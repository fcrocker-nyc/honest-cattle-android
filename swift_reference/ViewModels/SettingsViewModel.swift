import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
class SettingsViewModel {
    var isExporting = false
    var exportError: String?
    var showExportSuccess = false

    private let exportService = DataExportService.shared

    func exportData(animals: [Animal], modelContext: ModelContext) async -> URL? {
        isExporting = true
        exportError = nil

        do {
            let calvingDescriptor = FetchDescriptor<CalvingRecord>()
            let treatmentDescriptor = FetchDescriptor<TreatmentRecord>()

            let calvingRecords = try modelContext.fetch(calvingDescriptor)
            let treatmentRecords = try modelContext.fetch(treatmentDescriptor)

            let csvData = exportService.exportAllDataToCSV(
                animals: animals,
                calvingRecords: calvingRecords,
                treatmentRecords: treatmentRecords
            )

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: Date())

            var urls: [URL] = []

            for (filename, content) in csvData {
                let exportFilename = "\(dateString)_\(filename)"
                let url = try exportService.createExportURL(filename: exportFilename, content: content)
                urls.append(url)
            }

            isExporting = false
            showExportSuccess = true

            return urls.first

        } catch {
            exportError = error.localizedDescription
            isExporting = false
            return nil
        }
    }

    func createOrUpdateSettings(modelContext: ModelContext, settings: RanchSettings?) -> RanchSettings {
        if let existingSettings = settings {
            existingSettings.updatedAt = Date()
            return existingSettings
        } else {
            let newSettings = RanchSettings()
            modelContext.insert(newSettings)
            return newSettings
        }
    }
}
