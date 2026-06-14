import 'package:flutter/material.dart';
import '../../models/pork_transparency.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';

class PorkLookupView extends StatefulWidget {
  const PorkLookupView({super.key});

  @override
  State<PorkLookupView> createState() => _PorkLookupViewState();
}

class _PorkLookupViewState extends State<PorkLookupView> {
  final _controller = TextEditingController();
  List<PorkBrand> _suggestions = [];
  PorkBrand? _selectedBrand;
  PorkProcessor? _processor;
  bool _searched = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {
      _suggestions = PorkTransparencyService.searchBrands(value);
      _selectedBrand = null;
      _processor = null;
      _searched = false;
    });
  }

  void _selectBrand(PorkBrand brand) {
    final processor = PorkTransparencyService.processorForBrand(brand);
    _controller.text = brand.name;
    setState(() {
      _selectedBrand = brand;
      _processor = processor;
      _suggestions = [];
      _searched = true;
    });
    FocusScope.of(context).unfocus();
  }

  void _lookup() {
    final brand = PorkTransparencyService.findBrand(_controller.text);
    final processor =
        brand != null ? PorkTransparencyService.processorForBrand(brand) : null;
    setState(() {
      _selectedBrand = brand;
      _processor = processor;
      _suggestions = [];
      _searched = true;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pork Brand Lookup'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppTheme.earthGreen),
            onPressed: () => _showAboutSheet(context),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.standardPadding),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              if (_suggestions.isNotEmpty) _buildSuggestions(),
              const SizedBox(height: 16),
              if (_searched) _buildResult(),
              if (!_searched) _buildMarketOverview(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Search bar ─────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Brand name',
              hintText: 'e.g. Smithfield, Jimmy Dean, SPAM',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _onChanged,
            onSubmitted: (_) => _lookup(),
            textInputAction: TextInputAction.search,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _lookup,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(72, 56),
            ),
            child: const Text('Look up'),
          ),
        ),
      ],
    );
  }

  // ── Type-ahead suggestions ─────────────────────────────────────────────────

  Widget _buildSuggestions() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: _suggestions.take(6).map((brand) {
              final proc = PorkTransparencyService.processorForBrand(brand);
              return InkWell(
                onTap: () => _selectBrand(brand),
                borderRadius: BorderRadius.circular(AppTheme.cardCornerRadius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        proc?.ownerFlag ?? '🏭',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(brand.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            if (proc != null)
                              Text(
                                proc.ultimateOwner,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                          ],
                        ),
                      ),
                      if (proc?.tier == ProcessorTier.top3)
                        StatusBadge(
                            text: 'Top 3',
                            color: AppTheme.alertOrange),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ── Result card ───────────────────────────────────────────────────────────

  Widget _buildResult() {
    if (_selectedBrand == null || _processor == null) {
      return _buildNotFound();
    }
    final brand = _selectedBrand!;
    final proc = _processor!;
    final isTop3 = proc.tier == ProcessorTier.top3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Owner card
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(proc.ownerFlag,
                      style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brand.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Owned by ${proc.ultimateOwner}',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              _infoRow(
                Icons.business,
                'Processor',
                proc.name,
              ),
              const SizedBox(height: 12),
              _infoRow(
                Icons.public,
                'Ultimate Owner',
                '${proc.ultimateOwner}  ${proc.ownerFlag}',
              ),
              const SizedBox(height: 12),
              _infoRow(
                Icons.flag,
                'Country of Ownership',
                proc.ownerCountry,
                color: proc.ownerCountry == 'United States'
                    ? AppTheme.earthGreen
                    : AppTheme.alertOrange,
              ),
              const SizedBox(height: 12),
              _infoRow(
                Icons.pie_chart,
                'Estimated US Market Share',
                '~${proc.marketSharePct.toStringAsFixed(0)}%',
              ),
              if (isTop3) ...[
                const SizedBox(height: 16),
                StatusBadge(
                  text: '⚠ Top 3 Processor — see HHI below',
                  color: AppTheme.alertOrange,
                ),
              ],
              const Divider(height: 24),
              Text(
                proc.ownershipNote,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),

        // ── HHI card (only for top-3 owned brands)
        if (isTop3) ...[
          const SizedBox(height: 16),
          _buildHHICard(proc),
        ],

        const SizedBox(height: 16),
        _buildOtherBrandsCard(proc),
      ],
    );
  }

  Widget _buildNotFound() {
    return AppCard(
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.search_off, color: AppTheme.warmBrown),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Brand not found',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for the parent company name, or browse the '
            'market overview below to see the top brands by owner.',
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // ── HHI panel ─────────────────────────────────────────────────────────────

  Widget _buildHHICard(PorkProcessor proc) {
    final fullHHI = PorkMarketHHI.estimatedFullHHI;
    final top3HHI = PorkMarketHHI.top3HHI;
    final classification = PorkMarketHHI.classification(fullHHI);
    final classColor = PorkMarketHHI.classificationColor(fullHHI);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, color: AppTheme.earthGreen),
              const SizedBox(width: 8),
              const Text(
                'Market Concentration (HHI)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // HHI meter
          _HHIMeter(hhi: fullHHI),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _StatBox(
                  label: 'Full Market HHI',
                  value: fullHHI.toStringAsFixed(0),
                  note: 'Est.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(
                  label: 'Top-3 Contribution',
                  value: top3HHI.toStringAsFixed(0),
                  note: 'of ${fullHHI.toStringAsFixed(0)}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(
                  label: 'Status',
                  value: classification,
                  valueColor: classColor,
                  note: 'DOJ/FTC scale',
                  small: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          // Breakdown bar
          const Text(
            'Top processor shares',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          const SizedBox(height: 10),
          ...kPorkProcessors
              .where((p) =>
                  p.tier == ProcessorTier.top3 ||
                  p.tier == ProcessorTier.major)
              .map((p) => _ProcessorBar(
                    processor: p,
                    isHighlighted: p.id == proc.id,
                  )),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: classColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: classColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              'The Herfindahl-Hirschman Index (HHI) measures market '
              'concentration. Scores above 1,500 indicate a moderately '
              'concentrated market. The US pork processing industry is '
              'dominated by three firms — two of which are foreign-owned — '
              'accounting for ~61% of total US production.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  // ── Other brands under same owner ─────────────────────────────────────────

  Widget _buildOtherBrandsCard(PorkProcessor proc) {
    final others = kPorkBrands
        .where((b) => b.processorId == proc.id)
        .map((b) => b.name)
        .toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Other brands owned by ${proc.ultimateOwner} ${proc.ownerFlag}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: others
                .map((b) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color:
                            AppTheme.earthGreen.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: AppTheme.earthGreen
                                .withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        b,
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.earthGreen),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ── Market overview (default state) ───────────────────────────────────────

  Widget _buildMarketOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'US Pork Market Overview'),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Top 3 Processors control ~61% of US pork production',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'HHI ≈ ${PorkMarketHHI.estimatedFullHHI.toStringAsFixed(0)}  ·  '
                '${PorkMarketHHI.classification(PorkMarketHHI.estimatedFullHHI)}',
                style: TextStyle(
                    fontSize: 13,
                    color: PorkMarketHHI.classificationColor(
                        PorkMarketHHI.estimatedFullHHI)),
              ),
              const SizedBox(height: 16),
              ...kPorkProcessors
                  .where((p) =>
                      p.tier == ProcessorTier.top3 ||
                      p.tier == ProcessorTier.major)
                  .map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _ProcessorBar(processor: p),
                      )),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionHeader(title: 'Common Brands — Tap to look up'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: kPorkBrands
              .take(18)
              .map((b) => GestureDetector(
                    onTap: () => _selectBrand(b),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(b.name,
                          style: const TextStyle(fontSize: 13)),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 32),
        Text(
          'Market share estimates based on USDA GIPSA data and industry '
          'reports. Ownership information reflects publicly available '
          'corporate filings as of 2024.',
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _infoRow(IconData icon, String label, String value,
      {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color ?? AppTheme.darkBrown,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAboutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About This Feature',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              'This tool shows who ultimately owns a pork brand and how '
              'concentrated the US pork processing market is.\n\n'
              'The Herfindahl-Hirschman Index (HHI) is used by the US '
              'Department of Justice and FTC to measure market concentration. '
              'It is calculated as the sum of squared market shares.\n\n'
              '• < 1,500: Unconcentrated\n'
              '• 1,500–2,500: Moderately concentrated\n'
              '• > 2,500: Highly concentrated\n\n'
              'Data reflects publicly available ownership and market share '
              'information as of 2024.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _HHIMeter extends StatelessWidget {
  final double hhi;
  const _HHIMeter({required this.hhi});

  @override
  Widget build(BuildContext context) {
    // Scale: 0 → 3000
    final fraction = (hhi / 3000).clamp(0.0, 1.0);
    final color = PorkMarketHHI.classificationColor(hhi);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('0', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            Text('1,500',
                style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            Text('2,500',
                style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            Text('3,000+',
                style: TextStyle(fontSize: 11, color: Colors.grey[500])),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            // Background track with color zones
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Row(
                children: [
                  Flexible(
                    flex: 1500,
                    child: Container(height: 14, color: Colors.green[100]),
                  ),
                  Flexible(
                    flex: 1000,
                    child: Container(height: 14, color: Colors.orange[100]),
                  ),
                  Flexible(
                    flex: 500,
                    child: Container(height: 14, color: Colors.red[100]),
                  ),
                ],
              ),
            ),
            // Filled portion
            FractionallySizedBox(
              widthFactor: fraction,
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Unconcentrated',
                style: TextStyle(fontSize: 10, color: Colors.green[700])),
            Text('Moderate',
                style: TextStyle(fontSize: 10, color: Colors.orange[700])),
            Text('High',
                style: TextStyle(fontSize: 10, color: Colors.red[700])),
          ],
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final String note;
  final Color? valueColor;
  final bool small;

  const _StatBox({
    required this.label,
    required this.value,
    required this.note,
    this.valueColor,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: small ? 12 : 18,
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppTheme.darkBrown,
            ),
          ),
          Text(note,
              style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

class _ProcessorBar extends StatelessWidget {
  final PorkProcessor processor;
  final bool isHighlighted;

  const _ProcessorBar({
    required this.processor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isHighlighted
        ? AppTheme.alertOrange
        : processor.tier == ProcessorTier.top3
            ? AppTheme.earthGreen
            : Colors.grey[400]!;
    final fraction = processor.marketSharePct / 30.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(processor.ownerFlag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              processor.name,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    )),
                FractionallySizedBox(
                  widthFactor: fraction.clamp(0.0, 1.0),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              '~${processor.marketSharePct.toStringAsFixed(0)}%',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
