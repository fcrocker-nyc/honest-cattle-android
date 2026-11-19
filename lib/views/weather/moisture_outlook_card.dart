import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/moisture_outlook.dart';
import '../../providers/providers.dart';
import '../../services/hc_data_service.dart';
import '../../utils/theme.dart';

// Moisture Outlook Card — Android port of the iOS MoistureOutlookCard.
//
// The rolling 1 / 3 / 6 / 12-month precipitation outlook for the ranch's
// county: expected inches against the 1991–2020 normal, how far each horizon
// leans, and how much weight to put on it.
//
// The design problem this card has to solve is that the long rows look like
// forecasts and are not. NOAA's 12-month row is mostly normal weather
// restated, and a number rendered the same way as the 1-month row invites a
// rancher to plan hay or stocking against noise. So every row carries its own
// confidence, the weak rows are visually demoted rather than hidden, and the
// footer says plainly which rows are worth acting on.
//
// Color discipline matches CountyMoistureCard: explicit HC palette only.

class MoistureOutlookCard extends ConsumerWidget {
  /// Compact mode drops the odds, spring and temperature rows — used on the
  /// dashboard, where the card sits under the daily conditions card.
  final bool compact;

  /// With no ranch county set the card has nothing to show. On the dashboard
  /// it disappears (a settings tip already sits above it); on the Weather
  /// screen it says what to set instead, so the feature isn't invisible.
  final bool showsSetupPrompt;

