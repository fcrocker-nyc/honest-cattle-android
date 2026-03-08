import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Enums
enum AnimalSex {
  bull('Bull'),
  cow('Cow'),
  heifer('Heifer'),
  steer('Steer'),
  calf('Calf');

  final String label;
  const AnimalSex(this.label);
}

enum AnimalStatus {
  active('Active'),
  sold('Sold'),
  deceased('Deceased'),
  culled('Culled'),
  breeding('Breeding'),
  calving('Calving');

  final String label;
  const AnimalStatus(this.label);
}

enum TreatmentRoute {
  subcutaneous('Subcutaneous (SQ)'),
  intramuscular('Intramuscular (IM)'),
  intravenous('Intravenous (IV)'),
  oral('Oral'),
  topical('Topical'),
  intranasal('Intranasal');

  final String label;
  const TreatmentRoute(this.label);
}

enum PriceAlertType {
  feederCattle('Feeder Cattle'),
  liveCattle('Live Cattle'),
  auctionPrice('Auction Price');

  final String label;
  const PriceAlertType(this.label);
}

enum TaskPriority {
  low('Low'),
  medium('Medium'),
  high('High'),
  urgent('Urgent');

  final String label;
  const TaskPriority(this.label);
}

enum TaskStatus {
  pending('Pending'),
  inProgress('In Progress'),
  completed('Completed'),
  cancelled('Cancelled');

  final String label;
  const TaskStatus(this.label);
}

enum ExpenseCategory {
  feed('Feed'),
  veterinary('Veterinary'),
  purchase('Purchase'),
  equipment('Equipment'),
  labor('Labor'),
  transportation('Transportation'),
  other('Other');

  final String label;
  const ExpenseCategory(this.label);
}

enum SyncStatus {
  synced,
  pending,
  failed,
}

// Type converters
class AnimalSexConverter extends TypeConverter<AnimalSex, String> {
  const AnimalSexConverter();

  @override
  AnimalSex fromSql(String fromDb) => AnimalSex.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(AnimalSex value) => value.name;
}

class AnimalStatusConverter extends TypeConverter<AnimalStatus, String> {
  const AnimalStatusConverter();

  @override
  AnimalStatus fromSql(String fromDb) => AnimalStatus.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(AnimalStatus value) => value.name;
}

class TreatmentRouteConverter extends TypeConverter<TreatmentRoute, String> {
  const TreatmentRouteConverter();

  @override
  TreatmentRoute fromSql(String fromDb) => TreatmentRoute.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(TreatmentRoute value) => value.name;
}

class PriceAlertTypeConverter extends TypeConverter<PriceAlertType, String> {
  const PriceAlertTypeConverter();

  @override
  PriceAlertType fromSql(String fromDb) => PriceAlertType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(PriceAlertType value) => value.name;
}

class TaskPriorityConverter extends TypeConverter<TaskPriority, String> {
  const TaskPriorityConverter();

  @override
  TaskPriority fromSql(String fromDb) => TaskPriority.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(TaskPriority value) => value.name;
}

class TaskStatusConverter extends TypeConverter<TaskStatus, String> {
  const TaskStatusConverter();

  @override
  TaskStatus fromSql(String fromDb) => TaskStatus.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(TaskStatus value) => value.name;
}

class ExpenseCategoryConverter extends TypeConverter<ExpenseCategory, String> {
  const ExpenseCategoryConverter();

  @override
  ExpenseCategory fromSql(String fromDb) => ExpenseCategory.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(ExpenseCategory value) => value.name;
}

class SyncStatusConverter extends TypeConverter<SyncStatus, String> {
  const SyncStatusConverter();

  @override
  SyncStatus fromSql(String fromDb) => SyncStatus.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(SyncStatus value) => value.name;
}

