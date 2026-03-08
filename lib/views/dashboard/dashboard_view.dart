import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/weather_data.dart';
import '../../models/market_data.dart';
import '../../services/sync_service.dart';

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
    await Future.wait([
      _loadWeather(),
      _loadMarket(),
    ]);
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
      final lat = position?.latitude ?? AppConstants.defaultLatitude;
      final lon = position?.longitude ?? AppConstants.defaultLongitude;

      final response = await weatherService.fetchWeather(
        latitude: lat,
        longitude: lon,
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
      final summary = await marketService.fetchMarketData();

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
    if (_currentWeather == null) return null;
    final weatherService = ref.read(weatherServiceProvider);
    return weatherService.calculateWindChill(
      _currentWeather!.temperature2m,
      _currentWeather!.windSpeed10m,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsProvider);
    final herdStatsAsync = ref.watch(herdStatsProvider);
    final locationService = ref.read(locationServiceProvider);
    final syncStatus = ref.watch(syncStatusProvider);

    final ranchName = settingsAsync.valueOrNull?.ranchName ?? 'HonestCattle';

    return Scaffold(
      appBar: AppBar(
        title: Text(ranchName),
        actions: [
          // Sync status indicator
          syncStatus.when(
            data: (status) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                status == ConnectionStatus.online
                    ? Icons.cloud_done
                    : Icons.cloud_off,
                color: status == ConnectionStatus.online
                    ? AppTheme.earthGreen
                    : Colors.orange,
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: AppTheme.earthGreen,
            onPressed: () => context.push('/settings'),
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
              // Location
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: AppTheme.earthGreen),
                  const SizedBox(width: 4),
                  Text(
                    locationService.locationName.isNotEmpty
                        ? locationService.locationName
                        : 'Loading location...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Weather section
              _buildWeatherSection(),
              const SizedBox(height: 16),

              // Market section
              _buildMarketSection(),
              const SizedBox(height: 16),

              // Quick actions
              const SectionHeader(title: 'Quick Actions'),
              Row(
                children: [
                  LargeTapButton(
                    title: 'Add Animal',
                    icon: Icons.add_circle,
                    color: AppTheme.earthGreen,
                    onTap: () => context.push('/animal/new'),
                  ),
                  const SizedBox(width: 12),
                  LargeTapButton(
                    title: 'Scan Tag',
                    icon: Icons.qr_code_scanner,
                    color: AppTheme.warmBrown,
                    onTap: () => context.push('/scanner'),
                  ),
                  const SizedBox(width: 12),
                  LargeTapButton(
                    title: 'Chute Side',
                    icon: Icons.flash_on,
                    color: Colors.blue,
                    onTap: () => context.push('/chute-side'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Herd summary
              const SectionHeader(
                title: 'Herd Summary',
                actionText: 'View All',
              ),
              herdStatsAsync.when(
                data: (stats) => Row(
                  children: [
                    Expanded(
                      child: SummaryStatView(
                        title: 'Total',
                        value: stats.total.toString(),
                        icon: Icons.pets,
                        color: AppTheme.earthGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryStatView(
                        title: 'Active',
                        value: stats.active.toString(),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryStatView(
                        title: 'Withdrawal',
                        value: stats.withActiveWithdrawal.toString(),
                        icon: Icons.schedule,
                        color: stats.withActiveWithdrawal > 0
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                loading: () => const LoadingCard(title: 'Loading herd stats...'),
                error: (e, _) => ErrorCard(message: e.toString()),
              ),
              const SizedBox(height: 16),

              // Quick links
              Row(
                children: [
                  Expanded(
                    child: _QuickLinkCard(
                      title: 'Tasks',
                      icon: Icons.task_alt,
                      color: Colors.purple,
                      onTap: () => context.push('/tasks'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickLinkCard(
                      title: 'Pastures',
                      icon: Icons.map,
                      color: AppTheme.earthGreen,
                      onTap: () => context.push('/pastures'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickLinkCard(
                      title: 'Analytics',
                      icon: Icons.analytics,
                      color: Colors.blue,
                      onTap: () => context.push('/analytics'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherSection() {
    if (_isLoadingWeather) {
      return const LoadingCard(title: 'Loading weather...');
    }

    if (_weatherError != null) {
      return ErrorCard(
        message: _weatherError!,
        onRetry: _loadWeather,
      );
    }

    if (_currentWeather == null) {
      return const SizedBox.shrink();
    }

    final weather = _currentWeather!;

    return AppCard(
      child: Row(
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '°F',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (_windChill != null) ...[
                  Text(
                    'Feels like ${_windChill!.round()}°F',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                ],
                Text(
                  WeatherCode.description(weather.weatherCode),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
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
                children: [
                  const Icon(Icons.air, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${weather.windSpeed10m.round()} mph',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              if (weather.precipitation > 0) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.water_drop, size: 14, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${weather.precipitation.toStringAsFixed(2)}"',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Market Prices',
          actionText: 'See All',
          onActionTap: () => context.push('/market'),
        ),
        if (_isLoadingMarket)
          const LoadingCard(title: 'Loading prices...')
        else if (_marketError != null)
          ErrorCard(message: _marketError!, onRetry: _loadMarket)
        else if (_marketSummary != null)
          Row(
            children: [
              if (_marketSummary!.feederCattle != null)
                PriceCard(
                  title: 'Feeder Cattle',
                  price: _marketSummary!.feederCattle!.formattedPrice,
                  change:
                      '${_marketSummary!.feederCattle!.formattedChange} (${_marketSummary!.feederCattle!.formattedChangePercent})',
                  isPositive: _marketSummary!.feederCattle!.isPositive,
                ),
              const SizedBox(width: 12),
              if (_marketSummary!.liveCattle != null)
                PriceCard(
                  title: 'Live Cattle',
                  price: _marketSummary!.liveCattle!.formattedPrice,
                  change:
                      '${_marketSummary!.liveCattle!.formattedChange} (${_marketSummary!.liveCattle!.formattedChangePercent})',
                  isPositive: _marketSummary!.liveCattle!.isPositive,
                ),
            ],
          ),
      ],
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickLinkCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
