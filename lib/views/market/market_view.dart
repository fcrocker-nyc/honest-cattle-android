import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/providers.dart';
import '../../services/hc_data_service.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

// Market tab, redesigned to match the iOS app: lead with the Honest Cattle
// calf forecast and bridge it to the futures (so the forecast and the
// futures-implied calf price read as one story, not two numbers at variance),
// then ground it in live signals — rancher share, the statewide auction pulse,
// and the summer video sales. Dropped the old sample/random CME futures cards
// and trend chart, and the heavy Billings tables (now a one-line pulse).

class MarketView extends ConsumerStatefulWidget {
  const MarketView({super.key});

  @override
  ConsumerState<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends ConsumerState<MarketView> {
  Future<void> _refresh() async {
    ref.invalidate(hcForecastProvider);
    ref.invalidate(gridFuturesProvider);
    ref.invalidate(rancherShareProvider);
    ref.invalidate(latestAuctionProvider);
    ref.invalidate(videoAuctionProvider);
    await Future.wait([
      ref.read(hcForecastProvider.future),
      ref.read(gridFuturesProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(
            tooltip: 'Refresh market data',
            icon: const Icon(Icons.refresh, color: AppTheme.earthGreen),
            onPressed: _refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: const [
            _CalfForecastHeroCard(),
            SizedBox(height: 16),
            _RancherShareCard(),
            SizedBox(height: 16),
            _MontanaAuctionsLiveCard(),
            SizedBox(height: 16),
            _VideoAuctionCard(),
            SizedBox(height: 16),
            _PriceAlertsCard(),
          ],
        ),
      ),
    );
  }
}

// MARK: - Calf forecast hero + variance bridge

class _CalfForecastHeroCard extends ConsumerWidget {
  const _CalfForecastHeroCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(hcForecastProvider);
    final grid = ref.watch(gridFuturesProvider).value;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            icon: Icons.insights,
            title: 'Honest Cattle Calf Forecast',
          ),
          const SizedBox(height: 12),
          forecastAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => Text(
              'Forecast is unavailable right now. Pull to refresh.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
            data: (fc) {
              final week =
                  (fc != null && fc.weeks.isNotEmpty) ? fc.weeks.first : null;
              final hero = (week != null && week.quarters.isNotEmpty)
                  ? week.quarters.first
                  : null;
              if (week == null || hero == null) {
                return Text(
                  'No forecast published yet.',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                );
              }
              return _content(week, hero, grid);
            },
          ),
        ],
      ),
    );
  }

  Widget _content(ForecastWeek week, ForecastQuarter hero, GridFutures? grid) {
    final heroMid = _mid(hero.steer);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              heroMid == null ? '—' : '\$${heroMid.round()}',
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: AppTheme.hcInk,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8, left: 6),
              child: Text('/cwt',
                  style: TextStyle(fontSize: 15, color: AppTheme.hcMutedBrown)),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _toneChip(hero),
            ),
          ],
        ),
        Text(
          '${hero.label} · Montana 550–650 lb steers',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.hcForestDark,
          ),
        ),
        if (hero.steer != null)
          Text(
            'steers ${hero.steer!.rangeText}'
            '${hero.heifer != null ? ' · heifers ${hero.heifer!.rangeText}' : ''}',
            style: const TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown),
          ),

        const _Rule(),
        // Price path
        const _SectionLabel('WHERE IT\'S HEADED'),
        const SizedBox(height: 6),
        _pricePath(week),

        const _Rule(),
        // This week's read
        const _SectionLabel('THIS WEEK\'S READ'),
        const SizedBox(height: 4),
        Text(_readSentence(week),
            style: const TextStyle(fontSize: 13, color: AppTheme.hcInk, height: 1.4)),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            final u = Uri.tryParse(week.sourceUrl);
            if (u != null) launchUrl(u, mode: LaunchMode.externalApplication);
          },
          child: Row(
            children: [
              Text('Updated ${_shortDate(week.asOf)} · open full forecast',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.hcSaddle)),
              const SizedBox(width: 4),
              const Icon(Icons.open_in_new, size: 13, color: AppTheme.hcSaddle),
            ],
          ),
        ),

        // Variance bridge
        if (_bridgeReady(grid, heroMid)) ...[
          const _Rule(),
          const _SectionLabel('FORECAST vs. THE FUTURES'),
          const SizedBox(height: 8),
          _bridge(grid!, heroMid!),
        ],
      ],
    );
  }

  bool _bridgeReady(GridFutures? grid, double? heroMid) =>
      grid != null &&
      grid.impliedCalfPerCwt != null &&
      grid.feederSettle != null &&
      heroMid != null;

  Widget _bridge(GridFutures grid, double heroMid) {
    final implied = grid.impliedCalfPerCwt!;
    final delta = (heroMid - implied).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bridgeRow(
          icon: Icons.bar_chart,
          title: 'CME feeder cattle (GF)',
          sub: grid.feederLabel.isEmpty ? grid.feederContract : grid.feederLabel,
          value: '\$${grid.feederSettle!.round()}',
          valueSub: _changeText(grid.feederChangeWeek),
        ),
        const _BridgeArrow(),
        _bridgeRow(
          icon: Icons.functions,
          title: 'Futures-implied Montana calf',
          sub: '550–650 lb · anchor ${grid.anchorContract}',
          value: '\$${implied.round()}',
        ),
        const _BridgeArrow(),
        _bridgeRow(
          icon: Icons.eco,
          title: 'Honest Cattle forecast',
          sub: 'Montana-origin, verified source',
          value: '\$${heroMid.round()}',
          emphasized: true,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.hcForest.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _deltaSentence(delta),
            style: const TextStyle(
                fontSize: 12, color: AppTheme.hcForestDark, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _bridgeRow({
    required IconData icon,
    required String title,
    required String sub,
    required String value,
    String? valueSub,
    bool emphasized = false,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Icon(icon,
              size: 16,
              color: emphasized ? AppTheme.hcForest : AppTheme.hcMutedBrown),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: emphasized ? FontWeight.w800 : FontWeight.w700,
                      color: AppTheme.hcInk)),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.hcMutedBrown)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: emphasized ? 20 : 16,
                    fontWeight: FontWeight.w900,
                    color: emphasized ? AppTheme.hcForest : AppTheme.hcInk)),
            if (valueSub != null)
              Text(valueSub,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: valueSub.startsWith('−')
                          ? AppTheme.errorRed
                          : AppTheme.hcForest)),
          ],
        ),
      ],
    );
  }

  Widget _pricePath(ForecastWeek week) {
    final quarters = week.quarters.take(4).toList();
    final cells = <Widget>[];
    for (var i = 0; i < quarters.length; i++) {
      if (i > 0) {
        cells.add(const Icon(Icons.arrow_right_alt,
            size: 16, color: AppTheme.hcTanRule));
      }
      final q = quarters[i];
      final mid = _mid(q.steer);
      cells.add(Expanded(
        child: Column(
          children: [
            Text(q.label.replaceAll(' 20', ' \''),
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.hcMutedBrown)),
            Text(mid == null ? '—' : '\$${mid.round()}',
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.hcInk)),
            _toneIcon(q),
          ],
        ),
      ));
    }
    return Row(children: cells);
  }

  Widget _toneIcon(ForecastQuarter q) {
    final t = _tone(q);
    if (t == 'up') {
      return const Icon(Icons.north_east, size: 12, color: AppTheme.hcForest);
    }
    if (t == 'down') {
      return const Icon(Icons.south_east, size: 12, color: AppTheme.errorRed);
    }
    return const Icon(Icons.remove, size: 12, color: AppTheme.hcMutedBrown);
  }

  Widget _toneChip(ForecastQuarter q) {
    final t = _tone(q);
    final color = t == 'up'
        ? AppTheme.hcForest
        : (t == 'down' ? AppTheme.errorRed : AppTheme.hcMutedBrown);
    return _StatusChip(label: q.displayStatus, color: color);
  }

  String _readSentence(ForecastWeek week) {
    final ups =
        week.quarters.where((q) => _tone(q) == 'up').map((q) => q.label).toList();
    final downs = week.quarters
        .where((q) => _tone(q) == 'down')
        .map((q) => q.label)
        .toList();
    if (ups.isEmpty && downs.isEmpty) {
      return 'Forecast held across all quarters — no change to the calf-price outlook this week.';
    }
    final parts = <String>[];
    if (ups.isNotEmpty) parts.add('${ups.join(', ')} adjusted up');
    if (downs.isNotEmpty) parts.add('${downs.join(', ')} adjusted down');
    return '${parts.join('; ')} this week; remaining quarters held.';
  }

  String _deltaSentence(int delta) {
    if (delta.abs() < 1) {
      return 'Our forecast sits right on the futures-implied bid — the market is paying Montana calves in line with the national feeder curve.';
    }
    final dir = delta > 0 ? 'over' : 'under';
    final why = delta > 0
        ? 'We read a Montana-origin reputation & verified-source premium the mechanical futures bid leaves out.'
        : 'We read Montana basis and freight pulling below the national futures-implied bid.';
    return 'Our forecast reads \$${delta.abs()}/cwt $dir the futures-implied bid. $why';
  }

  String? _changeText(double? cw) {
    if (cw == null) return null;
    final sign = cw >= 0 ? '+' : '−';
    return '$sign${cw.abs().toStringAsFixed(2)} wk';
  }

  String _tone(ForecastQuarter q) {
    final s = q.status.toUpperCase();
    if (s.contains('UP')) return 'up';
    if (s.contains('DOWN')) return 'down';
    return 'steady';
  }

  double? _mid(PriceBand? b) {
    if (b == null) return null;
    if (b.mid != null) return b.mid;
    if (b.low != null && b.high != null) return (b.low! + b.high!) / 2;
    return null;
  }

  String _shortDate(String iso) {
    final parts = iso.split('-');
    if (parts.length != 3) return iso;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final m = int.tryParse(parts[1]) ?? 0;
    final d = int.tryParse(parts[2]) ?? 0;
    if (m < 1 || m > 12) return iso;
    return '${months[m - 1]} $d';
  }
}