// Tables
class Animals extends Table {
  TextColumn get id => text()();
  TextColumn get tagNumber => text()();
  TextColumn get breed => text().withDefault(const Constant(''))();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get sex => text().map(const AnimalSexConverter())();
  TextColumn get status => text().map(const AnimalStatusConverter())();
  TextColumn get sireTag => text().nullable()();
  TextColumn get damTag => text().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  RealColumn get purchaseWeight => real().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  TextColumn get rfidTag => text().nullable()();
  TextColumn get smartTagId => text().nullable()();
  TextColumn get currentPastureId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class CalvingRecords extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get calfTag => text()();
  TextColumn get calfSex => text().map(const AnimalSexConverter())();
  RealColumn get birthWeight => real().nullable()();
  IntColumn get calvingEaseScore => integer().withDefault(const Constant(1))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class TreatmentRecords extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get treatment => text()();
  TextColumn get dosage => text().withDefault(const Constant(''))();
  TextColumn get route => text().map(const TreatmentRouteConverter())();
  TextColumn get reason => text().withDefault(const Constant(''))();
  IntColumn get withdrawalDays => integer().withDefault(const Constant(0))();
  DateTimeColumn get withdrawalDate => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class WeightRecords extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class PriceAlerts extends Table {
  TextColumn get id => text()();
  TextColumn get alertType => text().map(const PriceAlertTypeConverter())();
  TextColumn get weightClass => text()();
  RealColumn get targetPrice => real()();
  BoolColumn get isAboveTarget => boolean().withDefault(const Constant(true))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastTriggered => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class RanchSettings extends Table {
  TextColumn get id => text()();
  TextColumn get ranchName => text().withDefault(const Constant('My Ranch'))();
  RealColumn get locationLatitude => real().nullable()();
  RealColumn get locationLongitude => real().nullable()();
  TextColumn get locationName => text().withDefault(const Constant(''))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get priceAlertsEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get weatherAlertsEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get severeWeatherAlertsEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Pastures extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get boundaryJson => text()();  // GeoJSON polygon
  RealColumn get acreage => real().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class GrazingRotations extends Table {
  TextColumn get id => text()();
  TextColumn get pastureId => text().references(Pastures, #id)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get animalIds => text()();  // Comma-separated animal IDs
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class SmartTagReadings extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get temperature => real().nullable()();
  RealColumn get activityLevel => real().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  IntColumn get batteryLevel => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class HealthAlerts extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  TextColumn get alertType => text()();
  TextColumn get message => text()();
  BoolColumn get isResolved => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get assignee => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get priority => text().map(const TaskPriorityConverter())();
  TextColumn get taskStatus => text().map(const TaskStatusConverter())();
  TextColumn get relatedAnimalId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get category => text().map(const ExpenseCategoryConverter())();
  RealColumn get amount => real()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get date => dateTime()();
  TextColumn get animalId => text().nullable()();
  TextColumn get pastureId => text().nullable()();
  TextColumn get vendor => text().withDefault(const Constant(''))();
  TextColumn get receiptPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Sales extends Table {
  TextColumn get id => text()();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get saleDate => dateTime()();
  RealColumn get saleWeight => real()();
  RealColumn get pricePerPound => real()();
  RealColumn get totalPrice => real()();
  TextColumn get buyer => text().withDefault(const Constant(''))();
  TextColumn get marketLocation => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter()).withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

class PredictiveAlerts extends Table {
  TextColumn get id => text()();
  TextColumn get alertType => text()();  // calving, breeding, health, market
  TextColumn get animalId => text().nullable()();
  DateTimeColumn get predictedDate => dateTime()();
  TextColumn get message => text()();
  BoolColumn get isAcknowledged => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncTableName => text()();
  TextColumn get recordId => text()();
  TextColumn get operation => text()();  // insert, update, delete
  TextColumn get data => text()();  // JSON
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [
  Animals,
  CalvingRecords,
  TreatmentRecords,
  WeightRecords,
  PriceAlerts,
  RanchSettings,
  Pastures,
  GrazingRotations,
  SmartTagReadings,
  HealthAlerts,
  Tasks,
  Expenses,
  Sales,
  PredictiveAlerts,
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'honest_cattle.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
