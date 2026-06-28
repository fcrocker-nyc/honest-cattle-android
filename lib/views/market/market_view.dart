import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/market_data.dart';
import '../../providers/providers.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

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
      final summary = await marketService.fetchMarketData(forceRefresh: true);
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

  Future<void> _selectSymbol(String symbol) async {
    setState(() => _selectedSymbol = symbol);
    final marketService = ref.read(marketServiceProvider);
    final history = await marketService.fetchPriceHistory(
      symbol: symbol,
      days: _selectedRange.days,
    );
    setState(() => _priceHistory = history);
  }

  Future<void> _selectRange(_ChartRange range) async {
    setState(() => _selectedRange = range);
    final marketService = ref.read(marketServiceProvider);
    final history = await marketService.fetchPriceHistory(
      symbol: _selectedSymbol,
      days: range.days,
    );
    setState(() => _priceHistory = history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(
            tooltip: 'Calf Check — net to your gate',
            icon: const Icon(Icons.payments, color: AppTheme.earthGreen),
            onPressed: () => context.push('/tools/calculator'),
          ),
          IconButton(
            tooltip: 'Refresh market data',
            icon: const Icon(Icons.refresh, color: AppTheme.earthGreen),
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            if (_error != null) ...[
              ErrorCard(message: _error!, onRetry: _loadData),
              const SizedBox(height: 16),
            ],
            _buildFuturesSection(),
            const SizedBox(height: 16),
            _buildChartSection(),
            const SizedBox(height: 16),
            _buildAuctionSection(),
            const SizedBox(height: 16),
            const _PriceAlertsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFuturesSection() {
    if (_isLoading && _marketSummary == null) {
      return const LoadingCard(title: 'Loading futures prices...');
    }

    final feeder = _marketSummary?.feederCattle;
    final live = _marketSummary?.liveCattle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CardTitle(icon: Icons.show_chart, title: 'Futures Prices'),
        const SizedBox(height: 10),
        if (feeder == null && live == null)
          const AppCard(child: Text('No futures data available'))
        else ...[
          if (feeder != null)
            _FuturesContractCard(
              price: feeder,
              subtitle:
                  'Front-month CME Feeder Cattle (GF), the de-facto spot reference for 700-899 lb feeder steers.',
              selected: _selectedSymbol == 'GF',
              onTap: () => _selectSymbol('GF'),
            ),
          if (feeder != null && live != null) const SizedBox(height: 10),
          if (live != null)
            _FuturesContractCard(
              price: live,
              subtitle:
                  'CME Live Cattle (LE), the finished-cattle contract that anchors slaughter-window grid pricing.',
              selected: _selectedSymbol == 'LE',
              onTap: () => _selectSymbol('LE'),
            ),
        ],
      ],
    );
  }

  Widget _buildChartSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Front-month ${_selectedSymbol == 'GF' ? 'Feeder Cattle (GF)' : 'Live Cattle (LE)'} Trend',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            _selectedSymbol == 'GF'
                ? 'Tracks the closest-to-expiry feeder cattle contract used as the spot reference for Montana feeder pricing.'
                : 'Tracks the closest-to-expiry live cattle contract used as a grid base signal for fed-cattle pricing.',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          SegmentedButton<_ChartRange>(
            segments: _ChartRange.values
                .map(
                  (range) =>
                      ButtonSegment(value: range, label: Text(range.label)),
                )
                .toList(),
            selected: {_selectedRange},
            onSelectionChanged: (selection) => _selectRange(selection.first),
          ),
          const SizedBox(height: 14),
          if (_priceHistory.isEmpty)
            const SizedBox(
              height: 180,
              child: Center(child: Text('No price history')),
            )
          else
            SizedBox(height: 220, child: LineChart(_chartData())),
        ],
      ),
    );
  }

  LineChartData _chartData() {
    final prices = _priceHistory.map((point) => point.price).toList();
    final minPrice = prices.reduce(min) - 4;
    final maxPrice = prices.reduce(max) + 4;

    return LineChartData(
      minY: minPrice,
      maxY: maxPrice,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.black.withValues(alpha: 0.08), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: max(1, _priceHistory.length / 4),
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= _priceHistory.length) {
                return const SizedBox.shrink();
              }
              final date = _priceHistory[index].date;
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '${date.month}/${date.day}',
                  style: const TextStyle(fontSize: 10),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            getTitlesWidget: (value, meta) => Text(
              '\$${value.toInt()}',
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _priceHistory.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.price);
          }).toList(),
          isCurved: true,
          color: AppTheme.earthGreen,
          barWidth: 3,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AppTheme.earthGreen.withValues(alpha: 0.12),
          ),
        ),
      ],
    );
  }

  Widget _buildAuctionSection() {
    final reports = (_marketSummary?.recentAuctions ?? []).take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CardTitle(
          icon: Icons.account_balance,
          title: 'Recent Auctions',
        ),
        const SizedBox(height: 10),
        AppCard(
          child: reports.isEmpty
              ? const Text('No recent auction reports available')
              : Column(
                  children: [
                    for (final report in reports) ...[
                      _AuctionReportRow(report: report),
                      if (report != reports.last) const Divider(height: 20),
                    ],
                  ],
                ),
        ),
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

class _RancherShareCard extends StatelessWidget {
  const _RancherShareCard();

  static const _series = [40.8, 39.6, 38.9, 38.1, 39.4, 40.2];

  @override
  Widget build(BuildContext context) {
    const latest = 40.2;
    const fiveYearAverage = 41.6;
    const pti = latest - fiveYearAverage;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            icon: Icons.percent,
            title: 'Rancher Share of Retail Beef',
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${latest.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.alertOrange,
                ),
              ),
              const SizedBox(width: 12),
              const Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: _StatusChip(label: 'WATCH', color: AppTheme.alertOrange),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${pti.toStringAsFixed(1)} pp vs ${fiveYearAverage.toStringAsFixed(1)}% five-year average. "pp" = percentage points.',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final share in _series)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: FractionallySizedBox(
                        heightFactor: (share - 36) / 8,
                        alignment: Alignment.bottomCenter,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _shareColor(share),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Source: USDA ERS Meat Price Spreads. This card mirrors the iOS Market tab and website pill.',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  static Color _shareColor(double share) {
    if (share < 38) return AppTheme.errorRed;
    if (share < 40) return AppTheme.errorRed.withValues(alpha: 0.85);
    if (share < 41) return AppTheme.alertOrange;
    return Colors.green;
  }
}