  const MoistureOutlookCard({
    super.key,
    this.compact = false,
    this.showsSetupPrompt = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final county = ref.watch(ranchCountyProvider).trim();

    if (county.isEmpty) {
      if (!showsSetupPrompt) return const SizedBox.shrink();
      return _shell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 8),
            const Text(
              'Set your ranch county in Settings to see the 1-, 3-, 6- and '
              '12-month precipitation outlook for your ground.',
              style: TextStyle(fontSize: 12, color: AppTheme.hcMutedBrown),
            ),
          ],
        ),
      );
    }

    final feedAsync = ref.watch(moistureOutlookFeedProvider);
    final key = HcDataService.normalizeCountyName(county);

    return feedAsync.when(
      loading: () => _shell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(
                  'Loading $county County outlook…',
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.hcMutedBrown),
                ),
              ],
            ),
          ],
        ),
      ),
      error: (_, _) => _message(
        'Could not load the moisture outlook. Check your connection and pull '
        'to refresh.',
        isError: true,
      ),
      data: (feed) {
        if (feed == null) {
          return _message(
            'Could not load the moisture outlook. Check your connection and '
            'pull to refresh.',
            isError: true,
          );
        }
        final outlook = feed.forKey(key);
        if (outlook == null) {
          // A county with no outlook is a different thing from a failed
          // fetch, and has to read that way.
          return _message(
            'No outlook published for $county County yet. The rolling '
            'outlook currently covers Montana counties.',
          );
        }
        return _shell(child: _content(outlook));
      },
    );
  }

  // ---- Chrome --------------------------------------------------------------

  Widget _shell({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.hcParchment,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.hcTanRule),
        ),
        child: child,
      );

  Widget _message(String text, {bool isError = false}) => _shell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isError ? AppTheme.hcAlert : AppTheme.hcMutedBrown,
              ),
            ),
          ],
        ),
      );

  Widget _header() => const Row(
        children: [
          Icon(Icons.visibility, color: AppTheme.hcForest, size: 18),
          SizedBox(width: 8),
          Text(
            'Moisture Outlook',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.hcInk,
            ),
          ),
        ],
      );

  // ---- Body ----------------------------------------------------------------

  Widget _content(MoistureOutlook o) {
    final rows = <Widget>[];
    for (final h in o.horizons) {
      rows.add(const Divider(height: 1, color: AppTheme.hcTanRule));
      rows.add(_horizonRow(h));
    }

    final odds = o.odds3Month;
    final three = o.threeMonth;
    final spring = o.springGrowingSeason;
    final temp = o.temperatureNote;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const SizedBox(height: 12),
        Text(
          o.headline,
          style: const TextStyle(fontSize: 13, color: AppTheme.hcInk),
        ),
        const SizedBox(height: 12),
        _columnHeader(),
        ...rows,
        if (!compact) ...[
          if (odds != null) ...[
            const Divider(height: 1, color: AppTheme.hcTanRule),
            _oddsLine(three?.window ?? 'Next 3 months', odds),
          ],
          if (spring != null) _springLine(spring),
          if (temp != null && temp.isNotEmpty) _temperatureLine(temp),
        ],
        _footer(o),
      ],
    );
  }

  Widget _columnHeader() => const Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            SizedBox(
              width: 62,
              child: Text('HORIZON', style: _colStyle),
            ),
            Expanded(
              child: Text('EXPECTED',
                  textAlign: TextAlign.right, style: _colStyle),
            ),
            Expanded(
              child:
                  Text('NORMAL', textAlign: TextAlign.right, style: _colStyle),
            ),
            SizedBox(
              width: 58,
              child:
                  Text('% NORM', textAlign: TextAlign.right, style: _colStyle),
            ),
          ],
        ),
      );

  static const _colStyle = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.5,
    color: AppTheme.hcMutedBrown,
  );

  Widget _horizonRow(MoistureHorizon h) {
    // Weak horizons are dimmed rather than dropped: the rancher should see
    // that the 12-month number exists and that it carries little weight.
    final dim = h.weight == MoistureWeight.planningBaseline;
    final caveat = h.weight.caveat;
    final lean = h.lean;
    final showLean = lean != null &&
        lean.isNotEmpty &&
        lean.toLowerCase() != 'no clear signal';
    final window = h.window;

    return Opacity(
      opacity: dim ? 0.62 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 62,
                  child: Text(
                    h.months == 1 ? '1 mo' : '${h.months} mo',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.hcInk,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${h.expectedIn.toStringAsFixed(2)} in',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFeatures: [FontFeature.tabularFigures()],
                      color: AppTheme.hcInk,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    h.normalIn.toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFeatures: [FontFeature.tabularFigures()],
                      color: AppTheme.hcMutedBrown,
                    ),
                  ),
                ),
                SizedBox(
                  width: 58,
                  child: Text(
                    '${h.percentOfNormal}%',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: _tiltColor(h.tilt),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                if (window != null && window.isNotEmpty)
                  Flexible(
                    child: Text(
                      window,
                      style: const TextStyle(
                          fontSize: 10, color: AppTheme.hcMutedBrown),
                    ),
                  ),
                if (caveat != null) ...[
                  const Text(' · ',
                      style:
                          TextStyle(fontSize: 10, color: AppTheme.hcTanRule)),
                  Flexible(
                    child: Text(
                      caveat,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.hcSaddle,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (showLean)
                  Text(
                    lean,
                    style: const TextStyle(
                        fontSize: 10, color: AppTheme.hcMutedBrown),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _tiltColor(MoistureTilt t) => switch (t) {
        MoistureTilt.wellBelow => AppTheme.hcAlert,
        MoistureTilt.below => AppTheme.hcSaddle,
        MoistureTilt.nearNormal => AppTheme.hcInk,
        MoistureTilt.above || MoistureTilt.wellAbove => AppTheme.hcForest,
      };

  // ---- Supporting lines ----------------------------------------------------

  Widget _iconLine({
    required IconData icon,
    required Color iconColor,
    required List<Widget> lines,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 14,
              child: Icon(icon, size: 11, color: iconColor),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lines,
              ),
            ),
          ],
        ),
      );

  Widget _oddsLine(String window, MoistureOdds odds) => _iconLine(
        icon: Icons.percent,
        iconColor: AppTheme.hcMutedBrown,
        lines: [
          Text(
            odds.summary,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.hcInk,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            odds.isCoinFlip
                ? '$window — close to even, no real signal'
                : window,
            style:
                const TextStyle(fontSize: 10, color: AppTheme.hcMutedBrown),
          ),
        ],
      );

  Widget _springLine(MoistureSpring s) => _iconLine(
        icon: Icons.eco,
        iconColor: AppTheme.hcForest,
        lines: [
          Text(
            'Spring growing season · ${s.window}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.hcInk,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            '${s.expectedIn.toStringAsFixed(2)} in expected vs '
            '${s.normalIn.toStringAsFixed(2)} normal (${s.pctOfNormal}%) · '
            '${s.drier}% drier · ${s.near}% near · ${s.wetter}% wetter',
            style:
                const TextStyle(fontSize: 10, color: AppTheme.hcMutedBrown),
          ),
        ],
      );

  Widget _temperatureLine(String note) => _iconLine(
        icon: Icons.thermostat,
        iconColor: AppTheme.hcSaddle,
        lines: [
          Text(
            note,
            style:
                const TextStyle(fontSize: 10, color: AppTheme.hcMutedBrown),
          ),
        ],
      );

  // ---- Footer --------------------------------------------------------------

  Widget _footer(MoistureOutlook o) {
    final issued = o.issuedLine;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Divider(height: 1, color: AppTheme.hcTanRule),
        ),
        const Text(
          'A tilt in the odds, not a promise. The 1- and 3-month rows are '
          'usable guidance; the 6- and 12-month rows are a planning baseline '
          'that mostly reflects normal weather.',
          style: TextStyle(fontSize: 10, color: AppTheme.hcMutedBrown),
        ),
        if (!compact) ...[
          const SizedBox(height: 3),
          const Text(
            'County-wide averages include mountain ground, so valley and '
            'bench ranches usually receive less. Percent of normal carries '
            'over better than the inches.',
            style: TextStyle(fontSize: 10, color: AppTheme.hcMutedBrown),
          ),
        ],
        if (issued != null) ...[
          const SizedBox(height: 4),
          Text(
            issued,
            style: const TextStyle(fontSize: 9, color: AppTheme.hcMutedBrown),
          ),
        ],
      ],
    );
  }
}
