import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/providers.dart';
import '../../services/hc_data_service.dart';
import '../../utils/theme.dart';

String _titleCaseCounty(String raw) {
  final cleaned = raw.replaceAll('_', ' ').trim();
  if (cleaned.isEmpty) return cleaned;
  return cleaned
      .split(RegExp(r'\s+'))
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

Future<void> _openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

// MARK: - County Moisture Card -----------------------------------------------

class CountyMoistureCard extends ConsumerWidget {
  const CountyMoistureCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final county = ref.watch(ranchCountyProvider);
    if (county.trim().isEmpty) return const SizedBox.shrink();

    final moistureAsync = ref.watch(countyMoistureProvider);
    final displayCounty = _titleCaseCounty(county);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.hcParchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.hcTanRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.water_drop, color: AppTheme.hcForest, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$displayCounty County Conditions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.hcInk,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          moistureAsync.when(
            data: (m) => m == null
                ? _noData()
                : _content(m),
            loading: () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text('Loading $displayCounty County data…',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.hcMutedBrown)),
                ],
              ),
            ),
            error: (_, __) => _noData(),
          ),
        ],
      ),
    );
  }

  Widget _noData() => const Text(
        'No current data for this county.',
        style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown),
      );

  Widget _content(CountyMoisture m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _metric(
              'Snowpack',
              m.snowpackPercent != null ? '${m.snowpackPercent}%' : '—',
              m.trend.trim().isEmpty
                  ? 'of 10-yr median'
                  : 'of 10-yr median · 7-day ${m.trend}',
            ),
            _metric(
              'Forage Score',
              m.forageScore != null ? '${m.forageScore}/100' : '—',
              m.forageCategory ?? '',
            ),
            _metric(
              'Water-Year Precip',
              m.precipPercent != null ? '${m.precipPercent}%' : '—',
              'of water-year median',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: AppTheme.hcTanRule),
        const SizedBox(height: 12),
        if (m.droughtClass != null && m.droughtClass!.isNotEmpty)
          Text(
            'Drought class: ${m.droughtClass} '
            '(${CountyMoisture.droughtLabel(m.droughtClass!)})'
            '${m.droughtValidEnd != null ? ' · USDM ${m.droughtValidEnd}' : ''}',
            style: const TextStyle(fontSize: 12, color: AppTheme.hcInk),
          )
        else
          const Text('Drought class: no current USDM reading',
              style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown)),
        if (m.gaugeName != null && m.gaugeName!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Streamflow: ${m.gaugeName}',
              style: const TextStyle(fontSize: 12, color: AppTheme.hcInk)),
          const SizedBox(height: 2),
          Text(
            _streamflowDetail(m),
            style: const TextStyle(fontSize: 11, color: AppTheme.hcMutedBrown),
          ),
        ],
        const SizedBox(height: 8),
        Text('Updated ${m.date}',
            style: const TextStyle(fontSize: 11, color: AppTheme.hcMutedBrown)),
      ],
    );
  }

  String _streamflowDetail(CountyMoisture m) {
    final parts = <String>[];
    if (m.cfs != null) parts.add('${m.cfs!.round()} cfs');
    if (m.streamflowPercentile != null) {
      parts.add(
          '${m.streamflowPercentile}${CountyMoisture.ordinal(m.streamflowPercentile!)} percentile');
    }
    return parts.join(' · ');
  }

  Widget _metric(String title, String value, String subtitle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 11, color: AppTheme.hcMutedBrown)),
          const SizedBox(height: 3),
          Text(value,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.hcInk)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.hcMutedBrown)),
          ],
        ],
      ),
    );
  }
}

// MARK: - HC Weekly Forecast Card --------------------------------------------

class HcWeeklyForecastCard extends ConsumerWidget {
  const HcWeeklyForecastCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hcForecastProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.find_in_page_outlined,
                color: AppTheme.earthGreen, size: 18),
            SizedBox(width: 6),
            Text('HC Weekly Forecast',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.earthGreen)),
          ],
        ),
        const SizedBox(height: 12),
        async.when(
          data: (f) {
            if (f == null || f.weeks.isEmpty) {
              return const _ForecastUnavailable();
            }
            final week = f.weeks.first;
            return InkWell(
              onTap: () => _openUrl(week.sourceUrl),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.07),
                        blurRadius: 6,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 11, color: AppTheme.earthGreen),
                                  const SizedBox(width: 4),
                                  Text(
                                    _longDate(week.asOf),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.earthGreen),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                week.sourceTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.hcInk),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right,
                            size: 18, color: Colors.grey),
                      ],
                    ),
                    if (week.classNote.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        week.classNote,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.hcMutedBrown),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
          loading: () => const _ForecastLoading(),
          error: (_, __) => const _ForecastUnavailable(),
        ),
      ],
    );
  }
}