// MARK: - Montana statewide auction pulse

class _MontanaAuctionsLiveCard extends ConsumerWidget {
  const _MontanaAuctionsLiveCard();

  static final Uri _trendsUrl =
      Uri.parse('https://honestcattle.net/montana-cattle-auction-trends/');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(latestAuctionProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(icon: Icons.gavel, title: 'Montana Auction Pulse'),
          const SizedBox(height: 12),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => Text(
              'Live auction data is unavailable right now. Pull to refresh.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
            data: (snap) => snap == null
                ? Text(
                    'No recent Montana auction report published yet.',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  )
                : _content(snap),
          ),
        ],
      ),
    );
  }

  Widget _content(MontanaAuctionSnapshot snap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatInt(snap.totalReceipts),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: AppTheme.earthGreen,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 6, left: 8),
              child:
                  Text('head', style: TextStyle(fontSize: 13, color: Colors.grey)),
            ),
            const Spacer(),
            Text('Week of ${_formatDate(snap.saleDate)}',
                style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
        if (snap.classifiedHead > 0) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusChip(
                  label: 'Feeder ${snap.feederPct.round()}%',
                  color: AppTheme.earthGreen),
              _StatusChip(
                  label: 'Slaughter ${snap.slaughterPct.round()}%',
                  color: AppTheme.warmBrown),
              _StatusChip(
                  label: 'Replacement ${snap.replacementPct.round()}%',
                  color: AppTheme.skyBlue),
            ],
          ),
        ],
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.hcCallout,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.hcTanRule),
          ),
          child: const Text(
            'Public auctions are only ~16% of Montana cattle marketing — another '
            '~19% sell on video/satellite and ~65% by private treaty, so auction '
            'prices reflect just part of the market.',
            style: TextStyle(fontSize: 12, color: AppTheme.hcInk, height: 1.4),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () =>
              launchUrl(_trendsUrl, mode: LaunchMode.externalApplication),
          child: const Row(
            children: [
              Text(
                'See full Billings auction trends',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.warmBrown,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 15, color: AppTheme.warmBrown),
            ],
          ),
        ),
      ],
    );
  }

  String _formatInt(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  String _formatDate(String iso) {
    final parts = iso.split('-');
    if (parts.length != 3) return iso;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final m = int.tryParse(parts[1]) ?? 0;
    final d = int.tryParse(parts[2]) ?? 0;
    if (m < 1 || m > 12) return iso;
    return '${months[m - 1]} $d';
  }
}

