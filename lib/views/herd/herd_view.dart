import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';

class HerdView extends ConsumerStatefulWidget {
  const HerdView({super.key});

  @override
  ConsumerState<HerdView> createState() => _HerdViewState();
}

class _HerdViewState extends ConsumerState<HerdView> {
  String _searchText = '';
  AnimalStatus? _selectedStatus;
  AnimalSex? _selectedSex;
  _SortOrder _sortOrder = _SortOrder.tagNumber;

  @override
  Widget build(BuildContext context) {
    final animalsAsync = ref.watch(animalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Herd'),
        leading: IconButton(
          icon: const Icon(Icons.flash_on, color: AppTheme.earthGreen),
          onPressed: () => context.push('/quick-entry'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.earthGreen),
            onPressed: () => context.push('/animal/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: animalsAsync.when(
              data: (animals) {
                final filtered = _filterAndSort(animals);
                if (filtered.isEmpty) {
                  return _buildEmptyState(animals.isEmpty);
                }
                return _buildAnimalList(filtered);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by tag, breed, or notes',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchText = value),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  _hasActiveFilters
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                  color:
                      _hasActiveFilters ? AppTheme.earthGreen : Colors.grey,
                ),
                onPressed: _showFilterSheet,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${_filteredCount} animals',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              PopupMenuButton<_SortOrder>(
                onSelected: (order) => setState(() => _sortOrder = order),
                itemBuilder: (context) => _SortOrder.values
                    .map(
                      (order) => PopupMenuItem(
                        value: order,
                        child: Row(
                          children: [
                            Text(order.label),
                            if (_sortOrder == order)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.check, size: 18),
                              ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                child: Row(
                  children: [
                    Text(
                      'Sort: ${_sortOrder.label}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.earthGreen,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                      color: AppTheme.earthGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_hasActiveFilters) ...[
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (_selectedStatus != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActiveFilterChip(
                        text: _selectedStatus!.label,
                        onRemove: () =>
                            setState(() => _selectedStatus = null),
                      ),
                    ),
                  if (_selectedSex != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActiveFilterChip(
                        text: _selectedSex!.label,
                        onRemove: () => setState(() => _selectedSex = null),
                      ),
                    ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimalList(List<Animal> animals) {
    final withdrawalIds =
        ref.watch(withdrawalAnimalIdsProvider).valueOrNull ?? {};
    return ListView.builder(
      itemCount: animals.length,
      itemBuilder: (context, index) {
        final animal = animals[index];
        return Dismissible(
          key: Key(animal.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (_) async {
            return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete Animal'),
                content: Text(
                    'Delete ${animal.tagNumber}? This cannot be undone.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) async {
            final db = ref.read(databaseProvider);
            await (db.delete(db.animals)
                  ..where((t) => t.id.equals(animal.id)))
                .go();
          },
          child: _AnimalRow(
            animal: animal,
            hasActiveWithdrawal: withdrawalIds.contains(animal.id),
            onTap: () => context.push('/animal/${animal.id}'),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isCompletelyEmpty) {
    return EmptyStateView(
      icon: Icons.pets,
      title: isCompletelyEmpty
          ? 'No animals in your herd'
          : 'No animals match your filters',
      subtitle:
          isCompletelyEmpty ? 'Add your first animal to get started' : null,
      buttonText: isCompletelyEmpty ? 'Add Animal' : 'Clear Filters',
      onButtonTap: isCompletelyEmpty
          ? () => context.push('/animal/new')
          : _clearFilters,
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _FilterSheet(
        selectedStatus: _selectedStatus,
        selectedSex: _selectedSex,
        onStatusChanged: (status) {
          setState(() => _selectedStatus = status);
          Navigator.pop(context);
        },
        onSexChanged: (sex) {
          setState(() => _selectedSex = sex);
          Navigator.pop(context);
        },
        onClear: () {
          _clearFilters();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _searchText = '';
      _selectedStatus = null;
      _selectedSex = null;
    });
  }

  bool get _hasActiveFilters =>
      _searchText.isNotEmpty ||
      _selectedStatus != null ||
      _selectedSex != null;

  int _filteredCount = 0;

  List<Animal> _filterAndSort(List<Animal> animals) {
    var filtered = animals.toList();

    // Search filter
    if (_searchText.isNotEmpty) {
      final search = _searchText.toLowerCase();
      filtered = filtered.where((a) {
        return a.tagNumber.toLowerCase().contains(search) ||
            a.breed.toLowerCase().contains(search) ||
            a.notes.toLowerCase().contains(search);
      }).toList();
    }

    // Status filter
    if (_selectedStatus != null) {
      filtered = filtered.where((a) => a.status == _selectedStatus).toList();
    }

    // Sex filter
    if (_selectedSex != null) {
      filtered = filtered.where((a) => a.sex == _selectedSex).toList();
    }

    // Sort
    switch (_sortOrder) {
      case _SortOrder.tagNumber:
        filtered.sort((a, b) => a.tagNumber.compareTo(b.tagNumber));
        break;
      case _SortOrder.dateOfBirth:
        filtered.sort((a, b) => a.dateOfBirth.compareTo(b.dateOfBirth));
        break;
      case _SortOrder.status:
        filtered.sort((a, b) => a.status.label.compareTo(b.status.label));
        break;
      case _SortOrder.recentlyAdded:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    _filteredCount = filtered.length;
    return filtered;
  }
}

enum _SortOrder {
  tagNumber('Tag #'),
  dateOfBirth('Age'),
  status('Status'),
  recentlyAdded('Recent');

  final String label;
  const _SortOrder(this.label);
}

class _AnimalRow extends StatelessWidget {
  final Animal animal;
  final bool hasActiveWithdrawal;
  final VoidCallback onTap;

  const _AnimalRow({
    required this.animal,
    required this.hasActiveWithdrawal,
    required this.onTap,
  });

  IconData get _sexIcon {
    switch (animal.sex) {
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

  Color get _statusColor {
    switch (animal.status) {
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

  String get _ageDescription {
    final months = DateTime.now().difference(animal.dateOfBirth).inDays ~/ 30;
    if (months < 12) {
      return '$months mo';
    } else {
      final years = months ~/ 12;
      final remainingMonths = months % 12;
      if (remainingMonths == 0) {
        return '$years yr';
      }
      return '$years yr $remainingMonths mo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.standardPadding,
          vertical: 12,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.earthGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_sexIcon, color: AppTheme.earthGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        animal.tagNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (hasActiveWithdrawal) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.orange,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${animal.breed.isEmpty ? 'Unknown breed' : animal.breed} • $_ageDescription',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            StatusBadge(
              text: animal.status.label,
              color: _statusColor,
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final AnimalStatus? selectedStatus;
  final AnimalSex? selectedSex;
  final ValueChanged<AnimalStatus?> onStatusChanged;
  final ValueChanged<AnimalSex?> onSexChanged;
  final VoidCallback onClear;

  const _FilterSheet({
    required this.selectedStatus,
    required this.selectedSex,
    required this.onStatusChanged,
    required this.onSexChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.standardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AnimalStatus.values.map((status) {
              final isSelected = selectedStatus == status;
              return ChoiceChip(
                label: Text(status.label),
                selected: isSelected,
                onSelected: (selected) {
                  onStatusChanged(selected ? status : null);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Sex', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AnimalSex.values.map((sex) {
              final isSelected = selectedSex == sex;
              return ChoiceChip(
                label: Text(sex.label),
                selected: isSelected,
                onSelected: (selected) {
                  onSexChanged(selected ? sex : null);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onClear,
              child: const Text(
                'Clear All Filters',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
