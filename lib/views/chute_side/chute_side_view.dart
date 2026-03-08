import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import '../../models/cattle_drug.dart';
import 'package:drift/drift.dart' hide Column;

enum ChuteSideMode { weight, treatment, both }

class ChuteSideView extends ConsumerStatefulWidget {
  const ChuteSideView({super.key});

  @override
  ConsumerState<ChuteSideView> createState() => _ChuteSideViewState();
}

class _ChuteSideViewState extends ConsumerState<ChuteSideView> {
  ChuteSideMode _mode = ChuteSideMode.both;
  Animal? _currentAnimal;
  int _processedCount = 0;
  final _weightController = TextEditingController();
  CattleDrug? _selectedDrug;
  String _treatmentNotes = '';

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalsAsync = ref.watch(activeAnimalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chute-Side Entry'),
        actions: [
          if (_processedCount > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        '$_processedCount',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          Expanded(
            child: _currentAnimal == null
                ? _buildAnimalSelector(animalsAsync)
                : _buildEntryForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: SegmentedButton<ChuteSideMode>(
        segments: const [
          ButtonSegment(
            value: ChuteSideMode.weight,
            label: Text('Weight'),
            icon: Icon(Icons.monitor_weight),
          ),
          ButtonSegment(
            value: ChuteSideMode.treatment,
            label: Text('Treatment'),
            icon: Icon(Icons.medical_services),
          ),
          ButtonSegment(
            value: ChuteSideMode.both,
            label: Text('Both'),
            icon: Icon(Icons.all_inclusive),
          ),
        ],
        selected: {_mode},
        onSelectionChanged: (selection) {
          setState(() => _mode = selection.first);
        },
      ),
    );
  }

  Widget _buildAnimalSelector(AsyncValue<List<Animal>> animalsAsync) {
    return animalsAsync.when(
      data: (animals) {
        if (animals.isEmpty) {
          return const EmptyStateView(
            icon: Icons.pets,
            title: 'No animals',
            subtitle: 'Add animals to your herd first',
          );
        }

        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.standardPadding),
              child: Row(
                children: [
                  const Text(
                    'Select Animal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan'),
                    onPressed: () => context.push('/scanner'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(AppTheme.standardPadding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  final animal = animals[index];
                  return _AnimalButton(
                    animal: animal,
                    onTap: () => setState(() => _currentAnimal = animal),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEntryForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentAnimalCard(),
          const SizedBox(height: 16),
          if (_mode == ChuteSideMode.weight || _mode == ChuteSideMode.both)
            _buildWeightEntry(),
          if (_mode == ChuteSideMode.treatment || _mode == ChuteSideMode.both)
            _buildTreatmentEntry(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancelEntry,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 56),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      SizedBox(width: 8),
                      Text('Save & Next'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentAnimalCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      decoration: BoxDecoration(
        color: AppTheme.earthGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
        border: Border.all(color: AppTheme.earthGreen),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.earthGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.pets, size: 32, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentAnimal!.tagNumber,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_currentAnimal!.sex.label} • ${_currentAnimal!.breed}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => setState(() => _currentAnimal = null),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Weight',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _weightController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: '0',
            suffixText: 'lbs',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [500, 600, 700, 800, 900].map((weight) {
            return GestureDetector(
              onTap: () => _weightController.text = weight.toString(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$weight',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTreatmentEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Treatment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CattleDrug.commonDrugs.take(8).map((drug) {
            return GestureDetector(
              onTap: () => setState(() => _selectedDrug = drug),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedDrug?.id == drug.id
                      ? AppTheme.earthGreen
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  drug.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _selectedDrug?.id == drug.id
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedDrug != null) ...[
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDrug!.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_selectedDrug!.withdrawalDays} day withdrawal',
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Dose: ${_calculateDose().toStringAsFixed(1)} ${_selectedDrug!.unit}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Route: ${_selectedDrug!.route.label}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  double _calculateDose() {
    if (_selectedDrug == null) return 0;
    final weight = double.tryParse(_weightController.text) ??
        _currentAnimal?.purchaseWeight ??
        500;
    return _selectedDrug!.calculateDosage(weight);
  }

  void _cancelEntry() {
    setState(() {
      _currentAnimal = null;
      _weightController.clear();
      _selectedDrug = null;
      _treatmentNotes = '';
    });
  }

  Future<void> _saveEntry() async {
    if (_currentAnimal == null) return;

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final uuid = const Uuid();

    // Save weight if entered
    if (_mode != ChuteSideMode.treatment && _weightController.text.isNotEmpty) {
      final weight = double.tryParse(_weightController.text);
      if (weight != null && weight > 0) {
        await db.into(db.weightRecords).insert(WeightRecordsCompanion.insert(
              id: uuid.v4(),
              animalId: _currentAnimal!.id,
              date: now,
              weight: weight,
              createdAt: now,
            ));
      }
    }

    // Save treatment if selected
    if (_mode != ChuteSideMode.weight && _selectedDrug != null) {
      final weight = double.tryParse(_weightController.text) ??
          _currentAnimal!.purchaseWeight ??
          500;
      final dose = _selectedDrug!.calculateDosage(weight);
      final withdrawalDate = _selectedDrug!.withdrawalDays > 0
          ? now.add(Duration(days: _selectedDrug!.withdrawalDays))
          : null;

      await db.into(db.treatmentRecords).insert(TreatmentRecordsCompanion.insert(
            id: uuid.v4(),
            animalId: _currentAnimal!.id,
            date: now,
            treatment: _selectedDrug!.name,
            dosage: Value('${dose.toStringAsFixed(1)} ${_selectedDrug!.unit}'),
            route: _selectedDrug!.route,
            reason: Value(_selectedDrug!.notes),
            withdrawalDays: Value(_selectedDrug!.withdrawalDays),
            withdrawalDate: Value(withdrawalDate),
            notes: Value(_treatmentNotes),
            createdAt: now,
          ));
    }

    HapticFeedback.mediumImpact();

    setState(() {
      _processedCount++;
      _currentAnimal = null;
      _weightController.clear();
      _selectedDrug = null;
      _treatmentNotes = '';
    });
  }
}

class _AnimalButton extends StatelessWidget {
  final Animal animal;
  final VoidCallback onTap;

  const _AnimalButton({required this.animal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.earthGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.pets, color: AppTheme.earthGreen),
            ),
            const SizedBox(height: 8),
            Text(
              animal.tagNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
