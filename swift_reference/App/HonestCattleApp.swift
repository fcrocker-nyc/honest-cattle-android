import SwiftUI
import SwiftData

@main
struct HonestCattleApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            let schema = Schema([
                Animal.self,
                CalvingRecord.self,
                TreatmentRecord.self,
                PriceAlert.self,
                RanchSettings.self
            ])

            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )

            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environmentObject(LocationService.shared)
        }
    }
}
