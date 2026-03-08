import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/theme.dart';
import 'utils/router.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: HonestCattleApp(),
    ),
  );
}

class HonestCattleApp extends ConsumerStatefulWidget {
  const HonestCattleApp({super.key});

  @override
  ConsumerState<HonestCattleApp> createState() => _HonestCattleAppState();
}

class _HonestCattleAppState extends ConsumerState<HonestCattleApp> {
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    // Initialize notification service
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.initialize();

    // Initialize sync service
    final syncService = ref.read(syncServiceProvider);
    await syncService.initialize();

    // Request location
    final locationService = ref.read(locationServiceProvider);
    await locationService.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HonestCattle',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
