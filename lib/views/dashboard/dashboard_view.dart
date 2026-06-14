import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/weather_data.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import 'dashboard_cards.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  CurrentWeather? _currentWeather;
  WeatherResponse? _weatherResponse;
  bool _isLoadingWeather = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadWeather();
    // Refresh the published-data providers on pull-to-refresh.
    ref.invalidate(countyMoistureProvider);
    ref.invalidate(hcForecastProvider);
  }

  Future<void> _loadWeather() async {
    setState(() => _isLoadingWeather = true);
    try {
      final locationService = ref.read(locationServiceProvider);
      final weatherService = ref.read(weatherServiceProvider);
      final position = locationService.currentPosition;
      final response = await weatherService.fetchWeather(
        latitude: position?.latitude ?? AppConstants.defaultLatitude,
        longitude: position?.longitude ?? AppConstants.defaultLongitude,
      );
      if (!mounted) return;
      setState(() {
        _weatherResponse = response;
        _currentWeather = response.current;
        _isLoadingWeather = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingWeather = false);
    }
  }

  double? get _windChill {
    final weather = _currentWeather;
    if (weather == null) return null;
    return ref
        .read(weatherServiceProvider)
        .calculateWindChill(weather.temperature2m, weather.windSpeed10m);
  }

  int? get _precipProb {
    final daily = _weatherResponse?.daily;
    if (daily == null || daily.precipitationProbabilityMax.isEmpty) return null;
    return daily.precipitationProbabilityMax.first;
  }

  @override
  Widget build(BuildContext context) {
    final ranchName = ref.watch(settingsProvider).valueOrNull?.ranchName ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => context.push('/settings'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/hc_logo.png',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  _settingsTip(),
                  const SizedBox(height: 20),
                  _weatherPill(),
                  const SizedBox(height: 20),
                  const CountyMoistureCard(),
                  _gap(ref.watch(ranchCountyProvider).trim().isNotEmpty),
                  const HcWeeklyForecastCard(),
                  const SizedBox(height: 20),
                  const QuarterlyForecastCard(),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // County card collapses to nothing when no county is set; only add spacing
  // below it when it is actually showing.
  Widget _gap(bool show) => show ? const SizedBox(height: 20) : const SizedBox.shrink();

  // MARK: - Settings tip pill

  Widget _settingsTip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.earthGreen.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppTheme.earthGreen.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset('assets/hc_logo.png',
                width: 28, height: 28, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.earthGreen)),
                SizedBox(height: 1),
                Text(
                  'Tap the HC logo (top right) to set your ranch name, location & preferences.',
                  style: TextStyle(fontSize: 12, color: AppTheme.hcInk),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - Ranch weather pill

  Widget _weatherPill() {
    if (_isLoadingWeather && _currentWeather == null) {
      return _pillContainer(
        const SizedBox(
          height: 60,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
    }
    final w = _currentWeather;
    if (w == null) return const SizedBox.shrink();

    final wc = _windChill;
    final precip = _precipProb;
    final wcColor = wc == null
        ? AppTheme.earthGreen
        : wc < 0
            ? AppTheme.errorRed
            : wc < 20
                ? Colors.orange
                : AppTheme.earthGreen;

    return _pillContainer(
      Row(
        children: [
          _stat(Icons.thermostat, 'Ranch Temp', '${w.temperature2m.round()}°F',
              AppTheme.earthGreen),
          _divider(),
          _stat(Icons.water_drop, 'Precip 24hr',
              precip != null ? '$precip%' : '—', AppTheme.skyBlue),
          _divider(),
          _stat(Icons.air, 'Wind Chill', wc != null ? '${wc.round()}°F' : '—',
              wcColor),
        ],
      ),
    );
  }

  Widget _pillContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.earthGreen.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.earthGreen.withValues(alpha: 0.2)),
      ),
      child: child,
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 44,
        color: AppTheme.earthGreen.withValues(alpha: 0.15),
      );

  Widget _stat(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 5),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.hcInk)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.hcMutedBrown)),
        ],
      ),
    );
  }
}

// MARK: - Hero banner (matches iOS DashboardView.heroBanner)

class _HeroBanner extends StatelessWidget {
  final String ranchName;

  const _HeroBanner({required this.ranchName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(
          'assets/hero_banner.jpg',
          fit: BoxFit.cover,
          color: Colors.grey,
          colorBlendMode: BlendMode.saturation,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0x8C000000)],
            ),
          ),
        ),
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
                  shadows: [
                    Shadow(color: Color(0x66000000), blurRadius: 4, offset: Offset(0, 2)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Market Intelligence for Ranchers',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE5FFFFFF),
                  shadows: [
                    Shadow(color: Color(0x66000000), blurRadius: 2, offset: Offset(0, 1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
