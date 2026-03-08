import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import '../models/database.dart';

enum ConnectionStatus {
  online,
  offline,
}

class SyncService {
  final AppDatabase _database;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  ConnectionStatus _connectionStatus = ConnectionStatus.offline;
  ConnectionStatus get connectionStatus => _connectionStatus;

  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  final _syncStatusController = StreamController<ConnectionStatus>.broadcast();
  Stream<ConnectionStatus> get syncStatusStream => _syncStatusController.stream;

  SyncService(this._database);

  Future<void> initialize() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet);

    _connectionStatus =
        hasConnection ? ConnectionStatus.online : ConnectionStatus.offline;
    _syncStatusController.add(_connectionStatus);

    // Auto-sync when coming back online
    if (hasConnection && !_isSyncing) {
      syncPendingChanges();
    }
  }

  Future<void> queueChange({
    required String syncTableName,
    required String recordId,
    required String operation,
    required String data,
  }) async {
    await _database.into(_database.syncQueue).insert(
          SyncQueueCompanion.insert(
            syncTableName: syncTableName,
            recordId: recordId,
            operation: operation,
            data: data,
            createdAt: DateTime.now(),
          ),
        );

    // Try to sync immediately if online
    if (_connectionStatus == ConnectionStatus.online) {
      syncPendingChanges();
    }
  }

  Future<int> getPendingChangesCount() async {
    final result = await _database.select(_database.syncQueue).get();
    return result.length;
  }

  Future<void> syncPendingChanges() async {
    if (_isSyncing || _connectionStatus == ConnectionStatus.offline) return;

    _isSyncing = true;

    try {
      final pendingItems = await _database.select(_database.syncQueue).get();

      for (final item in pendingItems) {
        try {
          // In a real app, this would call an API
          // For now, we just mark items as synced
          await _processSync(item);

          // Remove from queue after successful sync
          await (_database.delete(_database.syncQueue)
                ..where((t) => t.id.equals(item.id)))
              .go();
        } catch (e) {
          // Increment retry count
          await (_database.update(_database.syncQueue)
                ..where((t) => t.id.equals(item.id)))
              .write(
            SyncQueueCompanion(
              retryCount: Value(item.retryCount + 1),
            ),
          );
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processSync(SyncQueueData item) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // In a real app, this would:
    // 1. Parse the JSON data
    // 2. Call the appropriate API endpoint
    // 3. Handle conflicts
    // 4. Update local record with server response

    // For now, we just succeed
  }

  Future<void> clearSyncQueue() async {
    await _database.delete(_database.syncQueue).go();
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _syncStatusController.close();
  }
}
