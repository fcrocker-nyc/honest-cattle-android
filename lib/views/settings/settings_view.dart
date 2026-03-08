import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final _ranchNameController = TextEditingController();
  bool _notificationsEnabled = true;
  bool _priceAlertsEnabled = true;
  bool _weatherAlertsEnabled = true;
  bool _severeWeatherAlertsEnabled = true;
  bool _isLoading = true;
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
      // Create default settings
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

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved')),
      );
    }
  }

  @override
  void dispose() {
    _ranchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalsAsync = ref.watch(animalsProvider);
    final locationService = ref.read(locationServiceProvider);
    final syncPendingAsync = ref.watch(pendingSyncCountProvider);

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
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'Ranch',
            children: [
              ListTile(
                title: const Text('Ranch Name'),
                trailing: SizedBox(
                  width: 150,
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
            ],
          ),
          _buildSection(
            title: 'Location',
            subtitle:
                'Location is used for weather forecasts and nearby market information',
            children: [
              ListTile(
                title: const Text('Current Location'),
                subtitle: Text(
                  locationService.locationName.isNotEmpty
                      ? locationService.locationName
                      : _settings?.locationName ?? 'Not set',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.location_on, color: AppTheme.earthGreen),
                  onPressed: () async {
                    await locationService.getCurrentPosition();
                    setState(() {});
                  },
                ),
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
                onChanged: (val) {
                  setState(() => _notificationsEnabled = val);
                },
              ),
              if (_notificationsEnabled) ...[
                SwitchListTile(
                  title: const Text('Price Alerts'),
                  value: _priceAlertsEnabled,
                  activeColor: AppTheme.earthGreen,
                  onChanged: (val) {
                    setState(() => _priceAlertsEnabled = val);
                  },
                ),
                SwitchListTile(
                  title: const Text('Weather Alerts'),
                  value: _weatherAlertsEnabled,
                  activeColor: AppTheme.earthGreen,
                  onChanged: (val) {
                    setState(() => _weatherAlertsEnabled = val);
                  },
                ),
                SwitchListTile(
                  title: const Text('Severe Weather Alerts'),
                  value: _severeWeatherAlertsEnabled,
                  activeColor: AppTheme.earthGreen,
                  onChanged: (val) {
                    setState(() => _severeWeatherAlertsEnabled = val);
                  },
                ),
              ],
            ],
          ),
          _buildSection(
            title: 'Data',
            subtitle:
                'Export creates CSV files for animals, calving records, and treatment records',
            children: [
              ListTile(
                leading: const Icon(Icons.upload, color: AppTheme.earthGreen),
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
              syncPendingAsync.when(
                data: (count) => ListTile(
                  title: const Text('Pending Sync'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$count'),
                      const SizedBox(width: 8),
                      Icon(
                        count > 0 ? Icons.sync : Icons.cloud_done,
                        color: count > 0 ? Colors.orange : Colors.green,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                loading: () => const ListTile(
                  title: Text('Pending Sync'),
                  trailing: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (_, __) => const ListTile(
                  title: Text('Pending Sync'),
                  trailing: Text('-'),
                ),
              ),
            ],
          ),
          _buildSection(
            title: 'About',
            children: [
              const ListTile(
                title: Text('Version'),
                trailing: Text('1.0.0'),
              ),
              const ListTile(
                title: Text('Build'),
                trailing: Text('1'),
              ),
            ],
          ),
        ],
      ),
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
              fontSize: 14,
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
        const Divider(),
      ],
    );
  }

  Future<void> _exportData() async {
    // Show export dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export feature coming soon')),
    );
  }
}