// MARK: - Summer video sales

class _VideoAuctionCard extends ConsumerWidget {
  const _VideoAuctionCard();

  static const int _freshnessWindowDays = 45;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(videoAuctionProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
              icon: Icons.videocam, title: 'Summer Video Sales'),
          const SizedBox(height: 12),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => _placeholder(),
            data: (snap) => snap == null ? _placeholder() : _content(snap),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summer video series (NLVA, Superior, WVM) — results post here as the sales run.',
            style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4),
          ),
          const SizedBox(height: 10),
          _roster(const []),
        ],
      );

  Widget _content(VideoAuctionSnapshot snap) {
    final days = _daysAgo(snap.saleDate);
    final current = days != null && days <= _freshnessWindowDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (current) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  snap.auction.isEmpty ? 'Video sale' : snap.auction,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.hcInk),
                ),
              ),
              Text(_shortDate(snap.saleDate),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.hcForest)),
            ],
          ),
          const SizedBox(height: 2),
          Text(_headline(snap),
              style: const TextStyle(
                  fontSize: 13, color: AppTheme.hcForestDark)),
          if (snap.narrative.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(_trim(snap.narrative, 200),
                style: TextStyle(
                    fontSize: 12, color: Colors.grey[700], height: 1.4)),
          ],
        ] else ...[
          const Text('Between sales',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.hcForestDark)),
          const SizedBox(height: 2),
          Text(
            'Most recent: ${snap.auction.isEmpty ? 'video sale' : snap.auction}, '
            '${_shortDate(snap.saleDate)}'
            '${snap.totalReceipts > 0 ? ' (${_formatInt(snap.totalReceipts)} hd)' : ''}. '
            'New summer results post here as the series runs.',
            style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
        ],
        const SizedBox(height: 10),
        _roster(snap.roster),
      ],
    );
  }

  Widget _roster(List<VideoRosterEntry> entries) {
    final labels = entries.isEmpty
        ? const ['NLVA', 'Superior', 'WVM']
        : entries.map((e) => e.shortLabel).toList();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final l in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.hcForest.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(l,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.hcForestDark)),
          ),
      ],
    );
  }

  String _headline(VideoAuctionSnapshot snap) {
    final bits = <String>[];
    if (snap.totalReceipts > 0) bits.add('${_formatInt(snap.totalReceipts)} hd sold');
    if (snap.receiptsOffered > 0 && snap.receiptsOffered != snap.totalReceipts) {
      bits.add('of ${_formatInt(snap.receiptsOffered)} offered');
    }
    if (snap.calfSteerPrice != null) {
      bits.add('550–650 lb steers \$${snap.calfSteerPrice!.round()}/cwt');
    }
    return bits.isEmpty ? 'Results posted.' : bits.join(' · ');
  }

  int? _daysAgo(String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return null;
    return DateTime.now().difference(d).inDays;
  }

  String _formatInt(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  String _shortDate(String iso) {
    final parts = iso.split('-');
    if (parts.length != 3) return iso;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final m = int.tryParse(parts[1]) ?? 0;
    final d = int.tryParse(parts[2]) ?? 0;
    if (m < 1 || m > 12) return iso;
    return '${months[m - 1]} $d';
  }

  String _trim(String s, int max) {
    final t = s.trim();
    if (t.length <= max) return t;
    return '${t.substring(0, max).trimRight()}…';
  }
}

