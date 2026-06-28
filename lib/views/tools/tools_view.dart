import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({super.key});

  @override
  State<ToolsView> createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> {
  final Map<String, bool> _expandedCards = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tools')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Calculators'),
            Row(
              children: [
                _ToolCard(
                  title: 'Breakeven',
                  subtitle: 'Calculate selling price',
                  icon: Icons.attach_money,
                  color: AppTheme.earthGreen,
                  onTap: () => context.push('/tools/breakeven'),
                ),
                const SizedBox(width: 12),
                _ToolCard(
                  title: 'Dosage',
                  subtitle: 'Drug calculations',
                  icon: Icons.medical_services,
                  color: Colors.blue,
                  onTap: () => context.push('/tools/dosage'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _ToolCard(
                  title: 'Weight',
                  subtitle: 'Tape estimate',
                  icon: Icons.monitor_weight,
                  color: AppTheme.warmBrown,
                  onTap: () => context.push('/tools/weight'),
                ),
                const SizedBox(width: 12),
                _ToolCard(
                  title: 'Calf Check',
                  subtitle: 'Net to your gate',
                  icon: Icons.payments,
                  color: const Color(0xFF5C6B34), // HC olive — matches the calculator
                  onTap: () => context.push('/tools/calculator'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Quick Reference'),
            _ReferenceCard(
              title: 'Calving Ease Scores',
              items: const [
                '1 - No assistance required',
                '2 - Easy pull (one person)',
                '3 - Mechanical assistance',
                '4 - Hard pull (multiple people)',
                '5 - Cesarean section',
              ],
              isExpanded: _expandedCards['calving'] ?? false,
              onToggle: () => setState(() {
                _expandedCards['calving'] = !(_expandedCards['calving'] ?? false);
              }),
            ),
            const SizedBox(height: 12),
            _ReferenceCard(
              title: 'Body Condition Scores',
              items: const [
                '1 - Emaciated',
                '3 - Thin',
                '5 - Moderate',
                '7 - Good',
                '9 - Obese',
              ],
              isExpanded: _expandedCards['bcs'] ?? false,
              onToggle: () => setState(() {
                _expandedCards['bcs'] = !(_expandedCards['bcs'] ?? false);
              }),
            ),
            const SizedBox(height: 12),
            _ReferenceCard(
              title: 'Common Withdrawal Times',
              items: const [
                'Draxxin - 18 days (meat)',
                'Excede - 13 days',
                'LA-200 - 28 days',
                'Dectomax - 35 days',
                'Banamine - 4 days',
                'Nuflor - 28 days',
              ],
              isExpanded: _expandedCards['withdrawal'] ?? false,
              onToggle: () => setState(() {
                _expandedCards['withdrawal'] =
                    !(_expandedCards['withdrawal'] ?? false);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _ReferenceCard({
    required this.title,
    required this.items,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
