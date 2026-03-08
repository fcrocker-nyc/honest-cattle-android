import SwiftUI

struct ToolsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.standardPadding) {
                    calculatorsSection

                    referencesSection
                }
                .padding(Theme.standardPadding)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Tools")
        }
    }

    @ViewBuilder
    private var calculatorsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Calculators")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                NavigationLink {
                    BreakevenCalculatorView()
                } label: {
                    ToolCard(
                        title: "Breakeven",
                        subtitle: "Calculate selling price",
                        icon: "dollarsign.circle.fill",
                        color: Theme.earthGreen
                    )
                }
                .buttonStyle(.plain)

                NavigationLink {
                    DosageCalculatorView()
                } label: {
                    ToolCard(
                        title: "Dosage",
                        subtitle: "Drug calculations",
                        icon: "cross.vial.fill",
                        color: .blue
                    )
                }
                .buttonStyle(.plain)

                NavigationLink {
                    WeightEstimatorView()
                } label: {
                    ToolCard(
                        title: "Weight",
                        subtitle: "Tape estimate",
                        icon: "scalemass.fill",
                        color: Theme.warmBrown
                    )
                }
                .buttonStyle(.plain)

                NavigationLink {
                    ShippingPlannerView()
                } label: {
                    ToolCard(
                        title: "Shipping",
                        subtitle: "Plan ship dates",
                        icon: "truck.box.fill",
                        color: .orange
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var referencesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Reference")
                .font(.headline)

            VStack(spacing: 12) {
                ReferenceCard(
                    title: "Calving Ease Scores",
                    items: [
                        "1 - No assistance",
                        "2 - Easy pull (one person)",
                        "3 - Mechanical assistance",
                        "4 - Hard pull (multiple people)",
                        "5 - Cesarean section"
                    ]
                )

                ReferenceCard(
                    title: "Body Condition Scores",
                    items: [
                        "1 - Emaciated",
                        "3 - Thin",
                        "5 - Moderate",
                        "7 - Good",
                        "9 - Obese"
                    ]
                )

                ReferenceCard(
                    title: "Common Withdrawal Times",
                    items: [
                        "Draxxin - 18 days (meat)",
                        "Excede - 13 days",
                        "LA-200 - 28 days",
                        "Dectomax - 35 days",
                        "Banamine - 4 days"
                    ]
                )
            }
        }
    }
}

struct ToolCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)

            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 120)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct ReferenceCard: View {
    let title: String
    let items: [String]

    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
            }
            .largeTapTarget()

            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.leading, 8)
            }
        }
        .padding(Theme.standardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    ToolsView()
}
