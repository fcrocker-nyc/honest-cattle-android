import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../utils/theme.dart';
import '../../providers/providers.dart';
import '../../models/cattle_valuation.dart';

/// Editor for the reference prices that drive herd valuation, structured to
/// mirror the Honest Cattle Weekly Forecast. Can pull the latest published
/// bands with one tap; every field stays editable.
class MarketPricesView extends ConsumerStatefulWidget {
  const MarketPricesView({super.key});

  @override
  ConsumerState<MarketPricesView> createState() => _MarketPricesViewState();
}

class _MarketPricesViewState extends ConsumerState<MarketPricesView> {
  late final Map<String, TextEditingController> _c;
  bool _updating = false;
  String? _error;
  late String _quarterLabel;
  late DateTime _asOf;
  late String _sourceNote;

  @override
  void initState() {
    super.initState();
    final b = ref.read(priceBookProvider);
    _c = {
      'steerMid550': TextEditingController(text: _fmt(b.steerMid550)),
      'steerMid600': TextEditingController(text: _fmt(b.steerMid600)),
      'heiferMid550': TextEditingController(text: _fmt(b.heiferMid550)),
      'heiferMid600': TextEditingController(text: _fmt(b.heiferMid600)),
      'bredHeiferPrice': TextEditingController(text: _fmt(b.bredHeiferPrice)),
      'bredCowPrice': TextEditingController(text: _fmt(b.bredCowPrice)),
      'cullCowPrice': TextEditingController(text: _fmt(b.cullCowPrice)),
      'bullPrice': TextEditingController(text: _fmt(b.bullPrice)),
      'fedPrice': TextEditingController(text: _fmt(b.fedPrice)),
      'fedThresholdWeight': TextEditingController(text: _fmt(b.fedThresholdWeight)),
      'assumedDailyGain': TextEditingController(text: _fmt(b.assumedDailyGain)),
    };
    _quarterLabel = b.quarterLabel;
    _asOf = b.asOfDate;
    _sourceNote = b.sourceNote;
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  double _val(String key) => double.tryParse(_c[key]!.text.trim()) ?? 0;

  PriceBook _bookFromControllers() {
    final b = ref.read(priceBookProvider).copy();
    b.steerMid550 = _val('steerMid550');
    b.steerMid600 = _val('steerMid600');
    b.heiferMid550 = _val('heiferMid550');
    b.heiferMid600 = _val('heiferMid600');
    b.bredHeiferPrice = _val('bredHeiferPrice');
    b.bredCowPrice = _val('bredCowPrice');
    b.cullCowPrice = _val('cullCowPrice');
    b.bullPrice = _val('bullPrice');
    b.fedPrice = _val('fedPrice');
    b.fedThresholdWeight = _val('fedThresholdWeight');
    b.assumedDailyGain = _val('assumedDailyGain');
    b.quarterLabel = _quarterLabel;
    b.asOfDate = _asOf;
    b.sourceNote = _sourceNote;
    return b;
  }

  Future<void> _updateFromForecast() async {
    setState(() {
      _updating = true;
      _error = null;
    });
    final ok = await ref.read(priceBookProvider.notifier).refreshFromForecast();
    if (!mounted) return;
    if (ok) {
      final b = ref.read(priceBookProvider);
      setState(() {
        _c['steerMid550']!.text = _fmt(b.steerMid550);
        _c['steerMid600']!.text = _fmt(b.steerMid600);
        _c['heiferMid550']!.text = _fmt(b.heiferMid550);
        _c['heiferMid600']!.text = _fmt(b.heiferMid600);
        _c['bredHeiferPrice']!.text = _fmt(b.bredHeiferPrice);
        _c['bredCowPrice']!.text = _fmt(b.bredCowPrice);
        _c['cullCowPrice']!.text = _fmt(b.cullCowPrice);
        _quarterLabel = b.quarterLabel;
        _asOf = b.asOfDate;
        _sourceNote = b.sourceNote;
        _updating = false;
      });
    } else {
      setState(() {
        _error = "Couldn't reach the forecast. Showing last saved prices.";
        _updating = false;
      });
    }
  }

  void _done() {
    ref.read(priceBookProvider.notifier).replace(_bookFromControllers());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final asOfStr = DateFormat.yMMMd().format(_asOf);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices'),
        actions: [
          TextButton(
            onPressed: _done,
            child: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _updating ? null : _updateFromForecast,
              icon: _updating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.download),
              label: Text(_updating
                  ? 'Updating…'
                  : 'Update from HC Weekly Forecast'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_quarterLabel · $_sourceNote\nPriced as of $asOfStr. These are estimates from the published forecast bands — edit any field to match your own local market.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          if (_error != null) ...[
            const SizedBox(height: 6),
            Text(_error!,
                style: const TextStyle(fontSize: 12, color: Colors.red)),
          ],
          _section('Calf Mids — Steer (\$/cwt)'),
          _priceField('steerMid550', '550–599 lb', '\$/cwt'),
          _priceField('steerMid600', '600–649 lb', '\$/cwt'),
          _section('Calf Mids — Heifer (\$/cwt)'),
          _priceField('heiferMid550', '550–599 lb', '\$/cwt'),
          _priceField('heiferMid600', '600–649 lb', '\$/cwt'),
          _section('Bred Females (\$/head)'),
          _priceField('bredHeiferPrice', 'Bred heifer', '\$/hd'),
          _priceField('bredCowPrice', 'Bred cow (running age)', '\$/hd'),
          _section('Cull, Bull & Finished'),
          _priceField('cullCowPrice', 'Cull cow (boner)', '\$/cwt'),
          _priceField('bullPrice', 'Cull bull', '\$/cwt'),
          _priceField('fedPrice', 'Finished / fed (live)', '\$/cwt'),
          _priceField('fedThresholdWeight', 'Fed at or above', 'lbs'),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              "The forecast doesn't publish fed or bull prices — set these to your local numbers.",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
          _section('Weight Projection'),
          _priceField('assumedDailyGain', 'Assumed daily gain', 'lb/day'),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 24),
            child: Text(
              'When an animal has no current weight, its value is projected from its purchase weight at this gain rate.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(title,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700])),
      );

  Widget _priceField(String key, String label, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          SizedBox(
            width: 110,
            child: TextField(
              controller: _c[key],
              textAlign: TextAlign.right,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                isDense: true,
                suffixText: unit,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