class _GridFuturesCard extends StatefulWidget {
  const _GridFuturesCard();

  @override
  State<_GridFuturesCard> createState() => _GridFuturesCardState();
}

class _GridFuturesCardState extends State<_GridFuturesCard> {
  bool _showGlossary = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: _CardTitle(
                  icon: Icons.stacked_line_chart,
                  title: 'Grid Cash + Futures Curve',
                ),
              ),
              IconButton(
                tooltip: 'Explain this card',
                onPressed: () => setState(() => _showGlossary = !_showGlossary),
                icon: Icon(
                  _showGlossary ? Icons.info : Icons.info_outline,
                  color: AppTheme.earthGreen,
                ),
              ),
            ],
          ),
          if (_showGlossary) ...[
            const SizedBox(height: 8),
            const _InfoBlock(
              title: 'What this shows',
              text:
                  'Grid pricing starts with a USDA cash-fed base, then adds or subtracts for quality grade, yield grade, carcass weight, and market timing. LE, GF, and ZC futures help estimate the fed-cattle sale window and cost of gain.',
            ),
          ],
          const SizedBox(height: 12),
          const _InfoBlock(
            title: 'Delivery Window',
            text:
                'Calves shipping fall 2026. Anchored on the October 2026 Live Cattle contract for cattle placed into a feedlot now.',
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: _MetricBlock(
                  label: 'Five-Area Cash Fed',
                  value: '\$232.00',
                  unit: 'per cwt dressed',
                  note: 'USDA weekly weighted average',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricBlock(
                  label: 'Choice Cutout',
                  value: '\$344.50',
                  unit: 'per cwt',
                  note: 'Choice-Select spread: \$18.75',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _ContractTable(
            title: 'Live Cattle Futures (LE)',
            accent: Colors.blue,
            rows: [
              _ContractRowData('LEM26', 'Jun 2026', 225.42, 0.58, false),
              _ContractRowData('LEQ26', 'Aug 2026', 223.65, -0.34, false),
              _ContractRowData('LEV26', 'Oct 2026', 226.10, 0.42, true),
            ],
          ),
          const SizedBox(height: 10),
          const _ContractTable(
            title: 'Feeder Cattle Futures (GF)',
            accent: AppTheme.alertOrange,
            rows: [
              _ContractRowData('GFQ26', 'Aug 2026', 352.05, 1.22, false),
              _ContractRowData('GFU26', 'Sep 2026', 350.80, -0.15, true),
              _ContractRowData('GFV26', 'Oct 2026', 348.65, 0.36, false),
            ],
          ),
          const SizedBox(height: 10),
          const _InfoBlock(
            title: 'Implied Montana Calf Bid',
            text:
                '\$462/cwt for a 550-650 lb calf, approximately \$2,770 per 600-lb head. Uses the same break-even framing as the current iOS app.',
          ),
        ],
      ),
    );
  }
}

