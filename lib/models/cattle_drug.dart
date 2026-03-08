import 'database.dart';

class CattleDrug {
  final String id;
  final String name;
  final double dosagePerCwt;
  final String unit;
  final TreatmentRoute route;
  final int withdrawalDays;
  final String notes;

  const CattleDrug({
    required this.id,
    required this.name,
    required this.dosagePerCwt,
    required this.unit,
    required this.route,
    required this.withdrawalDays,
    required this.notes,
  });

  String get dosageDescription => '$dosagePerCwt $unit per 100 lbs';

  double calculateDosage(double animalWeight) {
    return (animalWeight / 100) * dosagePerCwt;
  }

  static const List<CattleDrug> commonDrugs = [
    CattleDrug(
      id: 'draxxin',
      name: 'Draxxin',
      dosagePerCwt: 1.1,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 28,
      notes: 'Tulathromycin - BRD treatment',
    ),
    CattleDrug(
      id: 'excede',
      name: 'Excede',
      dosagePerCwt: 1.0,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 13,
      notes: 'Ceftiofur - BRD treatment',
    ),
    CattleDrug(
      id: 'nuflor',
      name: 'Nuflor',
      dosagePerCwt: 3.0,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 28,
      notes: 'Florfenicol - BRD treatment',
    ),
    CattleDrug(
      id: 'baytril',
      name: 'Baytril 100',
      dosagePerCwt: 3.4,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 28,
      notes: 'Enrofloxacin - BRD treatment',
    ),
    CattleDrug(
      id: 'micotil',
      name: 'Micotil',
      dosagePerCwt: 1.5,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 28,
      notes: 'Tilmicosin - BRD treatment',
    ),
    CattleDrug(
      id: 'la200',
      name: 'LA-200',
      dosagePerCwt: 4.5,
      unit: 'mL',
      route: TreatmentRoute.intramuscular,
      withdrawalDays: 28,
      notes: 'Oxytetracycline - Various infections',
    ),
    CattleDrug(
      id: 'dectomax',
      name: 'Dectomax',
      dosagePerCwt: 1.0,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 35,
      notes: 'Doramectin - Parasiticide',
    ),
    CattleDrug(
      id: 'ivomec',
      name: 'Ivomec',
      dosagePerCwt: 1.0,
      unit: 'mL',
      route: TreatmentRoute.subcutaneous,
      withdrawalDays: 35,
      notes: 'Ivermectin - Parasiticide',
    ),
    CattleDrug(
      id: 'safeguard',
      name: 'Safe-Guard',
      dosagePerCwt: 2.3,
      unit: 'mL',
      route: TreatmentRoute.oral,
      withdrawalDays: 8,
      notes: 'Fenbendazole - Dewormer',
    ),
    CattleDrug(
      id: 'banamine',
      name: 'Banamine',
      dosagePerCwt: 1.0,
      unit: 'mL',
      route: TreatmentRoute.intravenous,
      withdrawalDays: 4,
      notes: 'Flunixin - Anti-inflammatory',
    ),
    CattleDrug(
      id: 'dexamethasone',
      name: 'Dexamethasone',
      dosagePerCwt: 1.0,
      unit: 'mL',
      route: TreatmentRoute.intramuscular,
      withdrawalDays: 0,
      notes: 'Corticosteroid - Anti-inflammatory',
    ),
    CattleDrug(
      id: 'penicillin',
      name: 'Penicillin G',
      dosagePerCwt: 3.0,
      unit: 'mL',
      route: TreatmentRoute.intramuscular,
      withdrawalDays: 10,
      notes: 'Antibiotic - Various infections',
    ),
  ];

  static CattleDrug? findByName(String name) {
    try {
      return commonDrugs.firstWhere(
        (drug) => drug.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
