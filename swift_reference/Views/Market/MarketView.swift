import SwiftUI
import SwiftData

struct MarketView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var priceAlerts: [PriceAlert]

    @State private var viewModel = MarketViewModel()
    @State private var showingAddAlert = false
    @State private var selectedSection = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.standardPadding) {
                    futuresPricesSection

                    chartSection

                    auctionReportsSection

                    priceAlertsSection
                }
                .padding(Theme.standardPadding)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Market")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddAlert = true
                    } label: {
                        Image(systemName: "bell.badge.fill")
                            .foregroundColor(Theme.earthGreen)
                    }
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.loadMarketData()
            }
            .sheet(isPresented: $showingAddAlert) {
                NavigationStack {
                    PriceAlertView(alert: nil)
                }
            }
        }
    }

    @ViewBuilder
    private var futuresPricesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Futures Prices")
                .font(.headline)

            if viewModel.isLoading {
                LoadingCard(title: "Loading prices...")
            } else if let error = viewModel.error {
                ErrorCard(message: error) {
                    Task { await viewModel.refresh() }
                }
            } else {
                HStack(spacing: 12) {
                    if let feeder = viewModel.marketSummary.feederCattle {
                        FuturesPriceCard(price: feeder, isSelected: viewModel.selectedSymbol == "GF") {
                            Task { await viewModel.switchSymbol(to: "GF") }
                        }
                    }

                    if let live = viewModel.marketSummary.liveCattle {
                        FuturesPriceCard(price: live, isSelected: viewModel.selectedSymbol == "LE") {
                            Task { await viewModel.switchSymbol(to: "LE") }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Price History")
                    .font(.headline)

                Spacer()

                Picker("Range", selection: $viewModel.selectedChartRange) {
                    ForEach(MarketViewModel.ChartRange.allCases, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 150)
            }

            if !viewModel.currentPriceHistory.isEmpty {
                PriceChartView(
                    dataPoints: viewModel.currentPriceHistory,
                    symbol: viewModel.selectedSymbol
                )
                .frame(height: 200)
                .cardStyle()
            }
        }
    }

    @ViewBuilder
    private var auctionReportsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Auctions")
                    .font(.headline)

                Spacer()

                NavigationLink {
                    AuctionReportView(reports: viewModel.marketSummary.recentAuctions)
                } label: {
                    Text("See All")
                        .font(.caption)
                        .foregroundColor(Theme.earthGreen)
                }
            }

            if viewModel.marketSummary.recentAuctions.isEmpty {
                Text("No recent auction data")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cardStyle()
            } else {
                ForEach(viewModel.marketSummary.recentAuctions.prefix(3)) { report in
                    AuctionSummaryCard(report: report)
                }
            }
        }
    }

    @ViewBuilder
    private var priceAlertsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Price Alerts")
                    .font(.headline)

                Spacer()

                Button {
                    showingAddAlert = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Theme.earthGreen)
                }
            }

            if priceAlerts.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "bell.slash")
                        .font(.title)
                        .foregroundColor(.secondary)
                    Text("No price alerts set")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Button("Add Alert") {
                        showingAddAlert = true
                    }
                    .font(.caption)
                    .foregroundColor(Theme.earthGreen)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .cardStyle()
            } else {
                ForEach(priceAlerts) { alert in
                    PriceAlertCard(alert: alert)
                }
            }
        }
    }
}

struct FuturesPriceCard: View {
    let price: FuturesPrice
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(price.symbol)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Theme.earthGreen.opacity(0.2))
                        .cornerRadius(4)

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Theme.earthGreen)
                    }
                }

                Text(price.name)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(price.formattedPrice)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 4) {
                    Image(systemName: price.isPositive ? "arrow.up.right" : "arrow.down.right")
                        .font(.caption)
                    Text(price.formattedChange)
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("(\(price.formattedChangePercent))")
                        .font(.caption)
                }
                .foregroundColor(price.isPositive ? .green : .red)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Theme.standardPadding)
            .background(Color(.systemBackground))
            .cornerRadius(Theme.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.cardCornerRadius)
                    .stroke(isSelected ? Theme.earthGreen : Color.clear, lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(.plain)
    }
}

struct AuctionSummaryCard: View {
    let report: AuctionReport

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(report.marketLocation)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Text(dateFormatter.string(from: report.reportDate))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(report.headCount) head")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(report.state)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Theme.earthGreen.opacity(0.1))
                        .cornerRadius(4)
                }
            }

            Divider()

            if let midWeight = report.weightClasses.first(where: { $0.weightRange == "500-600 lbs" }) {
                HStack {
                    Text("500-600 lbs:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(midWeight.formattedAverage)
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("(\(midWeight.formattedRange))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct PriceAlertCard: View {
    @Environment(\.modelContext) private var modelContext
    let alert: PriceAlert

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.alertType.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(alert.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: Binding(
                get: { alert.isEnabled },
                set: { newValue in
                    alert.isEnabled = newValue
                }
            ))
            .labelsHidden()
            .tint(Theme.earthGreen)
        }
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    MarketView()
        .modelContainer(for: [PriceAlert.self], inMemory: true)
}
