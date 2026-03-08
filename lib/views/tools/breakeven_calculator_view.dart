import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class BreakevenCalculatorView extends StatefulWidget {
  const BreakevenCalculatorView({super.key});

  @override
  State<BreakevenCalculatorView> createState() =>
      _BreakevenCalculatorViewState();
}

class _BreakevenCalculatorViewState extends State<BreakevenCalculatorView> {
  double _purchaseWeight = 550;
  double _purchasePrice = 250;
  double _costOfGain = 0.90;
  double _targetWeight = 750;
  double _additionalCosts = 50;
  double _deathLoss = 1.5;

  double get _weightGain => (_targetWeight - _purchaseWeight).clamp(0, double.infinity);

  double get _purchaseCost => (_purchaseWeight / 100) * _purchasePrice;

  double get _feedCost => _weightGain * _costOfGain;

  double get _totalCost => _purchaseCost + _feedCost + _additionalCosts;

  double get _adjustedCost => _totalCost / (1 - (_deathLoss / 100));

  double get _breakevenPrice {
    if (_targetWeight <= 0) return 0;
    return (_adjustedCost / _targetWeight) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breakeven Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        child: Column(
          children: [
            _buildResultSection(),
            const SizedBox(height: 16),
            _buildInputsSection(),
            const SizedBox(height: 16),
            _buildBreakdownSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    return AppCard(
      child: Column(
        children: [
          Text(
            'Breakeven Price',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              Text(
                _breakevenPrice.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'per cwt at ${_targetWeight.round()} lbs',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildInputsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inputs',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Purchase Weight',
            value: _purchaseWeight,
            min: 300,
            max: 900,
            step: 25,
            unit: 'lbs',
            format: '%.0f',
            onChanged: (val) => setState(() => _purchaseWeight = val),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Purchase Price',
            value: _purchasePrice,
            min: 100,
            max: 400,
            step: 5,
            unit: '\$/cwt',
            format: '%.0f',
            onChanged: (val) => setState(() => _purchasePrice = val),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Target Weight',
            value: _targetWeight,
            min: 400,
            max: 1200,
            step: 25,
            unit: 'lbs',
            format: '%.0f',
            onChanged: (val) => setState(() => _targetWeight = val),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Cost of Gain',
            value: _costOfGain,
            min: 0.50,
            max: 2.00,
            step: 0.05,
            unit: '\$/lb',
            format: '%.2f',
            onChanged: (val) => setState(() => _costOfGain = val),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Additional Costs',
            value: _additionalCosts,
            min: 0,
            max: 200,
            step: 10,
            unit: '\$',
            format: '%.0f',
            onChanged: (val) => setState(() => _additionalCosts = val),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Death Loss',
            value: _deathLoss,
            min: 0,
            max: 5,
            step: 0.5,
            unit: '%',
            format: '%.1f',
            onChanged: (val) => setState(() => _deathLoss = val),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cost Breakdown',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _CostRow(
            label: 'Purchase Cost',
            value: _purchaseCost,
            note:
                '${_purchaseWeight.round()} lbs @ \$${_purchasePrice.round()}/cwt',
          ),
          _CostRow(
            label: 'Feed Cost',
            value: _feedCost,
            note:
                '${_weightGain.round()} lbs gain @ \$${_costOfGain.toStringAsFixed(2)}/lb',
          ),
          _CostRow(
            label: 'Additional Costs',
            value: _additionalCosts,
            note: 'Vet, hauling, yardage, etc.',
          ),
          const Divider(),
          _CostRow(label: 'Subtotal', value: _totalCost, isTotal: true),
          _CostRow(
            label: 'Adjusted for ${_deathLoss.toStringAsFixed(1)}% death loss',
            value: _adjustedCost,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  final String label;
  final double value;
  final String? note;
  final bool isTotal;

  const _CostRow({
    required this.label,
    required this.value,
    this.note,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                '\$${value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? AppTheme.earthGreen : null,
                ),
              ),
            ],
          ),
          if (note != null)
            Text(
              note!,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
        ],
      ),
    );
  }
}
