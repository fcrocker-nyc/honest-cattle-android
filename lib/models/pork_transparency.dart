/// Pork industry transparency data — ultimate ownership and market concentration.
/// Sources: USDA, company filings, Institute for Agriculture and Trade Policy.
library;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

enum ProcessorTier {
  top3, // Top 3 by US market share — HHI shown
  major, // Other significant processors
  other,
}

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

class PorkProcessor {
  final String id;
  final String name;
  final String ultimateOwner;
  final String ownerCountry;
  final String ownerFlag; // emoji flag
  final double marketSharePct; // US pork processing %
  final ProcessorTier tier;
  final String ownershipNote;
  final String ownerUrl;

  const PorkProcessor({
    required this.id,
    required this.name,
    required this.ultimateOwner,
    required this.ownerCountry,
    required this.ownerFlag,
    required this.marketSharePct,
    required this.tier,
    required this.ownershipNote,
    required this.ownerUrl,
  });

  /// HHI contribution = marketShare² (using whole-number percent)
  double get hhiContribution => marketSharePct * marketSharePct;
}

class PorkBrand {
  final String name;
  final String processorId;
  final List<String> aliases; // alternate spellings / common names

  const PorkBrand({
    required this.name,
    required this.processorId,
    this.aliases = const [],
  });
}

// ---------------------------------------------------------------------------
// Processor data
// ---------------------------------------------------------------------------

const List<PorkProcessor> kPorkProcessors = [
  PorkProcessor(
    id: 'whgroup',
    name: 'Smithfield Foods',
    ultimateOwner: 'WH Group (Shuanghui International)',
    ownerCountry: 'China',
    ownerFlag: '🇨🇳',
    marketSharePct: 27.0,
    tier: ProcessorTier.top3,
    ownershipNote:
        'WH Group, headquartered in Hong Kong/Henan, acquired Smithfield Foods '
        'in 2013 for \$7.1 billion — the largest Chinese acquisition of a US company '
        'at the time. Smithfield is the world\'s largest pork producer.',
    ownerUrl: 'https://www.whgroup.com',
  ),
  PorkProcessor(
    id: 'tyson',
    name: 'Tyson Foods',
    ultimateOwner: 'Tyson Foods, Inc.',
    ownerCountry: 'United States',
    ownerFlag: '🇺🇸',
    marketSharePct: 18.0,
    tier: ProcessorTier.top3,
    ownershipNote:
        'Publicly traded US company (NYSE: TSN), majority-controlled by the '
        'Tyson family through a dual-class share structure. Headquartered in '
        'Springdale, Arkansas.',
    ownerUrl: 'https://www.tysonfoods.com',
  ),
  PorkProcessor(
    id: 'jbs',
    name: 'JBS USA',
    ultimateOwner: 'JBS S.A.',
    ownerCountry: 'Brazil',
    ownerFlag: '🇧🇷',
    marketSharePct: 16.0,
    tier: ProcessorTier.top3,
    ownershipNote:
        'JBS S.A. is the world\'s largest meat processing company, headquartered '
        'in São Paulo, Brazil. It is majority-owned by J&F Investimentos, '
        'controlled by the Batista family.',
    ownerUrl: 'https://jbssa.com',
  ),
  PorkProcessor(
    id: 'hormel',
    name: 'Hormel Foods',
    ultimateOwner: 'Hormel Foods Corporation',
    ownerCountry: 'United States',
    ownerFlag: '🇺🇸',
    marketSharePct: 10.0,
    tier: ProcessorTier.major,
    ownershipNote:
        'Publicly traded US company (NYSE: HRL), widely held. Headquartered in '
        'Austin, Minnesota. Known for SPAM and a broad portfolio of branded meats.',
    ownerUrl: 'https://www.hormelfoods.com',
  ),
  PorkProcessor(
    id: 'seaboard',
    name: 'Seaboard Corporation',
    ultimateOwner: 'Seaboard Corporation',
    ownerCountry: 'United States',
    ownerFlag: '🇺🇸',
    marketSharePct: 4.0,
    tier: ProcessorTier.major,
    ownershipNote:
        'Privately controlled US conglomerate (NYSE: SEB). Headquartered in '
        'Merriam, Kansas. Primarily controlled by the Bresky family.',
    ownerUrl: 'https://www.seaboardcorp.com',
  ),
  PorkProcessor(
    id: 'kraftheinz',
    name: 'Kraft Heinz',
    ultimateOwner: 'The Kraft Heinz Company',
    ownerCountry: 'United States',
    ownerFlag: '🇺🇸',
    marketSharePct: 3.0,
    tier: ProcessorTier.major,
    ownershipNote:
        'Publicly traded US company (NASDAQ: KHC), major shareholders include '
        'Berkshire Hathaway and 3G Capital. Processes pork primarily through the '
        'Oscar Mayer brand.',
    ownerUrl: 'https://www.kraftheinzcompany.com',
  ),
  PorkProcessor(
    id: 'sigma',
    name: 'Sigma Alimentos',
    ultimateOwner: 'Alfa S.A.B. de C.V.',
    ownerCountry: 'Mexico',
    ownerFlag: '🇲🇽',
    marketSharePct: 2.0,
    tier: ProcessorTier.major,
    ownershipNote:
        'Mexican multinational food company, subsidiary of Alfa S.A.B. de C.V. '
        'Acquired Bar-S Foods in 2010.',
    ownerUrl: 'https://www.sigma-alimentos.com',
  ),
];

