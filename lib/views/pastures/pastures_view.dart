import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import 'package:drift/drift.dart' hide Column;

class PasturesView extends ConsumerStatefulWidget {
  const PasturesView({super.key});

  @override
  ConsumerState<PasturesView> createState() => _PasturesViewState();
}

class _PasturesViewState extends ConsumerState<PasturesView> {
  final MapController _mapController = MapController();
  bool _isDrawing = false;
  List<LatLng> _drawingPoints = [];
  Pasture? _selectedPasture;

  @override
  Widget build(BuildContext context) {
    final pasturesAsync = ref.watch(pasturesProvider);
    final rotationsAsync = ref.watch(grazingRotationsProvider);
    final locationService = ref.read(locationServiceProvider);

    final position = locationService.currentPosition;
    final defaultCenter = LatLng(
      position?.latitude ?? AppConstants.defaultLatitude,
      position?.longitude ?? AppConstants.defaultLongitude,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pastures'),
        actions: [
          IconButton(
            icon: Icon(
              _isDrawing ? Icons.check : Icons.add,
              color: AppTheme.earthGreen,
            ),
            onPressed: () {
              if (_isDrawing && _drawingPoints.length >= 3) {
                _savePasture();
              } else {
                setState(() {
                  _isDrawing = !_isDrawing;
                  _drawingPoints = [];
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: defaultCenter,
                    initialZoom: 13,
                    onTap: _isDrawing
                        ? (tapPosition, point) {
                            setState(() => _drawingPoints.add(point));
                          }
                        : null,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.honest_cattle',
                    ),
                    // Existing pastures
                    pasturesAsync.when(
                      data: (pastures) => PolygonLayer(
                        polygons: pastures.map((p) {
                          final points = _parsePolygon(p.boundaryJson);
                          return Polygon(
                            points: points,
                            color: _selectedPasture?.id == p.id
                                ? AppTheme.earthGreen.withValues(alpha: 0.4)
                                : AppTheme.earthGreen.withValues(alpha: 0.2),
                            borderColor: _selectedPasture?.id == p.id
                                ? AppTheme.earthGreen
                                : AppTheme.warmBrown,
                            borderStrokeWidth: 2,
                            isFilled: true,
                          );
                        }).toList(),
                      ),
                      loading: () => const PolygonLayer(polygons: []),
                      error: (_, __) => const PolygonLayer(polygons: []),
                    ),
                    // Drawing points
                    if (_isDrawing && _drawingPoints.isNotEmpty)
                      PolygonLayer(
                        polygons: [
                          Polygon(
                            points: _drawingPoints,
                            color: Colors.blue.withValues(alpha: 0.3),
                            borderColor: Colors.blue,
                            borderStrokeWidth: 2,
                            isFilled: true,
                          ),
                        ],
                      ),
                    if (_isDrawing)
                      MarkerLayer(
                        markers: _drawingPoints
                            .map((p) => Marker(
                                  point: p,
                                  width: 20,
                                  height: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                  ],
                ),
                if (_isDrawing)
                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Tap to add points (${_drawingPoints.length} points)',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: _selectedPasture != null
                ? _buildPastureDetail(_selectedPasture!, rotationsAsync)
                : _buildPastureList(pasturesAsync),
          ),
        ],
      ),
    );
  }

  Widget _buildPastureList(AsyncValue<List<Pasture>> pasturesAsync) {
    return pasturesAsync.when(
      data: (pastures) {
        if (pastures.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 8),
                const Text('No pastures defined'),
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Pasture'),
                  onPressed: () => setState(() {
                    _isDrawing = true;
                    _drawingPoints = [];
                  }),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: pastures.length,
          itemBuilder: (context, index) {
            final pasture = pastures[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.earthGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.grass, color: AppTheme.earthGreen),
              ),
              title: Text(pasture.name),
              subtitle: pasture.acreage != null
                  ? Text('${pasture.acreage!.toStringAsFixed(1)} acres')
                  : null,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => setState(() => _selectedPasture = pasture),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildPastureDetail(
      Pasture pasture, AsyncValue<List<GrazingRotation>> rotationsAsync) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => _selectedPasture = null),
          ),
          title: Text(pasture.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deletePasture(pasture),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pasture.acreage != null)
                  InfoRow(
                    label: 'Acreage',
                    value: '${pasture.acreage!.toStringAsFixed(1)} acres',
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Recent Rotations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: rotationsAsync.when(
                    data: (rotations) {
                      final pastureRotations = rotations
                          .where((r) => r.pastureId == pasture.id)
                          .toList();
                      if (pastureRotations.isEmpty) {
                        return const Center(
                          child: Text('No rotation history'),
                        );
                      }
                      return ListView.builder(
                        itemCount: pastureRotations.length,
                        itemBuilder: (context, index) {
                          final rotation = pastureRotations[index];
                          return ListTile(
                            title: Text(
                              '${rotation.startDate.month}/${rotation.startDate.day}/${rotation.startDate.year}',
                            ),
                            subtitle:
                                Text('${rotation.animalIds.split(',').length} animals'),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<LatLng> _parsePolygon(String json) {
    // Simple coordinate parsing from stored format
    // Format: "lat1,lng1;lat2,lng2;lat3,lng3"
    try {
      return json.split(';').map((coord) {
        final parts = coord.split(',');
        return LatLng(double.parse(parts[0]), double.parse(parts[1]));
      }).toList();
    } catch (_) {
      return [];
    }
  }

  String _encodePolygon(List<LatLng> points) {
    return points.map((p) => '${p.latitude},${p.longitude}').join(';');
  }

  Future<void> _savePasture() async {
    final nameController = TextEditingController();
    final acreageController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Pasture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Pasture Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: acreageController,
              decoration: const InputDecoration(labelText: 'Acreage (optional)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      final db = ref.read(databaseProvider);
      final now = DateTime.now();

      await db.into(db.pastures).insert(PasturesCompanion.insert(
            id: const Uuid().v4(),
            name: nameController.text,
            boundaryJson: _encodePolygon(_drawingPoints),
            acreage: Value(double.tryParse(acreageController.text)),
            createdAt: now,
            updatedAt: now,
          ));

      setState(() {
        _isDrawing = false;
        _drawingPoints = [];
      });
    }
  }

  Future<void> _deletePasture(Pasture pasture) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Pasture'),
        content: Text('Delete "${pasture.name}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = ref.read(databaseProvider);
      await (db.delete(db.pastures)..where((t) => t.id.equals(pasture.id))).go();
      setState(() => _selectedPasture = null);
    }
  }
}
