import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/weather_data.dart';
import '../../services/location_service.dart';

class WeatherView extends ConsumerStatefulWidget {
  const WeatherView({super.key});

  @override
  ConsumerState<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends ConsumerState<WeatherView> {
  WeatherResponse? _weatherResponse;
  List<DayForecast> _forecasts = [];
  bool _isLoading = true;
  String? _error;
  bool _showWindChillCalculator = false;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final locationService = ref.read(locationServiceProvider);
      final weatherService = ref.read(weatherServiceProvider);

      final position = locationService.currentPosition;
      final lat = position?.latitude ?? AppConstants.defaultLatitude;
      final lon = position?.longitude ?? AppConstants.defaultLongitude;

      final response =
          await weatherService.fetchWeather(latitude: lat, longitude: lon);
      final forecasts = weatherService.getDailyForecasts(response);

      setState(() {
        _weatherResponse = response;
        _forecasts = forecasts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  double? get _windChill {
    if (_weatherResponse?.current == null) return null;
    final weatherService = ref.read(weatherServiceProvider);
    return weatherService.calculateWindChill(
      _weatherResponse!.current!.temperature2m,
      _weatherResponse!.current!.windSpeed10m,
    );
  }

  String get _windDirection {
    if (_weatherResponse?.current == null) return '';
    final weatherService = ref.read(weatherServiceProvider);
    return weatherService
        .getWindDirection(_weatherResponse!.current!.windDirection10m);
  }

  bool get _hasSevereWeather {
    return _forecasts.any((f) => f.isSevere);
  }

  @override
  Widget build(BuildContext context) {
    final locationService = ref.read(locationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ac_unit, color: AppTheme.earthGreen),
            onPressed: () =>
                setState(() => _showWindChillCalculator = true),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadWeather,
        child: _showWindChillCalculator
            ? _buildWindChillCalculator()
            : _buildWeatherContent(locationService),
      ),
    );
  }

  Widget _buildWeatherContent(LocationService locationService) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: ErrorCard(message: _error!, onRetry: _loadWeather),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationSection(locationService),
          const SizedBox(height: 16),
          if (_weatherResponse?.current != null)
            _buildCurrentConditions(_weatherResponse!.current!),
          const SizedBox(height: 16),
          if (_hasSevereWeather) ...[
            _buildSevereWeatherSection(),
            const SizedBox(height: 16),
          ],
          _buildForecastSection(),
          const SizedBox(height: 16),
          _buildWindChillCard(),
        ],
      ),
    );
  }

  Widget _buildLocationSection(LocationService locationService) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppTheme.earthGreen),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              locationService.locationName.isNotEmpty
                  ? locationService.locationName
                  : 'Loading location...',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.earthGreen),
            onPressed: _loadWeather,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentConditions(CurrentWeather weather) {
    return AppCard(
      child: Column(
        children: [
          Row(
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
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '°F',
                          style: TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                      ],
                    ),
                    if (_windChill != null)
                      Row(
                        children: [
                          const Icon(Icons.ac_unit, size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            'Feels like ${_windChill!.round()}°F',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    Text(
                      WeatherCode.description(weather.weatherCode),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Icon(
                WeatherCode.icon(weather.weatherCode),
                size: 64,
                color: AppTheme.earthGreen,
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WeatherDetailItem(
                icon: Icons.air,
                value: '${weather.windSpeed10m.round()} mph',
                label: _windDirection,
              ),
              _WeatherDetailItem(
                icon: Icons.water_drop,
                value: '${weather.relativeHumidity2m}%',
                label: 'Humidity',
              ),
              _WeatherDetailItem(
                icon: Icons.speed,
                value: '${weather.windGusts10m.round()} mph',
                label: 'Gusts',
              ),
            ],
          ),
          if (weather.precipitation > 0)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  const Icon(Icons.water_drop, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Precipitation: ${weather.precipitation.toStringAsFixed(2)}"',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSevereWeatherSection() {
    final severeForecasts = _forecasts.where((f) => f.isSevere).toList();

    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                'Weather Alerts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...severeForecasts.map((day) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(day.date),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    if (day.maxWindGusts > 50)
                      Text(
                        '${day.maxWindGusts.round()} mph gusts',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    if (day.precipitationSum > 25)
                      Text(
                        '${day.precipitationSum.toStringAsFixed(1)}"',
                        style: const TextStyle(color: Colors.blue),
                      ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '7-Day Forecast'),
        AppCard(
          child: Column(
            children: _forecasts.asMap().entries.map((entry) {
              final isLast = entry.key == _forecasts.length - 1;
              return Column(
                children: [
                  _ForecastRow(forecast: entry.value),
                  if (!isLast) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWindChillCard() {
    return GestureDetector(
      onTap: () => setState(() => _showWindChillCalculator = true),
      child: AppCard(
        child: Row(
          children: [
            const Icon(Icons.ac_unit, size: 32, color: Colors.blue),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wind Chill Calculator',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Critical for calving season',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildWindChillCalculator() {
    return _WindChillCalculator(
      onClose: () => setState(() => _showWindChillCalculator = false),
    );
  }

  String _formatDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }
}

class _WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _WeatherDetailItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.earthGreen),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final DayForecast forecast;

  const _ForecastRow({required this.forecast});

  String get _weekday {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[forecast.date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              _weekday,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Icon(
            WeatherCode.icon(forecast.weatherCode),
            color: AppTheme.earthGreen,
          ),
          const SizedBox(width: 8),
          if (forecast.precipitationProbability > 0)
            SizedBox(
              width: 50,
              child: Row(
                children: [
                  const Icon(Icons.water_drop, size: 14, color: Colors.blue),
                  Text(
                    '${forecast.precipitationProbability}%',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            )
          else
            const SizedBox(width: 50),
          const Spacer(),
          Text(
            '${forecast.lowTemp.round()}°',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Container(
            width: 60,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: (forecast.highTemp - forecast.lowTemp) / 50,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(AppTheme.earthGreen),
              ),
            ),
          ),
          Text('${forecast.highTemp.round()}°'),
        ],
      ),
    );
  }
}

class _WindChillCalculator extends StatefulWidget {
  final VoidCallback onClose;

  const _WindChillCalculator({required this.onClose});

  @override
  State<_WindChillCalculator> createState() => _WindChillCalculatorState();
}

class _WindChillCalculatorState extends State<_WindChillCalculator> {
  double _temperature = 30;
  double _windSpeed = 15;

  double get _windChill {
    if (_temperature > 50 || _windSpeed <= 3) return _temperature;
    return 35.74 +
        (0.6215 * _temperature) -
        (35.75 * _pow(_windSpeed, 0.16)) +
        (0.4275 * _temperature * _pow(_windSpeed, 0.16));
  }

  double _pow(double base, double exp) {
    if (base <= 0) return 0;
    double result = 1;
    for (int i = 0; i < 10; i++) {
      result *= (1 + (exp / 10) * (_ln(base) / 10));
    }
    return result * result * result * result * result;
  }

  double _ln(double x) {
    if (x <= 0) return 0;
    double result = 0;
    while (x > 2) {
      x /= 2.718281828;
      result += 1;
    }
    return result + (x - 1) - (x - 1) * (x - 1) / 2;
  }

  String get _riskLevel {
    if (_windChill > 40) return 'Low Risk';
    if (_windChill > 20) return 'Moderate';
    if (_windChill > 0) return 'High Risk';
    if (_windChill > -20) return 'Very High';
    return 'Extreme';
  }

  Color get _riskColor {
    if (_windChill > 40) return Colors.green;
    if (_windChill > 20) return Colors.yellow[700]!;
    if (_windChill > 0) return Colors.orange;
    if (_windChill > -20) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onClose,
              ),
              const Text(
                'Wind Chill Calculator',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                Text(
                  '${_windChill.round()}°F',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Wind Chill'),
                const SizedBox(height: 12),
                StatusBadge(text: _riskLevel, color: _riskColor),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                SliderInputRow(
                  label: 'Temperature',
                  value: _temperature,
                  min: -40,
                  max: 50,
                  step: 1,
                  unit: '°F',
                  format: '%.0f',
                  onChanged: (val) => setState(() => _temperature = val),
                ),
                const SizedBox(height: 16),
                SliderInputRow(
                  label: 'Wind Speed',
                  value: _windSpeed,
                  min: 0,
                  max: 60,
                  step: 1,
                  unit: 'mph',
                  format: '%.0f',
                  onChanged: (val) => setState(() => _windSpeed = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cattle Cold Stress Guidelines',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _GuidelineRow('> 32°F', 'Normal - no action needed'),
                _GuidelineRow('20-32°F', 'Monitor, provide windbreaks'),
                _GuidelineRow('0-20°F', 'Increase feed 5-10%'),
                _GuidelineRow('-20-0°F', 'Increase feed 10-25%'),
                _GuidelineRow('< -20°F', 'Emergency shelter needed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuidelineRow extends StatelessWidget {
  final String range;
  final String action;

  const _GuidelineRow(this.range, this.action);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              range,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              action,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
