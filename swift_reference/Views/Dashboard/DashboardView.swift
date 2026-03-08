import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var locationService: LocationService
    @Query private var animals: [Animal]
    @Query private var settings: [RanchSettings]

    @State private var viewModel = DashboardViewModel()
    @State private var showingAddAnimal = false
    @State private var showingCalculator = false
    @State private var selectedTab = 1

    private var currentSettings: RanchSettings? {
        settings.first
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.standardPadding) {
                    weatherSection

                    marketSection

                    quickActionsSection

                    herdSummarySection
                }
                .padding(Theme.standardPadding)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(currentSettings?.ranchName ?? "Honest Cattle")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Theme.earthGreen)
                    }
                }
            }
            .refreshable {
                await refreshData()
            }
            .task {
                await loadInitialData()
            }
            .sheet(isPresented: $showingAddAnimal) {
                NavigationStack {
                    AnimalFormView(animal: nil)
                }
            }
            .sheet(isPresented: $showingCalculator) {
                NavigationStack {
                    BreakevenCalculatorView()
                }
            }
        }
    }

    @ViewBuilder
    private var weatherSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(Theme.earthGreen)
                Text(locationService.locationName.isEmpty ? "Loading location..." : locationService.locationName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if viewModel.isLoadingWeather {
                LoadingCard(title: "Loading weather...")
            } else if let error = viewModel.weatherError {
                ErrorCard(message: error) {
                    Task { await refreshData() }
                }
            } else if let weather = viewModel.currentWeather {
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top, spacing: 4) {
                            Text("\(Int(weather.temperature2m))")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                            Text("°F")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                        }

                        if let windChill = viewModel.windChill {
                            Text("Feels like \(Int(windChill))°F")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }

                        Text(WeatherCode.description(for: weather.weatherCode))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 8) {
                        Image(systemName: WeatherCode.sfSymbol(for: weather.weatherCode))
                            .font(.system(size: 44))
                            .foregroundColor(Theme.earthGreen)

                        HStack(spacing: 4) {
                            Image(systemName: "wind")
                                .font(.caption)
                            Text("\(Int(weather.windSpeed10m)) mph")
                                .font(.caption)
                        }
                        .foregroundColor(.secondary)

                        if weather.precipitation > 0 {
                            HStack(spacing: 4) {
                                Image(systemName: "drop.fill")
                                    .font(.caption)
                                Text("\(String(format: "%.2f", weather.precipitation))\"")
                                    .font(.caption)
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
                .cardStyle()
            }
        }
    }

    @ViewBuilder
    private var marketSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Market Prices")
                    .font(.headline)
                Spacer()
                NavigationLink {
                    MarketView()
                } label: {
                    Text("See All")
                        .font(.caption)
                        .foregroundColor(Theme.earthGreen)
                }
            }

            if viewModel.isLoadingMarket {
                LoadingCard(title: "Loading prices...")
            } else if let error = viewModel.marketError {
                ErrorCard(message: error) {
                    Task { await refreshData() }
                }
            } else {
                HStack(spacing: 12) {
                    if let feeder = viewModel.feederCattlePrice {
                        PriceCard(
                            title: "Feeder Cattle",
                            price: feeder.formattedPrice,
                            change: "\(feeder.formattedChange) (\(feeder.formattedChangePercent))",
                            isPositive: feeder.isPositive
                        )
                    }

                    if let live = viewModel.liveCattlePrice {
                        PriceCard(
                            title: "Live Cattle",
                            price: live.formattedPrice,
                            change: "\(live.formattedChange) (\(live.formattedChangePercent))",
                            isPositive: live.isPositive
                        )
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)

            HStack(spacing: 12) {
                LargeTapButton(title: "Add Animal", icon: "plus.circle.fill", color: Theme.earthGreen) {
                    showingAddAnimal = true
                }

                LargeTapButton(title: "Calculator", icon: "function", color: Theme.warmBrown) {
                    showingCalculator = true
                }

                NavigationLink {
                    MarketView()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 28))
                            .foregroundColor(.blue)

                        Text("Check Market")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 90)
                    .background(Color(.systemBackground))
                    .cornerRadius(Theme.cardCornerRadius)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var herdSummarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Herd Summary")
                    .font(.headline)
                Spacer()
                NavigationLink {
                    HerdView()
                } label: {
                    Text("View All")
                        .font(.caption)
                        .foregroundColor(Theme.earthGreen)
                }
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                SummaryStatView(
                    title: "Total",
                    value: "\(animals.count)",
                    icon: "pawprint.fill",
                    color: Theme.earthGreen
                )

                SummaryStatView(
                    title: "Active",
                    value: "\(animals.filter { $0.status == .active }.count)",
                    icon: "checkmark.circle.fill",
                    color: .green
                )

                let withdrawalCount = animals.filter { animal in
                    animal.treatmentRecords.contains { $0.isWithdrawalActive }
                }.count
                SummaryStatView(
                    title: "Withdrawal",
                    value: "\(withdrawalCount)",
                    icon: "clock.fill",
                    color: withdrawalCount > 0 ? .orange : .gray
                )
            }
        }
    }

    private func loadInitialData() async {
        if locationService.currentLocation == nil {
            locationService.requestLocation()
        }

        if let location = locationService.currentLocation {
            await viewModel.loadData(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        } else if let lat = currentSettings?.locationLatitude,
                  let lon = currentSettings?.locationLongitude {
            await viewModel.loadData(latitude: lat, longitude: lon)
        } else {
            await viewModel.loadData(latitude: 46.8797, longitude: -110.3626)
        }
    }

    private func refreshData() async {
        if let location = locationService.currentLocation {
            await viewModel.refresh(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        } else if let lat = currentSettings?.locationLatitude,
                  let lon = currentSettings?.locationLongitude {
            await viewModel.refresh(latitude: lat, longitude: lon)
        }
    }
}

struct SummaryStatView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: [Animal.self, CalvingRecord.self, TreatmentRecord.self, PriceAlert.self, RanchSettings.self], inMemory: true)
        .environmentObject(LocationService.shared)
}
