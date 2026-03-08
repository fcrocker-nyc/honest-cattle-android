import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../utils/theme.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import '../../models/cattle_drug.dart';
import 'package:drift/drift.dart' hide Column;

enum QuickEntryMode { animal, treatment }

class QuickEntryView extends ConsumerStatefulWidget {
  const QuickEntryView({super.key});

  @override
  ConsumerState<QuickEntryView> createState() => _QuickEntryViewState();
}

class _QuickEntryViewState extends ConsumerState<QuickEntryView> {
  QuickEntryMode _mode = QuickEntryMode.animal;
  int _entriesAdded = 0;

  // Animal entry
  final _tagController = TextEditingController();
  AnimalSex _sex = AnimalSex.steer;
  String _breed = 'Angus';

  // Treatment entry
  String? _selectedAnimalTag;
  CattleDrug? _selectedDrug;

  final _uuid = const Uuid();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Entry'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Done'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            child: SegmentedButton<QuickEntryMode>(
              segments: const [
                ButtonSegment(
                  value: QuickEntryMode.animal,
                  label: Text('Animals'),
                ),
                ButtonSegment(
                  value: QuickEntryMode.treatment,
                  label: Text('Treatments'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (selection) {
                setState(() => _mode = selection.first);
              },
            ),
          ),
          Expanded(
            child: _mode == QuickEntryMode.animal
                ? _buildAnimalEntry()
                : _buildTreatmentEntry(),
          ),
          if (_entriesAdded > 0)
            Container(
              padding: const EdgeInsets.all(AppTheme.standardPadding),
              color: Colors.green.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text('$_entriesAdded entries added'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimalEntry() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Animal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag Number',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  onSubmitted: (_) => _addAnimal(),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                onPressed: _tagController.text.isNotEmpty ? _addAnimal : null,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.earthGreen,
                  minimumSize: const Size(56, 56),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              for (final sex in [
                AnimalSex.steer,
                AnimalSex.heifer,
                AnimalSex.bull,
                AnimalSex.cow
              ])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _SexButton(
                      sex: sex,
                      isSelected: _sex == sex,
                      onTap: () => setState(() => _sex = sex),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final breed in [
                  'Angus',
                  'Hereford',
                  'Charolais',
                  'Red Angus',
                  'Black Baldy'
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(breed),
                      selected: _breed == breed,
                      onSelected: (selected) {
                        if (selected) setState(() => _breed = breed);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentEntry() {
    final animalsAsync = ref.watch(activeAnimalsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Treatment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          animalsAsync.when(
            data: (animals) => DropdownButtonFormField<String>(
              value: _selectedAnimalTag,
              decoration: const InputDecoration(
                labelText: 'Select Animal',
                border: OutlineInputBorder(),
              ),
              items: animals
                  .map((a) => DropdownMenuItem(
                        value: a.id,
                        child: Text(a.tagNumber),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedAnimalTag = value),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Quick Select Drug',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CattleDrug.commonDrugs.take(8).map((drug) {
              return ChoiceChip(
                label: Text(drug.name),
                selected: _selectedDrug?.id == drug.id,
                onSelected: (selected) {
                  setState(() => _selectedDrug = selected ? drug : null);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedAnimalTag != null && _selectedDrug != null
                  ? _addTreatment
                  : null,
              child: const Text('Add Treatment'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addAnimal() async {
    if (_tagController.text.trim().isEmpty) return;

    final db = ref.read(databaseProvider);
    final now = DateTime.now();

    await db.into(db.animals).insert(AnimalsCompanion.insert(
          id: _uuid.v4(),
          tagNumber: _tagController.text.trim(),
          breed: Value(_breed),
          dateOfBirth: now,
          sex: _sex,
          status: AnimalStatus.active,
          createdAt: now,
          updatedAt: now,
        ));

    _tagController.clear();
    setState(() => _entriesAdded++);

    HapticFeedback.mediumImpact();
  }

  Future<void> _addTreatment() async {
    if (_selectedAnimalTag == null || _selectedDrug == null) return;

    final db = ref.read(databaseProvider);
    final now = DateTime.now();

    final animal = await (db.animals.select()
          ..where((t) => t.id.equals(_selectedAnimalTag!)))
        .getSingleOrNull();

    if (animal == null) return;

    final weight = animal.purchaseWeight ?? 500;
    final doseAmount = _selectedDrug!.calculateDosage(weight);
    final dosage = '${doseAmount.toStringAsFixed(1)} ${_selectedDrug!.unit}';

    final withdrawalDate = _selectedDrug!.withdrawalDays > 0
        ? now.add(Duration(days: _selectedDrug!.withdrawalDays))
        : null;

    await db.into(db.treatmentRecords).insert(TreatmentRecordsCompanion.insert(
          id: _uuid.v4(),
          animalId: _selectedAnimalTag!,
          date: now,
          treatment: _selectedDrug!.name,
          dosage: Value(dosage),
          route: _selectedDrug!.route,
          reason: Value(_selectedDrug!.notes),
          withdrawalDays: Value(_selectedDrug!.withdrawalDays),
          withdrawalDate: Value(withdrawalDate),
          createdAt: now,
        ));

    setState(() {
      _selectedAnimalTag = null;
      _selectedDrug = null;
      _entriesAdded++;
    });

    HapticFeedback.mediumImpact();
  }
}

class _SexButton extends StatelessWidget {
  final AnimalSex sex;
  final bool isSelected;
  final VoidCallback onTap;

  const _SexButton({
    required this.sex,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _icon {
    switch (sex) {
      case AnimalSex.bull:
        return Icons.circle;
      case AnimalSex.cow:
        return Icons.circle_outlined;
      case AnimalSex.heifer:
        return Icons.brightness_1;
      case AnimalSex.steer:
        return Icons.square;
      case AnimalSex.calf:
        return Icons.square_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.earthGreen : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              _icon,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const SizedBox(height: 4),
            Text(
              sex.label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