class _FuturesContractCard extends StatelessWidget {
  final FuturesPrice price;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _FuturesContractCard({
    required this.price,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.earthGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.trending_up, color: AppTheme.earthGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${price.name} (${price.symbol})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (selected)
                      const Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppTheme.earthGreen,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price.formattedPrice,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${price.formattedChange} (${price.formattedChangePercent})',
                style: TextStyle(
                  fontSize: 12,
                  color: price.isPositive ? Colors.green : AppTheme.errorRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuctionReportRow extends StatelessWidget {
  final AuctionReport report;

  const _AuctionReportRow({required this.report});

  @override
  Widget build(BuildContext context) {
    final leadClass = report.weightClasses.isNotEmpty
        ? report.weightClasses.first
        : null;

    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppTheme.warmBrown.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.scale, color: AppTheme.warmBrown),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report.marketLocation,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                leadClass == null
                    ? '${report.headCount} head'
                    : '${leadClass.weightRange} · ${report.headCount} head',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        Text(
          leadClass?.formattedAverage ?? '--',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _PriceAlertsCard extends StatelessWidget {
  const _PriceAlertsCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: _CardTitle(
                  icon: Icons.notifications_active,
                  title: 'Price Alerts',
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.earthGreen,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.notifications_off, color: Colors.grey, size: 20),
              const SizedBox(width: 10),
              Text(
                'No price alerts set',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CardTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.earthGreen),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppTheme.darkBrown,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String text;

  const _InfoBlock({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.earthGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Colors.grey[700],
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 3),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _MetricBlock extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String note;

  const _MetricBlock({
    required this.label,
    required this.value,
    required this.unit,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        Text(unit, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
        const SizedBox(height: 2),
        Text(note, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}

class _ContractTable extends StatelessWidget {
  final String title;
  final Color accent;
  final List<_ContractRowData> rows;

  const _ContractTable({
    required this.title,
    required this.accent,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        for (final row in rows)
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: row.primary
                  ? accent.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: row.primary ? 1 : 0.35),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        row.contract,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        row.label,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Text(
                  row.settle.toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${row.change >= 0 ? '+' : ''}${row.change.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: row.change >= 0 ? Colors.green : AppTheme.errorRed,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ContractRowData {
  final String contract;
  final String label;
  final double settle;
  final double change;
  final bool primary;

  const _ContractRowData(
    this.contract,
    this.label,
    this.settle,
    this.change,
    this.primary,
  );
}
