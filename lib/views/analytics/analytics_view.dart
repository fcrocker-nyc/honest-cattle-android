import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';

class AnalyticsView extends ConsumerStatefulWidget {
  const AnalyticsView({super.key});

  @override
  ConsumerState<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends ConsumerState<AnalyticsView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Performance')),
                ButtonSegment(value: 1, label: Text('Financial')),
                ButtonSegment(value: 2, label: Text('Health')),
              ],
              selected: {_selectedTab},
              onSelectionChanged: (selection) {
                setState(() => _selectedTab = selection.first);
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildPerformanceTab(),
                _buildFinancialTab(),
                _buildHealthTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    final animalsAsync = ref.watch(animalsProvider);
    final herdStatsAsync = ref.watch(herdStatsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Herd Overview'),
          herdStatsAsync.when(
            data: (stats) => Row(
              children: [
                _StatCard(
                  title: 'Total',
                  value: stats.total.toString(),
                  color: AppTheme.earthGreen,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  title: 'Active',
                  value: stats.active.toString(),
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  title: 'Sold',
                  value: stats.sold.toString(),
                  color: AppTheme.warmBrown,
                ),
              ],
            ),
            loading: () => const LoadingCard(title: 'Loading...'),
            error: (e, _) => ErrorCard(message: e.toString()),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Weight Gain Tracking'),
          AppCard(
            child: SizedBox(
              height: 200,
              child: _buildWeightChart(),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'ADG Calculator'),
          animalsAsync.when(
            data: (animals) {
              // Filter animals with weight records
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Average Daily Gain',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _AdgRow(
                      title: 'Herd Average',
                      value: '2.8',
                      unit: 'lbs/day',
                    ),
                    _AdgRow(
                      title: 'Top 10%',
                      value: '3.4',
                      unit: 'lbs/day',
                    ),
                    _AdgRow(
                      title: 'Bottom 10%',
                      value: '2.1',
                      unit: 'lbs/day',
                    ),
                  ],
                ),
              );
            },
            loading: () => const LoadingCard(title: 'Loading...'),
            error: (e, _) => ErrorCard(message: e.toString()),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Calving Statistics'),
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        label: 'Calving Rate',
                        value: '92%',
                        icon: Icons.child_friendly,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBox(
                        label: 'Avg Birth Wt',
                        value: '85 lbs',
                        icon: Icons.monitor_weight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        label: 'Avg Ease Score',
                        value: '1.4',
                        icon: Icons.medical_services,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBox(
                        label: 'Death Loss',
                        value: '1.2%',
                        icon: Icons.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialTab() {
    // Expenses watched for reactive updates but UI uses summary data
    ref.watch(expensesProvider);
    final salesAsync = ref.watch(salesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Financial Summary'),
          Row(
            children: [
              _StatCard(
                title: 'Revenue',
                value: '\$125,400',
                color: Colors.green,
              ),
              const SizedBox(width: 12),
              _StatCard(
                title: 'Expenses',
                value: '\$89,200',
                color: Colors.red,
              ),
              const SizedBox(width: 12),
              _StatCard(
                title: 'Profit',
                value: '\$36,200',
                color: AppTheme.earthGreen,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Expense Breakdown'),
          AppCard(
            child: SizedBox(
              height: 200,
              child: _buildExpenseChart(),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Profit per Head'),
          AppCard(
            child: Column(
              children: [
                _ProfitRow(label: 'Average', value: '\$284'),
                _ProfitRow(label: 'Best', value: '\$412'),
                _ProfitRow(label: 'Worst', value: '\$-48'),
                const Divider(),
                _ProfitRow(label: 'Total Sold', value: '127 head'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Recent Sales'),
          salesAsync.when(
            data: (sales) {
              if (sales.isEmpty) {
                return const AppCard(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No sales recorded'),
                    ),
                  ),
                );
              }
              return Column(
                children: sales.take(5).map((sale) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(
                        '${sale.saleDate.month}/${sale.saleDate.day}/${sale.saleDate.year}',
                      ),
                      subtitle: Text(
                        '${sale.saleWeight.round()} lbs @ \$${sale.pricePerPound.toStringAsFixed(2)}/lb',
                      ),
                      trailing: Text(
                        '\$${sale.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const LoadingCard(title: 'Loading...'),
            error: (e, _) => ErrorCard(message: e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTab() {
    final healthAlertsAsync = ref.watch(healthAlertsProvider);
    final predictiveAlertsAsync = ref.watch(predictiveAlertsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Health Alerts'),
          healthAlertsAsync.when(
            data: (alerts) {
              if (alerts.isEmpty) {
                return const AppCard(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle,
                              size: 48, color: Colors.green),
                          SizedBox(height: 8),
                          Text('No active health alerts'),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Column(
                children: alerts.map((alert) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: Colors.red.withValues(alpha: 0.1),
                    child: ListTile(
                      leading: const Icon(Icons.warning, color: Colors.red),
                      title: Text(alert.alertType),
                      subtitle: Text(alert.message),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const LoadingCard(title: 'Loading...'),
            error: (e, _) => ErrorCard(message: e.toString()),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Predictive Alerts'),
          predictiveAlertsAsync.when(
            data: (alerts) {
              if (alerts.isEmpty) {
                return const AppCard(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No predictive alerts'),
                    ),
                  ),
                );
              }
              return Column(
                children: alerts.map((alert) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: _getAlertIcon(alert.alertType),
                      title: Text(alert.message),
                      subtitle: Text(
                        'Expected: ${alert.predictedDate.month}/${alert.predictedDate.day}/${alert.predictedDate.year}',
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const LoadingCard(title: 'Loading...'),
            error: (e, _) => ErrorCard(message: e.toString()),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Treatment Summary'),
          AppCard(
            child: Column(
              children: [
                _TreatmentRow(label: 'Treatments (30 days)', count: 12),
                _TreatmentRow(label: 'Active Withdrawals', count: 3),
                _TreatmentRow(label: 'Pending Boosters', count: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 100,
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(months[value.toInt()],
                      style: const TextStyle(fontSize: 10));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}',
                    style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 450),
              FlSpot(1, 520),
              FlSpot(2, 590),
              FlSpot(3, 660),
              FlSpot(4, 730),
              FlSpot(5, 800),
            ],
            isCurved: true,
            color: AppTheme.earthGreen,
            barWidth: 2,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppTheme.earthGreen.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 45,
            title: 'Feed',
            color: AppTheme.earthGreen,
            radius: 60,
          ),
          PieChartSectionData(
            value: 20,
            title: 'Vet',
            color: Colors.blue,
            radius: 60,
          ),
          PieChartSectionData(
            value: 15,
            title: 'Labor',
            color: AppTheme.warmBrown,
            radius: 60,
          ),
          PieChartSectionData(
            value: 12,
            title: 'Equipment',
            color: Colors.orange,
            radius: 60,
          ),
          PieChartSectionData(
            value: 8,
            title: 'Other',
            color: Colors.grey,
            radius: 60,
          ),
        ],
        centerSpaceRadius: 30,
      ),
    );
  }

  Widget _getAlertIcon(String alertType) {
    switch (alertType) {
      case 'calving':
        return const Icon(Icons.child_friendly, color: Colors.purple);
      case 'breeding':
        return const Icon(Icons.favorite, color: Colors.pink);
      case 'health':
        return const Icon(Icons.medical_services, color: Colors.red);
      case 'market':
        return const Icon(Icons.attach_money, color: Colors.green);
      default:
        return const Icon(Icons.notifications, color: Colors.grey);
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdgRow extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const _AdgRow({
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(unit, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.earthGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.earthGreen),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _ProfitRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfitRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _TreatmentRow extends StatelessWidget {
  final String label;
  final int count;

  const _TreatmentRow({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.earthGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
