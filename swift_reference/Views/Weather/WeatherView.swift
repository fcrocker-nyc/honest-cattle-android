import SwiftUI
import SwiftData

struct WeatherView: View {
    @EnvironmentObject private var locationService: LocationService
    @Query private var settings: [RanchSettings]

    @State private var viewModel = WeatherViewModel()
    @State private var showingWindChillCalculator = false

    private var currentSettings: RanchSettings? {
        settings.first
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.standardPadding) {
                    locationSection

                    if viewModel.isLoading {
                        LoadingCard(title: "Loading weather...")
                    } else if let error = viewModel.error {
                        ErrorCard(message: error) {
                            Task { await refreshWeather() }
                        }
                    } else {
                        currentConditionsSection

                        if viewModel.hasSevereWeather {
                            severeWeatherSection
                        }

                        forecastSection

                        windChillSection
                    }
                }
                .padding(Theme.standardPadding)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Weather")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingWindChillCalculator = true
                    } label: {
                        Image(systemName: "thermometer.snowflake")
                            .foregroundColor(Theme.earthGreen)
                    }
                }
            }
            .refreshable {
                await refreshWeather()
            }
            .task {
                await loadWeather()
            }
            .sheet(isPresented: $showingWindChillCalculator) {
                NavigationStack {
                    WindChillCalculatorView()
                }
            }
        }
    }

    @ViewBuilder
    private var locationSection: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(Theme.earthGreen)

            Text(locationService.locationName.isEmpty ? "Loading location..." : locationService.locationName)
                .font(.subheadline)

            Spacer()

            if locationService.isLoading {
                ProgressView()
                    .scaleEffect(0.8)
            } else {
                Button {
                    locationService.requestLocation()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                        .foregroundColor(Theme.earthGreen)
                }
            }
        }
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private var currentConditionsSection: some View {
        if let weather = viewModel.currentWeather {
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top, spacing: 4) {
                            Text("\(Int(weather.temperature2m))")
                                .font(.system(size: 72, weight: .bold, design: .rounded))
                            Text("°F")
                                .font(.title)
                                .foregroundColor(.secondary)
                                .padding(.top, 12)
                        }

                        if let windChill = viewModel.windChillValue {
                            HStack(spacing: 4) {
                                Image(systemName: "thermometer.snowflake")
                                    .foregroundColor(.blue)
                                Text("Feels like \(Int(windChill))°F")
                                    .foregroundColor(.blue)
                            }
                            .font(.subheadline)
                        }

                        Text(WeatherCode.description(for: weather.weatherCode))
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Image(systemName: WeatherCode.sfSymbol(for: weather.weatherCode))
                        .font(.system(size: 64))
                        .foregroundColor(Theme.earthGreen)
                }

                Divider()

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    WeatherDetailItem(
                        icon: "wind",
                        value: "\(Int(weather.windSpeed10m)) mph",
                        label: "\(viewModel.windDirection)"
                    )

                    WeatherDetailItem(
                        icon: "humidity.fill",
                        value: "\(weather.relativeHumidity2m)%",
                        label: "Humidity"
                    )

                    WeatherDetailItem(
                        icon: "gauge.high",
                        value: "\(Int(weather.windGusts10m)) mph",
                        label: "Gusts"
                    )
                }

                if weather.precipitation > 0 {
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(.blue)
                        Text("Precipitation: \(String(format: "%.2f", weather.precipitation))\"")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .cardStyle()
        }
    }

    @ViewBuilder
    private var severeWeatherSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                Text("Weather Alerts")
                    .font(.headline)
            }

            ForEach(viewModel.severeWeatherDays) { day in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(day.date, format: .dateTime.weekday(.wide))
                            .font(.subheadline)
                            .fontWeight(.medium)

                        Text(day.weatherDescription)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        if day.maxWindGusts > 50 {
                            HStack(spacing: 4) {
                                Image(systemName: "wind")
                                Text("\(Int(day.maxWindGusts)) mph gusts")
                            }
                            .font(.caption)
                            .foregroundColor(.orange)
                        }

                        if day.precipitationSum > 0.5 {
                            HStack(spacing: 4) {
                                Image(systemName: "drop.fill")
                                Text("\(String(format: "%.2f", day.precipitationSum))\"")
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .padding(Theme.standardPadding)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(Theme.cardCornerRadius)
    }

    @ViewBuilder
    private var forecastSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("7-Day Forecast")
                .font(.headline)

            ForEach(viewModel.forecasts) { day in
                ForecastDayRow(forecast: day)
            }
        }
        .cardStyle()
    }

    @ViewBuilder
    private var windChillSection: some View {
        Button {
            showingWindChillCalculator = true
        } label: {
            HStack {
                Image(systemName: "thermometer.snowflake")
                    .font(.title2)
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Wind Chill Calculator")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Critical for calving season")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(.plain)
    }

    private func loadWeather() async {
        if let location = locationService.currentLocation {
            await viewModel.loadWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        } else if let lat = currentSettings?.locationLatitude,
                  let lon = currentSettings?.locationLongitude {
            await viewModel.loadWeather(latitude: lat, longitude: lon)
        } else {
            await viewModel.loadWeather(latitude: 46.8797, longitude: -110.3626)
        }
    }

    private func refreshWeather() async {
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

struct WeatherDetailItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Theme.earthGreen)

            Text(value)
                .font(.headline)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ForecastDayRow: View {
    let forecast: DayForecast

    var body: some View {
        HStack {
            Text(forecast.date, format: .dateTime.weekday(.abbreviated))
                .font(.subheadline)
                .frame(width: 40, alignment: .leading)

            Image(systemName: forecast.weatherIcon)
                .font(.title3)
                .foregroundColor(Theme.earthGreen)
                .frame(width: 30)

            if forecast.precipitationProbability > 0 {
                HStack(spacing: 2) {
                    Image(systemName: "drop.fill")
                        .font(.caption2)
                    Text("\(forecast.precipitationProbability)%")
                        .font(.caption)
                }
                .foregroundColor(.blue)
                .frame(width: 50)
            } else {
                Spacer()
                    .frame(width: 50)
            }

            Spacer()

            HStack(spacing: 8) {
                Text("\(Int(forecast.lowTemp))°")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(width: 35, alignment: .trailing)

                TemperatureBar(low: forecast.lowTemp, high: forecast.highTemp)
                    .frame(width: 60, height: 6)

                Text("\(Int(forecast.highTemp))°")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(width: 35, alignment: .leading)
            }
        }
        .padding(.vertical, 8)
    }
}

struct TemperatureBar: View {
    let low: Double
    let high: Double

    var body: some View {
        GeometryReader { geometry in
            let minTemp: Double = 0
            let maxTemp: Double = 100
            let range = maxTemp - minTemp

            let lowPosition = CGFloat((low - minTemp) / range) * geometry.size.width
            let highPosition = CGFloat((high - minTemp) / range) * geometry.size.width

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(highPosition - lowPosition, 10))
                    .offset(x: lowPosition)
            }
        }
    }
}

#Preview {
    WeatherView()
        .modelContainer(for: [RanchSettings.self], inMemory: true)
        .environmentObject(LocationService.shared)
}
