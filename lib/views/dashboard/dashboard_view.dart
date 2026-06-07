import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/market_data.dart';
import '../../models/weather_data.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  CurrentWeather? _currentWeather;
  MarketSummary? _marketSummary;
  bool _isLoadingWeather = true;
  bool _isLoadingMarket = true;
  String? _weatherError;
  String? _marketError;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([_loadWeather(), _loadMarket()]);
  }

  Future<void> _loadWeather() async {
    setState(() {
      _isLoadingWeather = true;
      _weatherError = null;
    });
    try {
      final locationService = ref.read(locationServiceProvider);
      final weatherService = ref.read(weatherServiceProvider);
      final position = locationService.currentPosition;
      final response = await weatherService.fetchWeather(
        latitude: position?.latitude ?? AppConstants.defaultLatitude,
        longitude: position?.longitude ?? AppConstants.defaultLongitude,
      );
      setState(() {
        _currentWeather = response.current;
        _isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        _weatherError = e.toString();
        _isLoadingWeather = false;
      });
    }
  }

  Future<void> _loadMarket() async {
    setState(() {
      _isLoadingMarket = true;
      _marketError = null;
    });
    try {
      final marketService = ref.read(marketServiceProvider);
      final summary = await marketService.fetchMarketData(forceRefresh: true);
      setState(() {
        _marketSummary = summary;
        _isLoadingMarket = false;
      });
    } catch (e) {
      setState(() {
        _marketError = e.toString();
        _isLoadingMarket = false;
      });
    }
  }

  double? get _windChill {
    final weather = _currentWeather;
    if (weather == null) return null;
    return ref
        .read(weatherServiceProvider)
        .calculateWindChill(weather.temperature2m, weather.windSpeed10m);
  }

  @override
  Widget build(BuildContext context) {
    final herdStats = ref.watch(herdStatsProvider);
    final locationService = ref.read(locationServiceProvider);
    final settings = ref.watch(settingsProvider);
    final ranchName = settings.valueOrNull?.ranchName ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              stretch: true,
              backgroundColor: AppTheme.darkBrown,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () => context.push('/settings'),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: _HeroBanner(
                  ranchName: ranchName.isNotEmpty ? ranchName : 'Honest Cattle',
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  _buildLocationPill(locationService.locationName),
                  const SizedBox(height: 16),
                  _buildWeatherSection(),
                  const SizedBox(height: 16),
                  _buildMarketSection(context),
                  const SizedBox(height: 16),
                  _buildQuickActionsSection(context),
                  const SizedBox(height: 16),
                  _buildHerdSummarySection(context, herdStats),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPill(String locationName) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: AppTheme.earthGreen, size: 16),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            locationName.isNotEmpty ? locationName : 'Locating…',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherSection() {
    if (_isLoadingWeather) {
      return const LoadingCard(title: 'Loading weather...');
    }
    if (_weatherError != null) {
      return ErrorCard(message: _weatherError!, onRetry: _loadWeather);
    }
    final weather = _currentWeather;
    if (weather == null) return const SizedBox.shrink();

    final wc = _windChill;

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temperature2m.round()}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        '°F',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                if (wc != null)
                  Text(
                    'Feels like ${wc.round()}°F',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  WeatherCode.description(weather.weatherCode),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                WeatherCode.icon(weather.weatherCode),
                size: 44,
                color: AppTheme.earthGreen,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.air, size: 13, color: Colors.grey),
                  const SizedBox(width: 3),
                  Text(
                    '${weather.windSpeed10m.round()} mph',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              if (weather.precipitation > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.water_drop, size: 13, color: Colors.blue),
                    const SizedBox(width: 3),
                    Text(
                      '${weather.precipitation.toStringAsFixed(2)}"',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Market Prices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.go('/market'),
              child: Text(
                'See All',
                style: TextStyle(fontSize: 12, color: AppTheme.earthGreen),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isLoadingMarket)
          const LoadingCard(title: 'Loading prices...')
        else if (_marketError != null)
          ErrorCard(message: _marketError!, onRetry: _loadMarket)
        else
          Row(
            children: [
              if (_marketSummary?.feederCattle != null)
                Expanded(
                  child: _PriceCard(
                    title: 'Feeder Cattle',
                    price: _marketSummary!.feederCattle!.formattedPrice,
                    change:
                        '${_marketSummary!.feederCattle!.formattedChange} (${_marketSummary!.feederCattle!.formattedChangePercent})',
                    isPositive: _marketSummary!.feederCattle!.isPositive,
                  ),
                ),
              if (_marketSummary?.feederCattle != null &&
                  _marketSummary?.liveCattle != null)
                const SizedBox(width: 12),
              if (_marketSummary?.liveCattle != null)
                Expanded(
                  child: _PriceCard(
                    title: 'Live Cattle',
                    price: _marketSummary!.liveCattle!.formattedPrice,
                    change:
                        '${_marketSummary!.liveCattle!.formattedChange} (${_marketSummary!.liveCattle!.formattedChangePercent})',
                    isPositive: _marketSummary!.liveCattle!.isPositive,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                label: 'Add Animal',
                icon: Icons.add_circle,
                color: AppTheme.earthGreen,
                onTap: () => context.push('/animal/new'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                label: 'Calculator',
                icon: Icons.calculate,
                color: AppTheme.warmBrown,
                onTap: () => context.go('/tools'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                label: 'Check Market',
                icon: Icons.trending_up,
                color: Colors.blue,
                onTap: () => context.go('/market'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHerdSummarySection(
    BuildContext context,
    AsyncValue<HerdStats> stats,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Herd Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.go('/herd'),
              child: Text(
                'View All',
                style: TextStyle(fontSize: 12, color: AppTheme.earthGreen),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        stats.when(
          data: (value) => Row(
            children: [
              Expanded(
                child: _SummaryStatCard(
                  title: 'Total',
                  value: value.total.toString(),
                  icon: Icons.pets,
                  color: AppTheme.earthGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryStatCard(
                  title: 'Active',
                  value: value.active.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryStatCard(
                  title: 'Withdrawal',
                  value: value.withActiveWithdrawal.toString(),
                  icon: Icons.access_time,
                  color: value.withActiveWithdrawal > 0
                      ? AppTheme.alertOrange
                      : Colors.grey,
                ),
              ),
            ],
          ),
          loading: () => const LoadingCard(title: 'Loading herd stats...'),
          error: (e, _) => ErrorCard(message: e.toString()),
        ),
      ],
    );
  }

}

class _PriceCard extends StatelessWidget {
  final String title;
  final String price;
  final String change;
  final bool isPositive;

  const _PriceCard({
    required this.title,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 3),
          Text(
            change,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isPositive ? Colors.green : AppTheme.errorRed,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SummaryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// Hero banner matching iOS DashboardView.heroBanner():
// grayscale image, contrast boost, dark gradient overlay, title text bottom-left
class _HeroBanner extends StatelessWidget {
  final String ranchName;

  const _HeroBanner({required this.ranchName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        // Grayscale + contrast image (matches iOS .saturation(0).contrast(1.1))
        ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0,      0,      0,      1, 0,
          ]),
          child: Image.asset(
            'assets/hero_banner.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // Dark gradient overlay (.clear → .black.opacity(0.55), center → bottom)
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0x8C000000)],
            ),
          ),
        ),
        // Title text bottom-left
        Positioned(
          left: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ranchName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Market Intelligence for Ranchers',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE5FFFFFF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
