import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/herd/herd_view.dart';
import '../views/herd/animal_form_view.dart';
import '../views/herd/animal_detail_view.dart';
import '../views/herd/quick_entry_view.dart';
import '../views/market/market_view.dart';
import '../views/weather/weather_view.dart';
import '../views/tools/breakeven_calculator_view.dart';
import '../views/tools/dosage_calculator_view.dart';
import '../views/tools/weight_estimator_view.dart';
import '../views/tools/pork_lookup_view.dart';
import '../views/tools/net_to_gate_view.dart';
import '../views/settings/settings_view.dart';
import '../views/pastures/pastures_view.dart';
import '../views/tasks/tasks_view.dart';
import '../views/analytics/analytics_view.dart';
import '../views/chute_side/chute_side_view.dart';
import '../views/scanner/scanner_view.dart';
import 'shell_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellView(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardView(),
          ),
        ),
        GoRoute(
          path: '/market',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MarketView(),
          ),
        ),
        GoRoute(
          path: '/calculator',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: NetToGateView(),
          ),
        ),
        GoRoute(
          path: '/weather',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: WeatherView(),
          ),
        ),
        GoRoute(
          path: '/herd',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HerdView(),
          ),
        ),
      ],
    ),
    // Animal routes
    GoRoute(
      path: '/animal/new',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final tagNumber = state.uri.queryParameters['tagNumber'];
        return AnimalFormView(initialTagNumber: tagNumber);
      },
    ),
    GoRoute(
      path: '/animal/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => AnimalDetailView(
        animalId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/animal/:id/edit',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => AnimalFormView(
        animalId: state.pathParameters['id'],
      ),
    ),
    GoRoute(
      path: '/quick-entry',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const QuickEntryView(),
    ),
    // Tool routes
    GoRoute(
      path: '/tools/breakeven',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BreakevenCalculatorView(),
    ),
    GoRoute(
      path: '/tools/dosage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DosageCalculatorView(),
    ),
    GoRoute(
      path: '/tools/weight',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WeightEstimatorView(),
    ),
    GoRoute(
      path: '/tools/pork',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PorkLookupView(),
    ),
    // Settings
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsView(),
    ),
    // Pastures
    GoRoute(
      path: '/pastures',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PasturesView(),
    ),
    // Tasks
    GoRoute(
      path: '/tasks',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TasksView(),
    ),
    // Analytics
    GoRoute(
      path: '/analytics',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AnalyticsView(),
    ),
    // Chute-side entry
    GoRoute(
      path: '/chute-side',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ChuteSideView(),
    ),
    // Scanner
    GoRoute(
      path: '/scanner',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ScannerView(),
    ),
  ],
);
