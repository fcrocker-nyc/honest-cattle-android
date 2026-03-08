import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';

class AnimalDetailView extends ConsumerWidget {
  final String animalId;

  const AnimalDetailView({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalByIdProvider(animalId));
    final treatmentsAsync = ref.watch(treatmentRecordsProvider(animalId));
    final calvingsAsync = ref.watch(calvingRecordsProvider(animalId));
    final weightsAsync = ref.watch(weightRecordsProvider(animalId));

    return animalAsync.when(
      data: (animal) {
        if (animal == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Animal Not Found')),
            body: const Center(child: Text('Animal not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Animal Details'),
            actions: [
              TextButton(
                onPressed: () => context.push('/animal/$animalId/edit'),
                child: const Text('Edit'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(animal),
                const SizedBox(height: 16),
                _buildInfoSection(animal),
                const SizedBox(height: 16),
                if (animal.sex == AnimalSex.cow)
                  calvingsAsync.when(
                    data: (calvings) => _buildCalvingSection(context, calvings),
                    loading: () =>
                        const LoadingCard(title: 'Loading calvings...'),
                    error: (e, _) => ErrorCard(message: e.toString()),
                  ),
                const SizedBox(height: 16),
                treatmentsAsync.when(
                  data: (treatments) =>
                      _buildTreatmentSection(context, treatments),
                  loading: () =>
                      const LoadingCard(title: 'Loading treatments...'),
                  error: (e, _) => ErrorCard(message: e.toString()),
                ),
                const SizedBox(height: 16),
                weightsAsync.when(
                  data: (weights) => _buildWeightSection(context, weights),
                  loading: () => const LoadingCard(title: 'Loading weights...'),
                  error: (e, _) => ErrorCard(message: e.toString()),
                ),
                if (animal.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildNotesSection(animal.notes),
                ],
                const SizedBox(height: 24),
                _buildDeleteButton(context, ref, animal),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildHeader(Animal animal) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.earthGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getSexIcon(animal.sex),
                  size: 44,
                  color: AppTheme.earthGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.tagNumber,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          animal.sex.label,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        if (animal.breed.isNotEmpty) ...[
                          Text(' • ', style: TextStyle(color: Colors.grey[600])),
                          Text(
                            animal.breed,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    StatusBadge(
                      text: animal.status.label,
                      color: _getStatusColor(animal.status),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(Animal animal) {
    final months = DateTime.now().difference(animal.dateOfBirth).inDays ~/ 30;
    final ageStr = months < 12
        ? '$months mo'
        : '${months ~/ 12} yr ${months % 12} mo';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              InfoRow(
                label: 'Date of Birth',
                value:
                    '${animal.dateOfBirth.month}/${animal.dateOfBirth.day}/${animal.dateOfBirth.year}',
              ),
              InfoRow(label: 'Age', value: ageStr),
              if (animal.sireTag != null)
                InfoRow(label: 'Sire', value: animal.sireTag!),
              if (animal.damTag != null)
                InfoRow(label: 'Dam', value: animal.damTag!),
              if (animal.purchaseDate != null)
                InfoRow(
                  label: 'Purchase Date',
                  value:
                      '${animal.purchaseDate!.month}/${animal.purchaseDate!.day}/${animal.purchaseDate!.year}',
                ),
              if (animal.purchaseWeight != null)
                InfoRow(
                  label: 'Purchase Weight',
                  value: '${animal.purchaseWeight!.round()} lbs',
                ),
              if (animal.purchasePrice != null)
                InfoRow(
                  label: 'Purchase Price',
                  value: '\$${animal.purchasePrice!.toStringAsFixed(2)}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalvingSection(
      BuildContext context, List<CalvingRecord> calvings) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calving Records',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppTheme.earthGreen),
                onPressed: () {
                  // Navigate to add calving record
                },
              ),
            ],
          ),
          if (calvings.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'No calving records',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...calvings.map((record) => _CalvingRecordRow(record: record)),
        ],
      ),
    );
  }

  Widget _buildTreatmentSection(
      BuildContext context, List<TreatmentRecord> treatments) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Treatment Records',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppTheme.earthGreen),
                onPressed: () {
                  // Navigate to add treatment record
                },
              ),
            ],
          ),
          if (treatments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'No treatment records',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...treatments.map((record) => _TreatmentRecordRow(record: record)),
        ],
      ),
    );
  }

  Widget _buildWeightSection(BuildContext context, List<WeightRecord> weights) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weight Records',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppTheme.earthGreen),
                onPressed: () {
                  // Navigate to add weight record
                },
              ),
            ],
          ),
          if (weights.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'No weight records',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...weights.map((record) => _WeightRecordRow(record: record)),
        ],
      ),
    );
  }

  Widget _buildNotesSection(String notes) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(notes, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(
      BuildContext context, WidgetRef ref, Animal animal) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _confirmDelete(context, ref, animal),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Text('Delete Animal'),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Animal animal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Animal'),
        content: Text(
          'Are you sure you want to delete ${animal.tagNumber}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);
              await (db.delete(db.animals)
                    ..where((t) => t.id.equals(animal.id)))
                  .go();
              if (context.mounted) {
                Navigator.pop(context);
                context.pop();
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  IconData _getSexIcon(AnimalSex sex) {
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

  Color _getStatusColor(AnimalStatus status) {
    switch (status) {
      case AnimalStatus.active:
        return Colors.green;
      case AnimalStatus.sold:
        return AppTheme.warmBrown;
      case AnimalStatus.deceased:
      case AnimalStatus.culled:
        return Colors.grey;
      case AnimalStatus.breeding:
        return Colors.blue;
      case AnimalStatus.calving:
        return Colors.purple;
    }
  }
}

class _CalvingRecordRow extends StatelessWidget {
  final CalvingRecord record;

  const _CalvingRecordRow({required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${record.date.month}/${record.date.day}/${record.date.year}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              StatusBadge(
                text: 'Ease: ${record.calvingEaseScore}',
                color: _getEaseColor(record.calvingEaseScore),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.tag, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(record.calfTag, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 12),
              Text(record.calfSex.label, style: const TextStyle(fontSize: 12)),
              if (record.birthWeight != null) ...[
                const SizedBox(width: 12),
                Text('${record.birthWeight!.round()} lbs',
                    style: const TextStyle(fontSize: 12)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getEaseColor(int score) {
    switch (score) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _TreatmentRecordRow extends StatelessWidget {
  final TreatmentRecord record;

  const _TreatmentRecordRow({required this.record});

  bool get _isWithdrawalActive {
    if (record.withdrawalDate == null) return false;
    return DateTime.now().isBefore(record.withdrawalDate!);
  }

  int get _daysUntilClear {
    if (record.withdrawalDate == null) return 0;
    return record.withdrawalDate!.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.treatment,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              if (_isWithdrawalActive)
                StatusBadge(
                  text: '$_daysUntilClear days',
                  color: Colors.orange,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${record.date.month}/${record.date.day}/${record.date.year}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Text(
                record.dosage,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Text(
                record.route.label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          if (record.reason.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              record.reason,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }
}

class _WeightRecordRow extends StatelessWidget {
  final WeightRecord record;

  const _WeightRecordRow({required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${record.date.month}/${record.date.day}/${record.date.year}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            '${record.weight.round()} lbs',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
