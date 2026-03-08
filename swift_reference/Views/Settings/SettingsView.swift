import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var locationService: LocationService
    @Query private var settings: [RanchSettings]
    @Query private var animals: [Animal]

    @State private var viewModel = SettingsViewModel()
    @State private var showingExportSheet = false
    @State private var exportURL: URL?
    @State private var showingLocationPicker = false

    private var currentSettings: RanchSettings {
        if let existing = settings.first {
            return existing
        } else {
            let newSettings = RanchSettings()
            modelContext.insert(newSettings)
            return newSettings
        }
    }

    var body: some View {
        Form {
            ranchSection

            locationSection

            notificationsSection

            dataSection

            aboutSection
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showingExportSheet) {
            if let url = exportURL {
                ShareSheet(items: [url])
            }
        }
    }

    @ViewBuilder
    private var ranchSection: some View {
        Section("Ranch") {
            HStack {
                Text("Ranch Name")
                Spacer()
                TextField("My Ranch", text: Binding(
                    get: { currentSettings.ranchName },
                    set: { currentSettings.ranchName = $0; currentSettings.updatedAt = Date() }
                ))
                .multilineTextAlignment(.trailing)
            }
            .largeTapTarget()
        }
    }

    @ViewBuilder
    private var locationSection: some View {
        Section {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Location")
                    if !locationService.locationName.isEmpty {
                        Text(locationService.locationName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else if currentSettings.hasLocation {
                        Text(currentSettings.locationName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Not set")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Button {
                    locationService.requestLocation()
                } label: {
                    if locationService.isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "location.fill")
                            .foregroundColor(Theme.earthGreen)
                    }
                }
            }
            .largeTapTarget()

            if let error = locationService.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            NavigationLink {
                ManualLocationView(settings: currentSettings)
            } label: {
                Text("Set Location Manually")
            }
            .largeTapTarget()
        } header: {
            Text("Location")
        } footer: {
            Text("Location is used for weather forecasts and nearby market information")
        }
    }

    @ViewBuilder
    private var notificationsSection: some View {
        Section("Notifications") {
            Toggle("Enable Notifications", isOn: Binding(
                get: { currentSettings.notificationsEnabled },
                set: { currentSettings.notificationsEnabled = $0; currentSettings.updatedAt = Date() }
            ))
            .largeTapTarget()
            .tint(Theme.earthGreen)

            if currentSettings.notificationsEnabled {
                Toggle("Price Alerts", isOn: Binding(
                    get: { currentSettings.priceAlertsEnabled },
                    set: { currentSettings.priceAlertsEnabled = $0; currentSettings.updatedAt = Date() }
                ))
                .largeTapTarget()
                .tint(Theme.earthGreen)

                Toggle("Weather Alerts", isOn: Binding(
                    get: { currentSettings.weatherAlertsEnabled },
                    set: { currentSettings.weatherAlertsEnabled = $0; currentSettings.updatedAt = Date() }
                ))
                .largeTapTarget()
                .tint(Theme.earthGreen)

                Toggle("Severe Weather Alerts", isOn: Binding(
                    get: { currentSettings.severeWeatherAlertsEnabled },
                    set: { currentSettings.severeWeatherAlertsEnabled = $0; currentSettings.updatedAt = Date() }
                ))
                .largeTapTarget()
                .tint(Theme.earthGreen)
            }
        }
    }

    @ViewBuilder
    private var dataSection: some View {
        Section {
            Button {
                Task {
                    if let url = await viewModel.exportData(animals: animals, modelContext: modelContext) {
                        exportURL = url
                        showingExportSheet = true
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Theme.earthGreen)
                    Text("Export Data (CSV)")
                        .foregroundColor(.primary)
                    Spacer()
                    if viewModel.isExporting {
                        ProgressView()
                    }
                }
            }
            .largeTapTarget()
            .disabled(viewModel.isExporting)

            if viewModel.showExportSuccess {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Export ready!")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            if let error = viewModel.exportError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            HStack {
                Text("Total Animals")
                Spacer()
                Text("\(animals.count)")
                    .foregroundColor(.secondary)
            }
            .largeTapTarget()
        } header: {
            Text("Data")
        } footer: {
            Text("Export creates CSV files for animals, calving records, and treatment records")
        }
    }

    @ViewBuilder
    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text("1.0.0")
                    .foregroundColor(.secondary)
            }
            .largeTapTarget()

            HStack {
                Text("Build")
                Spacer()
                Text("1")
                    .foregroundColor(.secondary)
            }
            .largeTapTarget()

            Link(destination: URL(string: "https://github.com")!) {
                HStack {
                    Text("Source Code")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.secondary)
                }
            }
            .largeTapTarget()
        }
    }
}

struct ManualLocationView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var settings: RanchSettings

    @State private var locationName: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""

    private let commonLocations = [
        ("Billings, MT", 45.7833, -108.5007),
        ("Great Falls, MT", 47.5053, -111.3008),
        ("Miles City, MT", 46.4083, -105.8406),
        ("Rapid City, SD", 44.0805, -103.2310),
        ("Cheyenne, WY", 41.1400, -104.8202),
        ("Bismarck, ND", 46.8083, -100.7837)
    ]

    var body: some View {
        Form {
            Section("Quick Select") {
                ForEach(commonLocations, id: \.0) { location in
                    Button {
                        locationName = location.0
                        latitude = String(location.1)
                        longitude = String(location.2)
                    } label: {
                        HStack {
                            Text(location.0)
                                .foregroundColor(.primary)
                            Spacer()
                            if settings.locationName == location.0 {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Theme.earthGreen)
                            }
                        }
                    }
                    .largeTapTarget()
                }
            }

            Section("Custom Location") {
                TextField("Location Name", text: $locationName)
                    .largeTapTarget()

                HStack {
                    Text("Latitude")
                    Spacer()
                    TextField("e.g., 46.8797", text: $latitude)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 120)
                }
                .largeTapTarget()

                HStack {
                    Text("Longitude")
                    Spacer()
                    TextField("e.g., -110.3626", text: $longitude)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 120)
                }
                .largeTapTarget()
            }

            Section {
                Button("Save Location") {
                    saveLocation()
                }
                .frame(maxWidth: .infinity)
                .largeTapTarget()
                .disabled(locationName.isEmpty || latitude.isEmpty || longitude.isEmpty)
            }
        }
        .navigationTitle("Set Location")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            locationName = settings.locationName
            if let lat = settings.locationLatitude {
                latitude = String(lat)
            }
            if let lon = settings.locationLongitude {
                longitude = String(lon)
            }
        }
    }

    private func saveLocation() {
        guard let lat = Double(latitude),
              let lon = Double(longitude) else { return }

        settings.locationName = locationName
        settings.locationLatitude = lat
        settings.locationLongitude = lon
        settings.updatedAt = Date()

        dismiss()
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .modelContainer(for: [RanchSettings.self, Animal.self], inMemory: true)
    .environmentObject(LocationService.shared)
}