// MARK: - Rancher share of retail beef

class _RancherShareCard extends ConsumerWidget {
  const _RancherShareCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(rancherShareProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            icon: Icons.percent,
            title: 'Rancher Share of Retail Beef',
          ),
          const SizedBox(height: 12),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => Text(
              'USDA ERS share is unavailable right now. Pull to refresh.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
            data: (rs) => rs == null
                ? Text(
                    'USDA ERS share is unavailable right now. Pull to refresh.',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  )
                : _content(rs),
          ),
        ],
      ),
    );
  }

  Widget _content(RancherShare rs) {
    final color = rs.isGreen
        ? AppTheme.earthGreen
        : (rs.isYellow ? AppTheme.warmBrown : AppTheme.errorRed);
    final pti = rs.ptiValue;
    final up = pti >= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${rs.pct.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: _StatusChip(label: rs.badge, color: color),
            ),
            if (rs.prevPct != null) ...[
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Text(
                  _delta(rs.pct, rs.prevPct!),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: (rs.pct - rs.prevPct!) >= 0
                        ? AppTheme.earthGreen
                        : AppTheme.errorRed,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        if (rs.farm != null && rs.retail != null)
          Text(
            'Farm value ${rs.farm!.round()}¢/lb · Retail value ${rs.retail!.round()}¢/lb. '
            'Farm-level prices are ${rs.pct >= RancherShare.floorPct ? 'at or above' : 'below'} the 39% floor.',
            style: TextStyle(fontSize: 13, color: Colors.grey[800], height: 1.4),
          ),
        const SizedBox(height: 8),
        Text(
          'PTI ${up ? '+' : ''}${pti.toStringAsFixed(1)} pp vs ${RancherShare.fiveYearAvg}% five-year average — '
          '${up ? 'bullish for Montana calf bids on a 4–8 week lag.' : 'retail margin compression; watch for calf-bid softness.'}',
          style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.4),
        ),
        const SizedBox(height: 8),
        Text(
          'Source: USDA ERS Meat Price Spreads, ${rs.asOf}. '
          'Thresholds: Red <39% · Yellow 39–41% · Green >41%.',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _delta(double pct, double prev) {
    final d = pct - prev;
    if (d.abs() < 0.2) return '↔ flat';
    return d > 0
        ? '↑ +${d.toStringAsFixed(1)}pp'
        : '↓ ${d.toStringAsFixed(1)}pp';
  }
}

// MARK: - Price alerts (placeholder, parity with iOS)

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

// MARK: - Shared bits

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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
        color: AppTheme.hcMutedBrown,
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: AppTheme.hcTanRule),
    );
  }
}

class _BridgeArrow extends StatelessWidget {
  const _BridgeArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 4, top: 2, bottom: 2),
      child: Icon(Icons.arrow_downward, size: 12, color: AppTheme.hcTanRule),
    );
  }
}
