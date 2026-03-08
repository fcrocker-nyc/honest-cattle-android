import 'package:flutter/material.dart';
import 'dart:math';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class WeightEstimatorView extends StatefulWidget {
  const WeightEstimatorView({super.key});

  @override
  State<WeightEstimatorView> createState() => _WeightEstimatorViewState();
}

class _WeightEstimatorViewState extends State<WeightEstimatorView> {
  double _heartGirth = 60; // inches
  double _bodyLength = 50; // inches
  String _method = 'tape';

  double get _tapeWeight {
    // Heart girth squared x body length / 300
    return (pow(_heartGirth, 2) * _bodyLength / 300).toDouble();
  }

  double get _girthOnlyWeight {
    // Simplified formula using heart girth only
    // Weight = (Girth x Girth x Girth) / 300
    return (pow(_heartGirth, 3) / 300).toDouble();
  }

  double get _estimatedWeight {
    return _method == 'tape' ? _tapeWeight : _girthOnlyWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weight Estimator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        child: Column(
          children: [
            _buildResultSection(),
            const SizedBox(height: 16),
            _buildMethodSelector(),
            const SizedBox(height: 16),
            _buildInputsSection(),
            const SizedBox(height: 16),
            _buildInstructionsSection(),
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
            'Estimated Weight',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _estimatedWeight.round().toString(),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'lbs',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            ],
          ),
          Text(
            '± ${(_estimatedWeight * 0.05).round()} lbs',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodSelector() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(
          value: 'tape',
          label: Text('Tape Method'),
        ),
        ButtonSegment(
          value: 'girth',
          label: Text('Girth Only'),
        ),
      ],
      selected: {_method},
      onSelectionChanged: (selection) {
        setState(() => _method = selection.first);
      },
    );
  }

  Widget _buildInputsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Measurements',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SliderInputRow(
            label: 'Heart Girth',
            value: _heartGirth,
            min: 30,
            max: 100,
            step: 1,
            unit: 'in',
            format: '%.0f',
            onChanged: (val) => setState(() => _heartGirth = val),
          ),
          if (_method == 'tape') ...[
            const SizedBox(height: 16),
            SliderInputRow(
              label: 'Body Length',
              value: _bodyLength,
              min: 30,
              max: 80,
              step: 1,
              unit: 'in',
              format: '%.0f',
              onChanged: (val) => setState(() => _bodyLength = val),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to Measure',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _InstructionRow(
            number: '1',
            title: 'Heart Girth',
            description:
                'Measure around the body just behind the front legs and withers',
          ),
          if (_method == 'tape') ...[
            const SizedBox(height: 8),
            _InstructionRow(
              number: '2',
              title: 'Body Length',
              description:
                  'Measure from point of shoulder to pin bone',
            ),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _method == 'tape'
                        ? 'Formula: (Girth² × Length) ÷ 300'
                        : 'Formula: Girth³ ÷ 300',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _InstructionRow({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppTheme.earthGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
