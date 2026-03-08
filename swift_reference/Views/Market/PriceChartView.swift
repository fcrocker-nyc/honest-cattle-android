import SwiftUI
import Charts

struct PriceChartView: View {
    let dataPoints: [PriceDataPoint]
    let symbol: String

    private var minPrice: Double {
        (dataPoints.map { $0.price }.min() ?? 0) * 0.98
    }

    private var maxPrice: Double {
        (dataPoints.map { $0.price }.max() ?? 0) * 1.02
    }

    private var priceChange: Double {
        guard let first = dataPoints.first?.price,
              let last = dataPoints.last?.price else { return 0 }
        return last - first
    }

    private var chartColor: Color {
        priceChange >= 0 ? .green : .red
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(symbol == "GF" ? "Feeder Cattle" : "Live Cattle")
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                if let latest = dataPoints.last {
                    Text(String(format: "$%.2f", latest.price))
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }

            Chart(dataPoints) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Price", point.price)
                )
                .foregroundStyle(chartColor.gradient)
                .lineStyle(StrokeStyle(lineWidth: 2))

                AreaMark(
                    x: .value("Date", point.date),
                    y: .value("Price", point.price)
                )
                .foregroundStyle(chartColor.opacity(0.1).gradient)
            }
            .chartYScale(domain: minPrice...maxPrice)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 4)) { value in
                    AxisValueLabel {
                        if let date = value.as(Date.self) {
                            Text(date, format: .dateTime.month(.abbreviated).day())
                                .font(.caption2)
                        }
                    }
                    AxisGridLine()
                }
            }
            .chartYAxis {
                AxisMarks(position: .trailing, values: .automatic(desiredCount: 4)) { value in
                    AxisValueLabel {
                        if let price = value.as(Double.self) {
                            Text("$\(Int(price))")
                                .font(.caption2)
                        }
                    }
                    AxisGridLine()
                }
            }

            HStack {
                Text(priceChange >= 0 ? "+" : "")
                    .foregroundColor(chartColor) +
                Text(String(format: "%.2f", priceChange))
                    .foregroundColor(chartColor)

                Text("over period")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                if let first = dataPoints.first, let last = dataPoints.last {
                    let days = Calendar.current.dateComponents([.day], from: first.date, to: last.date).day ?? 0
                    Text("\(days) days")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .font(.caption)
        }
    }
}

#Preview {
    let sampleData: [PriceDataPoint] = (0..<30).map { i in
        PriceDataPoint(
            date: Calendar.current.date(byAdding: .day, value: -29 + i, to: Date())!,
            price: 245 + Double.random(in: -5...5) + Double(i) * 0.1
        )
    }

    return PriceChartView(dataPoints: sampleData, symbol: "GF")
        .frame(height: 200)
        .padding()
}
