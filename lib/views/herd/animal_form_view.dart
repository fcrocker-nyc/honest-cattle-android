import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import 'package:drift/drift.dart' hide Column;

class AnimalFormView extends ConsumerStatefulWidget {
  final String? animalId;
  final String? initialTagNumber;

  const AnimalFormView({
    super.key,
    this.animalId,
    this.initialTagNumber,
  });

  @override
  ConsumerState<AnimalFormView> createState() => _AnimalFormViewState();
}

class _AnimalFormViewState extends ConsumerState<AnimalFormView> {
  final _formKey = GlobalKey<FormState>();
  final _tagController = TextEditingController();
  final _breedController = TextEditingController();
  final _sireTagController = TextEditingController();
  final _damTagController = TextEditingController();
  final _notesController = TextEditingController();
  final _purchaseWeightController = TextEditingController();
  final _purchasePriceController = TextEditingController();

  DateTime _dateOfBirth = DateTime.now();
  AnimalSex _sex = AnimalSex.steer;
  AnimalStatus _status = AnimalStatus.active;
  bool _hasPurchaseInfo = false;
  DateTime _purchaseDate = DateTime.now();

  bool _isLoading = false;
  Animal? _existingAnimal;

  @override
  void initState() {
    super.initState();
    if (widget.initialTagNumber != null) {
      _tagController.text = widget.initialTagNumber!;
    }
    if (widget.animalId != null) {
      _loadAnimal();
    }
  }

  Future<void> _loadAnimal() async {
    final db = ref.read(databaseProvider);
    final animal = await (db.animals.select()
          ..where((t) => t.id.equals(widget.animalId!)))
        .getSingleOrNull();

    if (animal != null) {
      setState(() {
        _existingAnimal = animal;
        _tagController.text = animal.tagNumber;
        _breedController.text = animal.breed;
        _dateOfBirth = animal.dateOfBirth;
        _sex = animal.sex;
        _status = animal.status;
        _sireTagController.text = animal.sireTag ?? '';
        _damTagController.text = animal.damTag ?? '';
        _notesController.text = animal.notes;
        _hasPurchaseInfo = animal.purchaseDate != null;
        _purchaseDate = animal.purchaseDate ?? DateTime.now();
        _purchaseWeightController.text =
            animal.purchaseWeight?.toString() ?? '';
        _purchasePriceController.text = animal.purchasePrice?.toString() ?? '';
      });
    }
  }

  @override
  void dispose() {
    _tagController.dispose();
    _breedController.dispose();
    _sireTagController.dispose();
    _damTagController.dispose();
    _notesController.dispose();
    _purchaseWeightController.dispose();
    _purchasePriceController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.animalId != null;

  Future<void> _saveAnimal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final db = ref.read(databaseProvider);
      final now = DateTime.now();

      final purchaseWeight = _hasPurchaseInfo
          ? double.tryParse(_purchaseWeightController.text)
          : null;
      final purchasePrice = _hasPurchaseInfo
          ? double.tryParse(_purchasePriceController.text)
          : null;

      if (_isEditing && _existingAnimal != null) {
        await (db.animals.update()
              ..where((t) => t.id.equals(_existingAnimal!.id)))
            .write(AnimalsCompanion(
          tagNumber: Value(_tagController.text.trim()),
          breed: Value(_breedController.text.trim()),
          dateOfBirth: Value(_dateOfBirth),
          sex: Value(_sex),
          status: Value(_status),
          sireTag: Value(_sireTagController.text.isEmpty
              ? null
              : _sireTagController.text.trim()),
          damTag: Value(_damTagController.text.isEmpty
              ? null
              : _damTagController.text.trim()),
          notes: Value(_notesController.text),
          purchaseDate: Value(_hasPurchaseInfo ? _purchaseDate : null),
          purchaseWeight: Value(purchaseWeight),
          purchasePrice: Value(purchasePrice),
          updatedAt: Value(now),
        ));
      } else {
        await db.into(db.animals).insert(AnimalsCompanion.insert(
              id: const Uuid().v4(),
              tagNumber: _tagController.text.trim(),
              breed: Value(_breedController.text.trim()),
              dateOfBirth: _dateOfBirth,
              sex: _sex,
              status: _status,
              sireTag: Value(_sireTagController.text.isEmpty
                  ? null
                  : _sireTagController.text.trim()),
              damTag: Value(_damTagController.text.isEmpty
                  ? null
                  : _damTagController.text.trim()),
              notes: Value(_notesController.text),
              purchaseDate: Value(_hasPurchaseInfo ? _purchaseDate : null),
              purchaseWeight: Value(purchaseWeight),
              purchasePrice: Value(purchasePrice),
              createdAt: now,
              updatedAt: now,
            ));
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving animal: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Animal' : 'Add Animal'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveAnimal,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.standardPadding),
          children: [
            // Basic Information
            _buildSectionTitle('Basic Information'),
            TextFormField(
              controller: _tagController,
              decoration: const InputDecoration(labelText: 'Tag Number *'),
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tag number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<AnimalSex>(
              value: _sex,
              decoration: const InputDecoration(labelText: 'Sex'),
              items: AnimalSex.values
                  .map((sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex.label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _sex = value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<AnimalStatus>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: AnimalStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: 16),
            _buildDatePicker(
              label: 'Date of Birth',
              value: _dateOfBirth,
              onChanged: (date) => setState(() => _dateOfBirth = date),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Breed'),
            DropdownButtonFormField<String>(
              value: AppConstants.commonBreeds.contains(_breedController.text)
                  ? _breedController.text
                  : null,
              decoration: const InputDecoration(labelText: 'Breed'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Select Breed')),
                ...AppConstants.commonBreeds.map((breed) => DropdownMenuItem(
                      value: breed,
                      child: Text(breed),
                    )),
              ],
              onChanged: (value) {
                setState(() => _breedController.text = value ?? '');
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: 'Custom Breed'),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Lineage'),
            TextFormField(
              controller: _sireTagController,
              decoration: const InputDecoration(labelText: 'Sire Tag'),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _damTagController,
              decoration: const InputDecoration(labelText: 'Dam Tag'),
              textCapitalization: TextCapitalization.characters,
            ),

            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Include Purchase Info'),
              value: _hasPurchaseInfo,
              onChanged: (value) => setState(() => _hasPurchaseInfo = value),
              activeColor: AppTheme.earthGreen,
              contentPadding: EdgeInsets.zero,
            ),
            if (_hasPurchaseInfo) ...[
              const SizedBox(height: 16),
              _buildDatePicker(
                label: 'Purchase Date',
                value: _purchaseDate,
                onChanged: (date) => setState(() => _purchaseDate = date),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _purchaseWeightController,
                decoration: const InputDecoration(
                  labelText: 'Purchase Weight (lbs)',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _purchasePriceController,
                decoration: const InputDecoration(
                  labelText: 'Purchase Price (\$)',
                  prefixText: '\$ ',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],

            const SizedBox(height: 24),
            _buildSectionTitle('Notes'),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime value,
    required ValueChanged<DateTime> onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          onChanged(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${value.month}/${value.day}/${value.year}',
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}
