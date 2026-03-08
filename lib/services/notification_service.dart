import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }

  Future<bool> requestPermission() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final iOS = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    if (android != null) {
      await android.requestNotificationsPermission();
    }

    if (iOS != null) {
      await iOS.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    return true;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'honest_cattle_channel',
      'HonestCattle Notifications',
      channelDescription: 'Notifications for HonestCattle app',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'honest_cattle_channel',
      'HonestCattle Notifications',
      channelDescription: 'Notifications for HonestCattle app',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Use zonedSchedule for scheduled notifications
    // For simplicity, using show here
    await _notifications.show(id, title, body, details, payload: payload);
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Cattle-specific notifications
  Future<void> notifyCalvingPrediction({
    required String animalTag,
    required DateTime predictedDate,
  }) async {
    await showNotification(
      id: animalTag.hashCode,
      title: 'Calving Alert',
      body:
          'Animal $animalTag expected to calve around ${_formatDate(predictedDate)}',
      payload: 'calving:$animalTag',
    );
  }

  Future<void> notifyBreedingReminder({
    required String animalTag,
    required DateTime breedingDate,
  }) async {
    await showNotification(
      id: animalTag.hashCode + 1000,
      title: 'Breeding Reminder',
      body: 'Animal $animalTag may be in heat around ${_formatDate(breedingDate)}',
      payload: 'breeding:$animalTag',
    );
  }

  Future<void> notifyWithdrawalComplete({
    required String animalTag,
    required String treatment,
  }) async {
    await showNotification(
      id: animalTag.hashCode + 2000,
      title: 'Withdrawal Complete',
      body: 'Animal $animalTag is now clear from $treatment withdrawal',
      payload: 'withdrawal:$animalTag',
    );
  }

  Future<void> notifyPriceAlert({
    required String alertType,
    required double price,
    required double targetPrice,
    required bool isAbove,
  }) async {
    final direction = isAbove ? 'above' : 'below';
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'Price Alert: $alertType',
      body:
          'Price (\$${price.toStringAsFixed(2)}) is now $direction your target (\$${targetPrice.toStringAsFixed(2)})',
      payload: 'price_alert',
    );
  }

  Future<void> notifySevereWeather({
    required String description,
    required DateTime date,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100000 + 50000,
      title: 'Severe Weather Alert',
      body: '$description expected on ${_formatDate(date)}',
      payload: 'weather_alert',
    );
  }

  Future<void> notifyTaskDue({
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    await showNotification(
      id: taskTitle.hashCode,
      title: 'Task Due',
      body: '$taskTitle is due ${_formatDate(dueDate)}',
      payload: 'task:$taskTitle',
    );
  }

  Future<void> notifyHealthAlert({
    required String animalTag,
    required String alertType,
    required String message,
  }) async {
    await showNotification(
      id: animalTag.hashCode + 3000,
      title: 'Health Alert: $animalTag',
      body: message,
      payload: 'health:$animalTag',
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
