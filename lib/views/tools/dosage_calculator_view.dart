import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../models/cattle_drug.dart';

class DosageCalculatorView extends StatefulWidget {
  const DosageCalculatorView({super.key});

  @override
  State<DosageCalculatorView> createState() => _DosageCalculatorViewState();
}

class _DosageCalculatorViewState extends State<DosageCalculatorView> {
  CattleDrug? _selectedDrug;
  double _animalWeight = 500;

  double get _dosage {
    if (_selectedDrug == null) return 0;
    return _selectedDrug!.calculateDosage(_animalWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dosage Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrugSelection(),
            if (_selectedDrug != null) ...[
              const SizedBox(height: 16),
              _buildWeightInput(),
              const SizedBox(height: 16),
              _buildResultSection(),
              const SizedBox(height: 16),
              _buildDrugInfo(),
              const SizedBox(height: 16),
              _buildWarning(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrugSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Select Drug'),
        GestureDetector(
          onTap: _showDrugPicker,
          child: AppCard(
            child: Row(
              children: [
                if (_selectedDrug != null) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedDrug!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _selectedDrug!.dosageDescription,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else
                  Text(
                    'Tap to select a drug',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Common Drugs',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CattleDrug.commonDrugs.take(6).map((drug) {
            return ChoiceChip(
              label: Text(drug.name),
              selected: _selectedDrug?.id == drug.id,
              onSelected: (selected) {
                setState(() => _selectedDrug = selected ? drug : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildWeightInput() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Animal Weight',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _animalWeight.round().toString(),
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'lbs',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          Slider(
            value: _animalWeight,
            min: 100,
            max: 2000,
            divisions: 76,
            onChanged: (val) => setState(() => _animalWeight = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [300, 500, 700, 900, 1200].map((weight) {
              return GestureDetector(
                onTap: () => setState(() => _animalWeight = weight.toDouble()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _animalWeight.round() == weight
                        ? AppTheme.earthGreen.withValues(alpha: 0.2)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$weight',
                    style: TextStyle(
                      color: _animalWeight.round() == weight
                          ? AppTheme.earthGreen
                          : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    return AppCard(
      child: Column(
        children: [
          Text(
            'Recommended Dosage',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _dosage.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.earthGreen,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _selectedDrug!.unit,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '${_selectedDrug!.name} via ${_selectedDrug!.route.label}',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildDrugInfo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Drug Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          InfoRow(label: 'Route', value: _selectedDrug!.route.label),
          const SizedBox(height: 8),
          InfoRow(
            label: 'Withdrawal',
            value: '${_selectedDrug!.withdrawalDays} days',
          ),
          if (_selectedDrug!.notes.isNotEmpty) ...[
            const SizedBox(height: 8),
            InfoRow(label: 'Notes', value: _selectedDrug!.notes),
          ],
        ],
      ),
    );
  }

  Widget _buildWarning() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Important',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Always verify dosage with product label and consult your veterinarian. This calculator is for reference only.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDrugPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.standardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Drug',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: CattleDrug.commonDrugs.length,
                itemBuilder: (context, index) {
                  final drug = CattleDrug.commonDrugs[index];
                  return ListTile(
                    title: Text(drug.name),
                    subtitle: Text(drug.dosageDescription),
                    trailing: _selectedDrug?.id == drug.id
                        ? const Icon(Icons.check, color: AppTheme.earthGreen)
                        : null,
                    onTap: () {
                      setState(() => _selectedDrug = drug);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
