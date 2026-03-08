import 'dart:async';

/// Placeholder BLE service for RFID reader and smart tag integration
/// This provides the interface for future Bluetooth device pairing
class BleService {
  bool _isScanning = false;
  bool _isConnected = false;
  String? _connectedDeviceId;
  String? _connectedDeviceName;

  final _deviceController = StreamController<BleDevice>.broadcast();
  final _dataController = StreamController<BleData>.broadcast();

  Stream<BleDevice> get discoveredDevices => _deviceController.stream;
  Stream<BleData> get incomingData => _dataController.stream;

  bool get isScanning => _isScanning;
  bool get isConnected => _isConnected;
  String? get connectedDeviceId => _connectedDeviceId;
  String? get connectedDeviceName => _connectedDeviceName;

  /// Start scanning for nearby BLE devices
  Future<void> startScan({Duration? timeout}) async {
    if (_isScanning) return;

    _isScanning = true;
    // In a real implementation, this would use flutter_blue_plus to scan

    // Simulate device discovery
    await Future.delayed(const Duration(seconds: 1));

    // Emit mock devices for demonstration
    _deviceController.add(BleDevice(
      id: 'rfid_001',
      name: 'RFID Reader Pro',
      type: BleDeviceType.rfidReader,
      rssi: -45,
    ));

    _deviceController.add(BleDevice(
      id: 'smarttag_001',
      name: 'CattleTag S1',
      type: BleDeviceType.smartTag,
      rssi: -60,
    ));

    // Auto-stop scan after timeout
    if (timeout != null) {
      Future.delayed(timeout, stopScan);
    }
  }

  /// Stop scanning for devices
  Future<void> stopScan() async {
    _isScanning = false;
  }

  /// Connect to a BLE device
  Future<bool> connect(String deviceId) async {
    await stopScan();

    // Simulate connection
    await Future.delayed(const Duration(seconds: 1));

    _isConnected = true;
    _connectedDeviceId = deviceId;
    _connectedDeviceName = deviceId.startsWith('rfid') ? 'RFID Reader Pro' : 'CattleTag S1';

    return true;
  }

  /// Disconnect from current device
  Future<void> disconnect() async {
    _isConnected = false;
    _connectedDeviceId = null;
    _connectedDeviceName = null;
  }

  /// Request RFID scan from connected reader
  Future<RfidScanResult?> requestRfidScan() async {
    if (!_isConnected) return null;

    // Simulate RFID scan
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data
    return RfidScanResult(
      tagId: '840${DateTime.now().millisecondsSinceEpoch % 100000000}',
      timestamp: DateTime.now(),
      signalStrength: -35,
    );
  }

  /// Get latest reading from smart tag
  Future<BleSmartTagReading?> getSmartTagReading() async {
    if (!_isConnected) return null;

    // Simulate reading
    await Future.delayed(const Duration(milliseconds: 300));

    return BleSmartTagReading(
      tagId: _connectedDeviceId!,
      timestamp: DateTime.now(),
      temperature: 101.5 + (DateTime.now().millisecond % 10) / 10,
      activityLevel: 50 + (DateTime.now().second % 50),
      batteryLevel: 85,
      latitude: 46.8797 + (DateTime.now().millisecond % 100) / 10000,
      longitude: -110.3626 + (DateTime.now().millisecond % 100) / 10000,
    );
  }

  /// Set up health alert thresholds for smart tag
  Future<bool> configureSmartTagAlerts({
    required double tempLow,
    required double tempHigh,
    required int activityLow,
  }) async {
    if (!_isConnected) return false;

    // Simulate configuration
    await Future.delayed(const Duration(milliseconds: 200));

    return true;
  }

  void dispose() {
    _deviceController.close();
    _dataController.close();
  }
}

enum BleDeviceType {
  rfidReader,
  smartTag,
  unknown,
}

class BleDevice {
  final String id;
  final String name;
  final BleDeviceType type;
  final int rssi;

  BleDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.rssi,
  });

  String get signalQuality {
    if (rssi >= -50) return 'Excellent';
    if (rssi >= -70) return 'Good';
    if (rssi >= -85) return 'Fair';
    return 'Poor';
  }
}

class BleData {
  final String deviceId;
  final String type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  BleData({
    required this.deviceId,
    required this.type,
    required this.data,
    required this.timestamp,
  });
}

class RfidScanResult {
  final String tagId;
  final DateTime timestamp;
  final int signalStrength;

  RfidScanResult({
    required this.tagId,
    required this.timestamp,
    required this.signalStrength,
  });

  /// Parse 15-digit EID tag format
  String get countryCode => tagId.length >= 3 ? tagId.substring(0, 3) : '';
  String get animalId => tagId.length >= 15 ? tagId.substring(3) : tagId;
}

class BleSmartTagReading {
  final String tagId;
  final DateTime timestamp;
  final double temperature; // Fahrenheit
  final int activityLevel; // 0-100
  final int batteryLevel; // 0-100
  final double? latitude;
  final double? longitude;

  BleSmartTagReading({
    required this.tagId,
    required this.timestamp,
    required this.temperature,
    required this.activityLevel,
    required this.batteryLevel,
    this.latitude,
    this.longitude,
  });

  bool get hasLocation => latitude != null && longitude != null;

  bool get isTemperatureNormal => temperature >= 100.5 && temperature <= 103.5;

  String get temperatureStatus {
    if (temperature < 100.5) return 'Low';
    if (temperature > 103.5) return 'High';
    return 'Normal';
  }

  String get activityStatus {
    if (activityLevel < 20) return 'Low';
    if (activityLevel > 80) return 'High';
    return 'Normal';
  }
}
