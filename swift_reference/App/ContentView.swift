import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            MarketView()
                .tabItem {
                    Label("Market", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(1)

            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun.fill")
                }
                .tag(2)

            HerdView()
                .tabItem {
                    Label("Herd", systemImage: "pawprint.fill")
                }
                .tag(3)

            ToolsView()
                .tabItem {
                    Label("Tools", systemImage: "wrench.and.screwdriver.fill")
                }
                .tag(4)
        }
        .tint(Theme.earthGreen)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Animal.self, CalvingRecord.self, TreatmentRecord.self, PriceAlert.self, RanchSettings.self], inMemory: true)
        .environmentObject(LocationService.shared)
}
