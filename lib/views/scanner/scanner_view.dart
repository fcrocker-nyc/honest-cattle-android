import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class ScannerView extends ConsumerStatefulWidget {
  const ScannerView({super.key});

  @override
  ConsumerState<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends ConsumerState<ScannerView> {
  bool _isScanning = false;
  String? _scannedTag;
  String _manualTag = '';
  bool _showManualEntry = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Ear Tag'),
        actions: [
          IconButton(
            icon: Icon(
              _showManualEntry ? Icons.camera_alt : Icons.edit,
              color: AppTheme.earthGreen,
            ),
            onPressed: () {
              setState(() => _showManualEntry = !_showManualEntry);
            },
          ),
        ],
      ),
      body: _showManualEntry ? _buildManualEntry() : _buildScannerView(),
    );
  }

  Widget _buildScannerView() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.all(AppTheme.standardPadding),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Camera preview placeholder
                const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
                // Scanning overlay
                if (_isScanning)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.earthGreen,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 200,
                    height: 100,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: AppTheme.earthGreen,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Scanning...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                // Instructions
                Positioned(
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Point camera at ear tag',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            child: Column(
              children: [
                if (_scannedTag != null)
                  _buildScannedResult()
                else
                  _buildScanButton(),
                const SizedBox(height: 16),
                _buildInfoCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScannedResult() {
    return AppCard(
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Tag Scanned', style: TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _scannedTag!,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() => _scannedTag = null);
                  },
                  child: const Text('Scan Again'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/animal/new?tagNumber=$_scannedTag');
                  },
                  child: const Text('Add Animal'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _startScanning,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Start Scanning'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 56),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: AppTheme.earthGreen),
              SizedBox(width: 8),
              Text(
                'OCR Ear Tag Scanner',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Uses camera OCR to read ear tag numbers. For best results:\n'
            '• Ensure good lighting\n'
            '• Hold camera steady\n'
            '• Fill frame with tag number',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildManualEntry() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manual Entry',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Tag Number',
              border: OutlineInputBorder(),
              hintText: 'Enter ear tag number',
            ),
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(fontSize: 24),
            onChanged: (value) => _manualTag = value,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() => _showManualEntry = false);
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _manualTag.isNotEmpty
                      ? () {
                          context.push('/animal/new?tagNumber=$_manualTag');
                        }
                      : null,
                  child: const Text('Add Animal'),
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildInfoCard(),
        ],
      ),
    );
  }

  void _startScanning() async {
    setState(() => _isScanning = true);

    // Simulate scanning delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate a scanned tag (in real implementation, use ML Kit)
    setState(() {
      _isScanning = false;
      _scannedTag = 'A${DateTime.now().millisecondsSinceEpoch % 10000}';
    });
  }
}
