import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

// Quick-select location presets matching iOS SettingsView
class _LocationPreset {
  final String name;
  final double latitude;
  final double longitude;
  const _LocationPreset(this.name, this.latitude, this.longitude);
}

const _locationPresets = [
  _LocationPreset('Billings, MT', 45.7833, -108.5007),
  _LocationPreset('Great Falls, MT', 47.4942, -111.2833),
  _LocationPreset('Helena, MT', 46.5958, -112.0270),
  _LocationPreset('Missoula, MT', 46.8721, -113.9940),
  _LocationPreset('Bozeman, MT', 45.6770, -111.0429),
  _LocationPreset('Miles City, MT', 46.4083, -105.8406),
];

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final _ranchNameController = TextEditingController();
  final _countyController = TextEditingController();
  bool _notificationsEnabled = true;
  bool _priceAlertsEnabled = true;
  bool _weatherAlertsEnabled = true;
  bool _severeWeatherAlertsEnabled = true;
  bool _isLoading = true;
  bool _showLocationPicker = false;
  RanchSetting? _settings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = ref.read(databaseProvider);
    var settings = await db.ranchSettings.select().getSingleOrNull();

    if (settings == null) {
      final now = DateTime.now();
      await db.into(db.ranchSettings).insert(RanchSettingsCompanion.insert(
            id: const Uuid().v4(),
            createdAt: now,
            updatedAt: now,
          ));
      settings = await db.ranchSettings.select().getSingle();
    }

    setState(() {
      _settings = settings;
      _ranchNameController.text = settings!.ranchName;
      _countyController.text = ref.read(ranchCountyProvider);
      _notificationsEnabled = settings.notificationsEnabled;
      _priceAlertsEnabled = settings.priceAlertsEnabled;
      _weatherAlertsEnabled = settings.weatherAlertsEnabled;
      _severeWeatherAlertsEnabled = settings.severeWeatherAlertsEnabled;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.ranchSettings)
          ..where((t) => t.id.equals(_settings!.id)))
        .write(RanchSettingsCompanion(
      ranchName: Value(_ranchNameController.text),
      notificationsEnabled: Value(_notificationsEnabled),
      priceAlertsEnabled: Value(_priceAlertsEnabled),
      weatherAlertsEnabled: Value(_weatherAlertsEnabled),
      severeWeatherAlertsEnabled: Value(_severeWeatherAlertsEnabled),
      updatedAt: Value(DateTime.now()),
    ));
    // County drives the dashboard moisture card; stored in prefs (matches iOS
    // @AppStorage("ranchCounty")). Strip a trailing " County" for the HC
    // data-file naming convention.
    final county = _countyController.text
        .trim()
        .replaceAll(RegExp(r'\s+[Cc]ounty$'), '');
    await ref.read(ranchCountyProvider.notifier).set(county);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved')),
      );
    }
  }

  Future<void> _applyLocationPreset(_LocationPreset preset) async {
    if (_settings == null) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.ranchSettings)
          ..where((t) => t.id.equals(_settings!.id)))
        .write(RanchSettingsCompanion(
      locationName: Value(preset.name),
      locationLatitude: Value(preset.latitude),
      locationLongitude: Value(preset.longitude),
      updatedAt: Value(DateTime.now()),
    ));
    final updated = await db.ranchSettings.select().getSingleOrNull();
    setState(() {
      _settings = updated;
      _showLocationPicker = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location set to ${preset.name}')),
      );
    }
  }

  Future<void> _exportData() async {
    final animalsAsync = ref.read(animalsProvider);
    final count = animalsAsync.valueOrNull?.length ?? 0;
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Data'),
        content: Text(
          'Exports $count animal records as CSV. '
          'Share functionality requires the app to be built for device distribution.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ranchNameController.dispose();
    _countyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalsAsync = ref.watch(animalsProvider);
    final locationService = ref.read(locationServiceProvider);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: _showLocationPicker
          ? _buildLocationPicker()
          : ListView(
              children: [
                _buildSection(
                  title: 'Ranch',
                  subtitle:
                      'County drives the moisture, drought & streamflow card on the dashboard',
                  children: [
                    ListTile(
                      title: const Text('Ranch Name'),
                      trailing: SizedBox(
                        width: 160,
                        child: TextField(
                          controller: _ranchNameController,
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'My Ranch',
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('County'),
                      trailing: SizedBox(
                        width: 160,
                        child: TextField(
                          controller: _countyController,
                          textAlign: TextAlign.end,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Park',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildSection(
                  title: 'Location',
                  subtitle:
                      'Used for weather forecasts and nearby market data',
                  children: [
                    ListTile(
                      title: const Text('Current Location'),
                      subtitle: Text(
                        locationService.locationName.isNotEmpty
                            ? locationService.locationName
                            : _settings?.locationName ?? 'Not set',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () =>
                          setState(() => _showLocationPicker = true),
                    ),
                    ListTile(
                      leading: const Icon(Icons.my_location,
                          color: AppTheme.earthGreen),
                      title: const Text('Use GPS Location'),
                      onTap: () async {
                        await locationService.getCurrentPosition();
                        setState(() {});
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('GPS location updated')),
                          );
                        }
                      },
                    ),
                  ],
                ),
                _buildSection(
                  title: 'Notifications',
                  children: [
                    SwitchListTile(
                      title: const Text('Enable Notifications'),
                      value: _notificationsEnabled,
                      activeColor: AppTheme.earthGreen,
                      onChanged: (val) =>
                          setState(() => _notificationsEnabled = val),
                    ),
                    if (_notificationsEnabled) ...[
                      SwitchListTile(
                        title: const Text('Price Alerts'),
                        value: _priceAlertsEnabled,
                        activeColor: AppTheme.earthGreen,
                        onChanged: (val) =>
                            setState(() => _priceAlertsEnabled = val),
                      ),
                      SwitchListTile(
                        title: const Text('Weather Alerts'),
                        value: _weatherAlertsEnabled,
                        activeColor: AppTheme.earthGreen,
                        onChanged: (val) =>
                            setState(() => _weatherAlertsEnabled = val),
                      ),
                      SwitchListTile(
                        title: const Text('Severe Weather'),
                        value: _severeWeatherAlertsEnabled,
                        activeColor: AppTheme.earthGreen,
                        onChanged: (val) =>
                            setState(() => _severeWeatherAlertsEnabled = val),
                      ),
                    ],
                  ],
                ),
                _buildSection(
                  title: 'Data',
                  subtitle:
                      'Export creates CSV files for animals, calving records, and treatments',
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.upload, color: AppTheme.earthGreen),
                      title: const Text('Export Data (CSV)'),
                      onTap: _exportData,
                    ),
                    animalsAsync.when(
                      data: (animals) => ListTile(
                        title: const Text('Total Animals'),
                        trailing: Text('${animals.length}'),
                      ),
                      loading: () => const ListTile(
                        title: Text('Total Animals'),
                        trailing: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      error: (_, __) => const ListTile(
                        title: Text('Total Animals'),
                        trailing: Text('-'),
                      ),
                    ),
                  ],
                ),
                _buildSection(
                  title: 'About',
                  children: const [
                    ListTile(
                      title: Text('Version'),
                      trailing: Text('2.0.0'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildLocationPicker() {
    final currentName = _settings?.locationName ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with back
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _showLocationPicker = false),
              ),
              const Text(
                'Select Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        if (currentName.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: AppTheme.earthGreen),
                const SizedBox(width: 4),
                Text(
                  currentName,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            'Quick Select',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.earthGreen,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (final preset in _locationPresets)
                ListTile(
                  leading: const Icon(Icons.location_on,
                      color: AppTheme.earthGreen),
                  title: Text(preset.name),
                  trailing: currentName == preset.name
                      ? const Icon(Icons.check,
                          color: AppTheme.earthGreen)
                      : null,
                  onTap: () => _applyLocationPreset(preset),
                ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.my_location,
                    color: AppTheme.earthGreen),
                title: const Text('Use GPS Location'),
                onTap: () async {
                  final locationService =
                      ref.read(locationServiceProvider);
                  await locationService.getCurrentPosition();
                  setState(() => _showLocationPicker = false);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('GPS location updated')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    String? subtitle,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.earthGreen,
            ),
          ),
        ),
        ...children,
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        const Divider(height: 1),
        const SizedBox(height: 8),
      ],
    );
  }
}
