import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/market_data.dart';

class MarketView extends ConsumerStatefulWidget {
  const MarketView({super.key});

  @override
  ConsumerState<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends ConsumerState<MarketView> {
  MarketSummary? _marketSummary;
  List<PriceDataPoint> _priceHistory = [];
  bool _isLoading = true;
  String? _error;
  String _selectedSymbol = 'GF';
  _ChartRange _selectedRange = _ChartRange.thirtyDay;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final marketService = ref.read(marketServiceProvider);
      final summary = await marketService.fetchMarketData();
      final history = await marketService.fetchPriceHistory(
        symbol: _selectedSymbol,
        days: _selectedRange.days,
      );

      setState(() {
        _marketSummary = summary;
        _priceHistory = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppTheme.earthGreen),
            onPressed: () {
              // Show price alerts
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.standardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFuturesPrices(),
              const SizedBox(height: 16),
              _buildPriceChart(),
              const SizedBox(height: 16),
              _buildAuctionReports(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFuturesPrices() {
    if (_isLoading) {
      return const LoadingCard(title: 'Loading prices...');
    }

    if (_error != null) {
      return ErrorCard(message: _error!, onRetry: _loadData);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Futures Prices'),
        Row(
          children: [
            if (_marketSummary?.feederCattle != null)
              Expanded(
                child: _FuturesPriceCard(
                  price: _marketSummary!.feederCattle!,
                  isSelected: _selectedSymbol == 'GF',
                  onTap: () async {
                    setState(() => _selectedSymbol = 'GF');
                    final marketService = ref.read(marketServiceProvider);
                    final history = await marketService.fetchPriceHistory(
                      symbol: 'GF',
                      days: _selectedRange.days,
                    );
                    setState(() => _priceHistory = history);
                  },
                ),
              ),
            const SizedBox(width: 12),
            if (_marketSummary?.liveCattle != null)
              Expanded(
                child: _FuturesPriceCard(
                  price: _marketSummary!.liveCattle!,
                  isSelected: _selectedSymbol == 'LE',
                  onTap: () async {
                    setState(() => _selectedSymbol = 'LE');
                    final marketService = ref.read(marketServiceProvider);
                    final history = await marketService.fetchPriceHistory(
                      symbol: 'LE',
                      days: _selectedRange.days,
                    );
                    setState(() => _priceHistory = history);
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Price History',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SegmentedButton<_ChartRange>(
              segments: _ChartRange.values
                  .map((r) => ButtonSegment(value: r, label: Text(r.label)))
                  .toList(),
              selected: {_selectedRange},
              onSelectionChanged: (selection) async {
                setState(() => _selectedRange = selection.first);
                final marketService = ref.read(marketServiceProvider);
                final history = await marketService.fetchPriceHistory(
                  symbol: _selectedSymbol,
                  days: _selectedRange.days,
                );
                setState(() => _priceHistory = history);
              },
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_priceHistory.isNotEmpty)
          AppCard(
            child: SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: _priceHistory.length / 4,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= _priceHistory.length) {
                            return const SizedBox.shrink();
                          }
                          final date = _priceHistory[index].date;
                          return Text(
                            '${date.month}/${date.day}',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '\$${value.toInt()}',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _priceHistory.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.price);
                      }).toList(),
                      isCurved: true,
                      color: AppTheme.earthGreen,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.earthGreen.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAuctionReports() {
    if (_marketSummary == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Recent Auctions',
          actionText: 'See All',
        ),
        if (_marketSummary!.recentAuctions.isEmpty)
          const AppCard(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No recent auction data'),
              ),
            ),
          )
        else
          ...(_marketSummary!.recentAuctions.take(3).map((report) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _AuctionReportCard(report: report),
            );
          })),
      ],
    );
  }
}

enum _ChartRange {
  thirtyDay('30D', 30),
  ninetyDay('90D', 90),
  oneYear('1Y', 365);

  final String label;
  final int days;
  const _ChartRange(this.label, this.days);
}

class _FuturesPriceCard extends StatelessWidget {
  final FuturesPrice price;
  final bool isSelected;
  final VoidCallback onTap;

  const _FuturesPriceCard({
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
          border: isSelected
              ? Border.all(color: AppTheme.earthGreen, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.earthGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    price.symbol,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppTheme.earthGreen),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              price.name,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              price.formattedPrice,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  price.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: price.isPositive ? Colors.green : Colors.red,
                ),
                Text(
                  '${price.formattedChange} (${price.formattedChangePercent})',
                  style: TextStyle(
                    fontSize: 12,
                    color: price.isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AuctionReportCard extends StatelessWidget {
  final AuctionReport report;

  const _AuctionReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final midWeight =
        report.weightClasses.where((w) => w.weightRange == '500-600 lbs');

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.marketLocation,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${report.reportDate.month}/${report.reportDate.day}/${report.reportDate.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${report.headCount} head',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  StatusBadge(
                    text: report.state,
                    color: AppTheme.earthGreen,
                  ),
                ],
              ),
            ],
          ),
          if (midWeight.isNotEmpty) ...[
            const Divider(),
            Row(
              children: [
                Text(
                  '500-600 lbs: ',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  midWeight.first.formattedAverage,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' (${midWeight.first.formattedRange})',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