// MARK: - Quarterly Calf Price Forecast Card ---------------------------------

class QuarterlyForecastCard extends ConsumerStatefulWidget {
  const QuarterlyForecastCard({super.key});

  @override
  ConsumerState<QuarterlyForecastCard> createState() =>
      _QuarterlyForecastCardState();
}

class _QuarterlyForecastCardState extends ConsumerState<QuarterlyForecastCard> {
  String? _selectedWeek;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(hcForecastProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.bar_chart, color: AppTheme.hcForest, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text('Quarterly Calf Price Forecast',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.hcInk)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          async.when(
            data: (f) {
              if (f == null || f.weeks.isEmpty) {
                return const _ForecastUnavailable();
              }
              final weeks = f.weeks.take(4).toList();
              final selectedId = _selectedWeek ?? weeks.first.asOf;
              final week = weeks.firstWhere((w) => w.asOf == selectedId,
                  orElse: () => weeks.first);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (weeks.length > 1) ...[
                    _weekPicker(weeks, selectedId),
                    const SizedBox(height: 12),
                  ],
                  if (week.classNote.isNotEmpty) ...[
                    Text(week.classNote,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.hcMutedBrown)),
                    const SizedBox(height: 12),
                  ],
                  for (final q in week.quarters) ...[
                    _quarterBlock(q),
                    const SizedBox(height: 12),
                  ],
                  InkWell(
                    onTap: () => _openUrl(week.sourceUrl),
                    child: Row(
                      children: [
                        Text('Updated ${week.asOf}  ·  ',
                            style: const TextStyle(
                                fontSize: 11, color: AppTheme.hcMutedBrown)),
                        const Text('Open full forecast',
                            style: TextStyle(
                                fontSize: 11, color: AppTheme.skyBlue)),
                        const SizedBox(width: 3),
                        const Icon(Icons.open_in_new,
                            size: 11, color: AppTheme.skyBlue),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const _ForecastLoading(),
            error: (_, __) => const _ForecastUnavailable(),
          ),
        ],
      ),
    );
  }

  Widget _weekPicker(List<ForecastWeek> weeks, String selectedId) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<String>(
        showSelectedIcon: false,
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12)),
        ),
        segments: [
          for (final w in weeks)
            ButtonSegment(
              value: w.asOf,
              label: Text(_shortLabel(w.asOf)),
            ),
        ],
        selected: {selectedId},
        onSelectionChanged: (s) => setState(() => _selectedWeek = s.first),
      ),
    );
  }

  Widget _quarterBlock(ForecastQuarter q) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(q.label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const Spacer(),
              _statusChip(q),
            ],
          ),
          const SizedBox(height: 6),
          _bandRow('Steer', q.steer),
          const SizedBox(height: 4),
          _bandRow('Heifer', q.heifer),
        ],
      ),
    );
  }

  Widget _bandRow(String label, PriceBand? band) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown)),
        ),
        if (band != null) ...[
          Text(band.rangeText,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.hcInk)),
          const Spacer(),
          if (band.midText != null)
            Text(band.midText!,
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.hcMutedBrown)),
        ] else
          const Text('—',
              style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown)),
      ],
    );
  }

  Widget _statusChip(ForecastQuarter q) {
    final raw = q.status.toUpperCase();
    Color bg, fg;
    if (raw.contains('UP') || raw.contains('RAISE') || raw.contains('HIGHER')) {
      bg = Colors.green.withValues(alpha: 0.18);
      fg = Colors.green.shade700;
    } else if (raw.contains('DOWN') ||
        raw.contains('LOWER') ||
        raw.contains('CUT')) {
      bg = Colors.orange.withValues(alpha: 0.18);
      fg = Colors.orange.shade800;
    } else {
      bg = Colors.grey.withValues(alpha: 0.18);
      fg = Colors.grey.shade700;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(q.displayStatus,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w800, color: fg)),
    );
  }

  String _shortLabel(String iso) =>
      iso.length >= 10 ? iso.substring(5) : iso;
}

// MARK: - Shared small states ------------------------------------------------

String _longDate(String iso) {
  final d = DateTime.tryParse(iso);
  if (d == null) return iso;
  return DateFormat.yMMMMd().format(d);
}

class _ForecastLoading extends StatelessWidget {
  const _ForecastLoading();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 8),
            Text('Loading forecast…',
                style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown)),
          ],
        ),
      );
}

class _ForecastUnavailable extends StatelessWidget {
  const _ForecastUnavailable();
  @override
  Widget build(BuildContext context) => const Text(
        'Forecast unavailable. Pull to refresh.',
        style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown),
      );
}
