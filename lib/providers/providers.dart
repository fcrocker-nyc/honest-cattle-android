import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/database.dart';
import '../services/weather_service.dart';
import '../services/market_service.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';
import '../services/sync_service.dart';
import '../services/ble_service.dart';
import '../services/hc_data_service.dart';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Service providers
final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

final marketServiceProvider = Provider<MarketService>((ref) {
  return MarketService();
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db);
});

final bleServiceProvider = Provider<BleService>((ref) {
  return BleService();
});

// Settings provider
final settingsProvider = FutureProvider<RanchSetting?>((ref) async {
  final db = ref.watch(databaseProvider);
  final settings = await db.select(db.ranchSettings).getSingleOrNull();
  return settings;
});

// HC published-data service (county moisture + calf-price forecast)
final hcDataServiceProvider = Provider<HcDataService>((ref) => HcDataService());

// Ranch county (stored in shared_preferences, matching iOS @AppStorage).
// Bump this notifier after writing the pref to refresh dependents.
final ranchCountyProvider =
    NotifierProvider<RanchCountyNotifier, String>(RanchCountyNotifier.new);

class RanchCountyNotifier extends Notifier<String> {
  @override
  String build() {
    _load();
    return '';
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('ranchCounty') ?? '';
  }

  Future<void> set(String county) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ranchCounty', county);
    state = county;
  }
}

// County moisture for the configured ranch county (null when none set).
final countyMoistureProvider = FutureProvider<CountyMoisture?>((ref) async {
  final county = ref.watch(ranchCountyProvider);
  if (county.trim().isEmpty) return null;
  return ref.watch(hcDataServiceProvider).fetchCountyMoisture(county);
});

// Weekly / quarterly calf-price forecast.
final hcForecastProvider = FutureProvider<HcForecast?>((ref) async {
  return ref.watch(hcDataServiceProvider).fetchForecast();
});

// Animals providers
final animalsProvider = StreamProvider<List<Animal>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.animals).watch();
});

final animalByIdProvider = FutureProvider.family<Animal?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return await (db.select(db.animals)..where((t) => t.id.equals(id))).getSingleOrNull();
});

final activeAnimalsProvider = StreamProvider<List<Animal>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.animals)
        ..where((t) => t.status.equals(AnimalStatus.active.name)))
      .watch();
});

// Treatment records provider
final treatmentRecordsProvider = StreamProvider.family<List<TreatmentRecord>, String>((ref, animalId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.treatmentRecords)
        ..where((t) => t.animalId.equals(animalId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .watch();
});

// Calving records provider
final calvingRecordsProvider = StreamProvider.family<List<CalvingRecord>, String>((ref, animalId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.calvingRecords)
        ..where((t) => t.animalId.equals(animalId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .watch();
});

// Weight records provider
final weightRecordsProvider = StreamProvider.family<List<WeightRecord>, String>((ref, animalId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.weightRecords)
        ..where((t) => t.animalId.equals(animalId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .watch();
});

// Tasks providers
final tasksProvider = StreamProvider<List<Task>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.tasks).watch();
});

final pendingTasksProvider = StreamProvider<List<Task>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.tasks)
        ..where((t) => t.taskStatus.isNotIn([TaskStatus.completed.name, TaskStatus.cancelled.name]))
        ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
      .watch();
});

// Pastures provider
final pasturesProvider = StreamProvider<List<Pasture>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.pastures).watch();
});

// Grazing rotations provider
final grazingRotationsProvider = StreamProvider<List<GrazingRotation>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.grazingRotations)
        ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
      .watch();
});

// Expenses provider
final expensesProvider = StreamProvider<List<Expense>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.expenses)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .watch();
});

// Sales provider
final salesProvider = StreamProvider<List<Sale>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.sales)
        ..orderBy([(t) => OrderingTerm.desc(t.saleDate)]))
      .watch();
});

// Price alerts provider
final priceAlertsProvider = StreamProvider<List<PriceAlert>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.priceAlerts).watch();
});

// Smart tag readings provider
final smartTagReadingsProvider = StreamProvider.family<List<SmartTagReading>, String>((ref, animalId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.smartTagReadings)
        ..where((t) => t.animalId.equals(animalId))
        ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
        ..limit(100))
      .watch();
});

// Health alerts provider
final healthAlertsProvider = StreamProvider<List<HealthAlert>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.healthAlerts)
        ..where((t) => t.isResolved.equals(false))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
});

// Predictive alerts provider
final predictiveAlertsProvider = StreamProvider<List<PredictiveAlert>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.predictiveAlerts)
        ..where((t) => t.isAcknowledged.equals(false))
        ..orderBy([(t) => OrderingTerm.asc(t.predictedDate)]))
      .watch();
});

// Sync status provider
final syncStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.syncStatusStream;
});

// Returns the set of animal IDs that currently have an active withdrawal period.
// Used by the herd list to show the orange clock icon next to the tag.
final withdrawalAnimalIdsProvider = FutureProvider<Set<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();
  final treatments = await db.select(db.treatmentRecords).get();
  return treatments
      .where((t) =>
          t.withdrawalDate != null && t.withdrawalDate!.isAfter(now))
      .map((t) => t.animalId)
      .toSet();
});

final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  final syncService = ref.watch(syncServiceProvider);
  return await syncService.getPendingChangesCount();
});

// Statistics providers
final herdStatsProvider = FutureProvider<HerdStats>((ref) async {
  final db = ref.watch(databaseProvider);
  final animals = await db.select(db.animals).get();

  int active = 0;
  int sold = 0;
  int deceased = 0;
  int breeding = 0;
  int calving = 0;
  int withWithdrawal = 0;

  final now = DateTime.now();

  for (final animal in animals) {
    switch (animal.status) {
      case AnimalStatus.active:
        active++;
        break;
      case AnimalStatus.sold:
        sold++;
        break;
      case AnimalStatus.deceased:
      case AnimalStatus.culled:
        deceased++;
        break;
      case AnimalStatus.breeding:
        breeding++;
        break;
      case AnimalStatus.calving:
        calving++;
        break;
    }

    // Check withdrawal
    final treatments = await (db.select(db.treatmentRecords)
          ..where((t) => t.animalId.equals(animal.id)))
        .get();

    for (final treatment in treatments) {
      if (treatment.withdrawalDate != null &&
          treatment.withdrawalDate!.isAfter(now)) {
        withWithdrawal++;
        break;
      }
    }
  }

  return HerdStats(
    total: animals.length,
    active: active,
    sold: sold,
    deceased: deceased,
    breeding: breeding,
    calving: calving,
    withActiveWithdrawal: withWithdrawal,
  );
});

class HerdStats {
  final int total;
  final int active;
  final int sold;
  final int deceased;
  final int breeding;
  final int calving;
  final int withActiveWithdrawal;

  HerdStats({
    required this.total,
    required this.active,
    required this.sold,
    required this.deceased,
    required this.breeding,
    required this.calving,
    required this.withActiveWithdrawal,
  });
}
