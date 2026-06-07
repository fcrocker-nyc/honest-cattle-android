import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme.dart';

class ShellView extends StatelessWidget {
  final Widget child;

  const ShellView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.creamBackground,
        selectedItemColor: AppTheme.earthGreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Herd',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Tools',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/market')) return 1;
    if (location.startsWith('/weather')) return 2;
    if (location.startsWith('/herd')) return 3;
    if (location.startsWith('/tools')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/market');
        break;
      case 2:
        context.go('/weather');
        break;
      case 3:
        context.go('/herd');
        break;
      case 4:
        context.go('/tools');
        break;
    }
  }
}