// ---------------------------------------------------------------------------
// Brand → Processor mapping
// ---------------------------------------------------------------------------

const List<PorkBrand> kPorkBrands = [
  // ── WH Group / Smithfield Foods ──────────────────────────────────────────
  PorkBrand(name: 'Smithfield', processorId: 'whgroup',
      aliases: ['smithfield foods', 'smithfield premium']),
  PorkBrand(name: 'Farmland', processorId: 'whgroup',
      aliases: ['farmland foods', 'farmland fresh']),
  PorkBrand(name: 'Eckrich', processorId: 'whgroup',
      aliases: ['eckrich smoked sausage']),
  PorkBrand(name: 'Gwaltney', processorId: 'whgroup'),
  PorkBrand(name: 'John Morrell', processorId: 'whgroup',
      aliases: ['morrell', 'john morrell & co']),
  PorkBrand(name: 'Armour', processorId: 'whgroup',
      aliases: ['armour star', 'armour meats']),
  PorkBrand(name: "Cook's", processorId: 'whgroup',
      aliases: ['cooks', 'cook\'s ham']),
  PorkBrand(name: 'Kretschmar', processorId: 'whgroup'),
  PorkBrand(name: 'Margherita', processorId: 'whgroup',
      aliases: ['margherita meats', 'margherita pepperoni']),
  PorkBrand(name: "Nathan's Famous", processorId: 'whgroup',
      aliases: ['nathans', 'nathan\'s']),
  PorkBrand(name: 'Patrick Cudahy', processorId: 'whgroup',
      aliases: ['cudahy', 'patrick cudahy']),
  PorkBrand(name: 'Curly\'s', processorId: 'whgroup',
      aliases: ['curlys', 'curly\'s foods']),

  // ── Tyson Foods ───────────────────────────────────────────────────────────
  PorkBrand(name: 'Tyson', processorId: 'tyson',
      aliases: ['tyson fresh meats', 'tyson pork']),
  PorkBrand(name: 'Jimmy Dean', processorId: 'tyson',
      aliases: ['jimmy dean sausage', 'jimmy dean breakfast']),
  PorkBrand(name: 'Hillshire Farm', processorId: 'tyson',
      aliases: ['hillshire farms', 'hillshire']),
  PorkBrand(name: 'Ball Park', processorId: 'tyson',
      aliases: ['ball park franks', 'ballpark']),
  PorkBrand(name: 'State Fair', processorId: 'tyson',
      aliases: ['state fair corn dogs', 'state fair foods']),
  PorkBrand(name: 'Wright Brand', processorId: 'tyson',
      aliases: ['wright', 'wright brand bacon']),

  // ── JBS USA ───────────────────────────────────────────────────────────────
  PorkBrand(name: 'Swift Premium', processorId: 'jbs',
      aliases: ['swift', 'swift pork', 'swift meats']),
  PorkBrand(name: 'Swift', processorId: 'jbs'),

  // ── Hormel Foods ─────────────────────────────────────────────────────────
  PorkBrand(name: 'Hormel', processorId: 'hormel',
      aliases: ['hormel foods', 'hormel meats']),
  PorkBrand(name: 'SPAM', processorId: 'hormel',
      aliases: ['spam', 'spam classic']),
  PorkBrand(name: 'Applegate', processorId: 'hormel',
      aliases: ['applegate farms', 'applegate organics', 'applegate naturals']),
  PorkBrand(name: 'Natural Choice', processorId: 'hormel',
      aliases: ['natural choice deli']),
  PorkBrand(name: 'Always Tender', processorId: 'hormel'),
  PorkBrand(name: 'Black Label', processorId: 'hormel',
      aliases: ['black label bacon', 'hormel black label']),
  PorkBrand(name: 'Cure 81', processorId: 'hormel',
      aliases: ['cure81', 'cure 81 ham']),

  // ── Seaboard ─────────────────────────────────────────────────────────────
  PorkBrand(name: 'Prairie Fresh', processorId: 'seaboard',
      aliases: ['prairie fresh prime', 'prairie fresh pork']),
  PorkBrand(name: "Daily's", processorId: 'seaboard',
      aliases: ['dailys', 'daily\'s premium meats', 'daily\'s bacon']),

  // ── Kraft Heinz ──────────────────────────────────────────────────────────
  PorkBrand(name: 'Oscar Mayer', processorId: 'kraftheinz',
      aliases: ['oscar meyer', 'oscar mayer wieners', 'oscar mayer bacon']),

  // ── Sigma Alimentos ──────────────────────────────────────────────────────
  PorkBrand(name: 'Bar-S', processorId: 'sigma',
      aliases: ['bar s', 'bar-s foods', 'bars']),
];

