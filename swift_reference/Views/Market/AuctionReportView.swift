import SwiftUI

struct AuctionReportView: View {
    let reports: [AuctionReport]

    @State private var selectedReport: AuctionReport?

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        List {
            ForEach(reports) { report in
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(report.marketLocation)
                                    .font(.headline)

                                Text(dateFormatter.string(from: report.reportDate))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 4) {
                                Text("\(report.headCount)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("head")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }

                        Divider()

                        ForEach(report.weightClasses) { weightClass in
                            WeightClassPriceRow(weightClass: weightClass)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Auction Reports")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct WeightClassPriceRow: View {
    let weightClass: WeightClassPrice

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(weightClass.weightRange)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text("\(weightClass.headCount) head")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(weightClass.formattedAverage)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Theme.earthGreen)

                Text(weightClass.formattedRange)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct AuctionDetailView: View {
    let report: AuctionReport

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var body: some View {
        List {
            Section {
                LabeledContent("Market") {
                    Text(report.marketLocation)
                }

                LabeledContent("Date") {
                    Text(dateFormatter.string(from: report.reportDate))
                }

                LabeledContent("State") {
                    Text(report.state)
                }

                LabeledContent("Total Head") {
                    Text("\(report.headCount)")
                        .fontWeight(.bold)
                }
            }

            Section("Prices by Weight Class") {
                ForEach(report.weightClasses) { weightClass in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(weightClass.weightRange)
                                .font(.headline)

                            Spacer()

                            Text("\(weightClass.headCount) head")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            VStack(alignment: .leading) {
                                Text("Average")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(weightClass.formattedAverage)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Theme.earthGreen)
                            }

                            Spacer()

                            VStack(alignment: .center) {
                                Text("Low")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(String(format: "$%.2f", weightClass.lowPrice))
                                    .font(.subheadline)
                            }

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text("High")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(String(format: "$%.2f", weightClass.highPrice))
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Auction Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AuctionReportView(reports: [
            AuctionReport(
                reportDate: Date(),
                marketLocation: "Billings Livestock Commission",
                state: "MT",
                headCount: 1500,
                weightClasses: [
                    WeightClassPrice(weightRange: "500-600 lbs", averagePrice: 250, lowPrice: 235, highPrice: 265, headCount: 300),
                    WeightClassPrice(weightRange: "600-700 lbs", averagePrice: 230, lowPrice: 215, highPrice: 245, headCount: 400)
                ]
            )
        ])
    }
}