// ---------------------------------------------------------------------------
// HHI helper
// ---------------------------------------------------------------------------

class PorkMarketHHI {
  /// Full-market HHI (estimated, based on top processors + residual share).
  static const double estimatedFullHHI = 1620.0;

  /// DOJ/FTC classification thresholds.
  static String classification(double hhi) {
    if (hhi < 1500) return 'Unconcentrated';
    if (hhi < 2500) return 'Moderately Concentrated';
    return 'Highly Concentrated';
  }

  static Color classificationColor(double hhi) {
    if (hhi < 1500) return const Color(0xFF4CAF50); // green
    if (hhi < 2500) return const Color(0xFFFF9800); // orange
    return const Color(0xFFE53935); // red
  }

  /// HHI contributed by just the top-3 processors.
  static double get top3HHI {
    return kPorkProcessors
        .where((p) => p.tier == ProcessorTier.top3)
        .fold(0.0, (sum, p) => sum + p.hhiContribution);
  }
}

// ---------------------------------------------------------------------------
// Lookup service
// ---------------------------------------------------------------------------

class PorkTransparencyService {
  /// Find a brand by name (case-insensitive, alias-aware).
  static PorkBrand? findBrand(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return null;

    // Exact name match first
    for (final brand in kPorkBrands) {
      if (brand.name.toLowerCase() == q) return brand;
    }
    // Alias match
    for (final brand in kPorkBrands) {
      if (brand.aliases.any((a) => a.toLowerCase() == q)) return brand;
    }
    // Partial name match
    for (final brand in kPorkBrands) {
      if (brand.name.toLowerCase().contains(q) ||
          q.contains(brand.name.toLowerCase())) {
        return brand;
      }
    }
    // Partial alias match
    for (final brand in kPorkBrands) {
      if (brand.aliases.any(
          (a) => a.toLowerCase().contains(q) || q.contains(a.toLowerCase()))) {
        return brand;
      }
    }
    return null;
  }

  /// Return all brands that fuzzy-match the query (for suggestions).
  static List<PorkBrand> searchBrands(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return kPorkBrands.where((brand) {
      if (brand.name.toLowerCase().contains(q)) return true;
      if (brand.aliases.any((a) => a.toLowerCase().contains(q))) return true;
      return false;
    }).toList();
  }

  /// Resolve a brand to its processor.
  static PorkProcessor? processorForBrand(PorkBrand brand) {
    try {
      return kPorkProcessors
          .firstWhere((p) => p.id == brand.processorId);
    } catch (_) {
      return null;
    }
  }
}
