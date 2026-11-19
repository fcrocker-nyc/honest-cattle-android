import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:honest_cattle/models/moisture_outlook.dart';
import 'package:honest_cattle/services/hc_data_service.dart';

// Android mirror of HonestCattleAppTests/MoistureOutlookTests.swift.
//
// The point of duplicating these is that the two apps must read the same feed
// the same way. A rancher comparing an iPhone with an Android phone seeing two
// different percent-of-normal figures, or one app demoting the 12-month row
// while the other presents it as guidance, is the failure these guard.
//
// No network: every case runs against literal JSON.

const _fullCounty = '''
{
  "county": "park",
  "county_label": "Park",
  "page_url": "https://honestcattle.net/counties-in-montana-counties/park-county-montana/",
  "horizons": [
    {"horizon": "1 month",  "months": 1,  "window": "November 2026",
     "normal_in": 2.07, "expected_in": 2.05, "pct_of_normal": 99,
     "lean": "No clear signal", "confidence": "Moderate"},
    {"horizon": "3 months", "months": 3,  "window": "Nov 2026-Jan 2027",
     "normal_in": 6.07, "expected_in": 5.86, "pct_of_normal": 97,
     "lean": "Slight dry lean", "confidence": "Low to moderate"},
    {"horizon": "6 months", "months": 6,  "window": "Nov 2026-Apr 2027",
     "normal_in": 12.84, "expected_in": 12.56, "pct_of_normal": 98,
     "lean": "Slight dry lean", "confidence": "Low"},
    {"horizon": "12 months","months": 12, "window": "Nov 2026-Oct 2027",
     "normal_in": 26.12, "expected_in": 25.42, "pct_of_normal": 97,
     "lean": "Slight dry lean", "confidence": "Very low"}
  ],
  "issued_seasonal": "Oct 15, 2026",
  "issued_monthly": "Oct 31, 2026",
  "odds_1_month": {"drier": 34, "near": 34, "wetter": 32},
  "odds_3_month": {"drier": 39, "near": 33, "wetter": 28},
  "spring_growing_season": {
    "window": "Apr-Jun 2027", "normal_in": 9.01, "expected_in": 8.61,
    "pct_of_normal": 96, "drier": 45, "near": 33, "wetter": 22
  },
  "temperature_note": "November 2026 leans warmer than normal."
}
''';

MoistureOutlook _park() =>
    MoistureOutlook.fromJson(json.decode(_fullCounty) as Map<String, dynamic>);

void main() {
  group('decoding', () {
    test('decodes a full county record', () {
      final o = _park();
      expect(o.county, 'park');
      expect(o.countyLabel, 'Park');
      expect(o.horizons.length, 4);
      expect(o.issuedMonthly, 'Oct 31, 2026');
      expect(o.odds3Month!.drier, 39);
      expect(o.springGrowingSeason!.pctOfNormal, 96);
      expect(o.temperatureNote, isNotNull);
    });

    test('decodes a minimal record without the optional blocks', () {
      final o = MoistureOutlook.fromJson(json.decode('''
        {"county": "wibaux", "horizons": [
          {"horizon": "1 month", "months": 1,
           "normal_in": 1.0, "expected_in": 1.0}]}
      ''') as Map<String, dynamic>);
      expect(o.horizons.length, 1);
      expect(o.odds1Month, isNull);
      expect(o.springGrowingSeason, isNull);
      expect(o.issuedLine, isNull);
    });

    test('ignores unknown fields rather than failing the whole county', () {
      final o = MoistureOutlook.fromJson(json.decode('''
        {"county": "park", "surprise_field": 42, "horizons": [
          {"horizon": "1 month", "months": 1, "normal_in": 2.0,
           "expected_in": 1.0, "another_surprise": true}]}
      ''') as Map<String, dynamic>);
      expect(o.horizons.single.expectedIn, 1.0);
    });

    test('skips a horizon missing the numbers instead of painting a zero', () {
      final o = MoistureOutlook.fromJson(json.decode('''
        {"county": "park", "horizons": [
          {"horizon": "1 month", "months": 1, "normal_in": 2.0, "expected_in": 1.9},
          {"horizon": "3 months", "months": 3}]}
      ''') as Map<String, dynamic>);
      expect(o.horizons.length, 1);
      expect(o.horizon(3), isNull);
    });

    test('decodes the whole feed and its county map', () {
      final feed = MoistureOutlookFeed.fromJson(json.decode('''
        {"updated": "2026-11-19", "generated_utc": "2026-11-19T15:47:25Z",
         "county_count": 1, "counties": {"park": $_fullCounty}}
      ''') as Map<String, dynamic>);
      expect(feed.updated, '2026-11-19');
      expect(feed.counties.length, 1);
      expect(feed.forKey('park'), isNotNull);
      expect(feed.forKey('harris'), isNull, reason: 'Texas has no outlook');
      expect(feed.forKey(null), isNull);
    });
  });

  group('derived values', () {
    test('falls back to the ratio when pct_of_normal is absent', () {
      final h = MoistureHorizon.fromJson(
          {'months': 1, 'normal_in': 2.0, 'expected_in': 1.5})!;
      expect(h.percentOfNormal, 75);
    });

    test('guards divide-by-zero on a zero normal', () {
      final h = MoistureHorizon.fromJson(
          {'months': 1, 'normal_in': 0.0, 'expected_in': 1.5})!;
      expect(h.percentOfNormal, 100);
    });

    test('anomaly is expected minus normal', () {
      expect(_park().twelveMonth!.anomalyIn, closeTo(-0.70, 0.001));
    });

    test('tilt bands', () {
      MoistureTilt tiltAt(int pct) => MoistureHorizon.fromJson({
            'months': 1,
            'normal_in': 100.0,
            'expected_in': pct.toDouble(),
          })!
              .tilt;
      expect(tiltAt(84), MoistureTilt.wellBelow);
      expect(tiltAt(85), MoistureTilt.below);
      expect(tiltAt(94), MoistureTilt.below);
      expect(tiltAt(95), MoistureTilt.nearNormal);
      expect(tiltAt(105), MoistureTilt.nearNormal);
      expect(tiltAt(106), MoistureTilt.above);
      expect(tiltAt(115), MoistureTilt.above);
      expect(tiltAt(116), MoistureTilt.wellAbove);
    });

    test('confidence precedence: "Low to moderate" is not caught by "low"', () {
      MoistureWeight weightFor(String c) => MoistureHorizon.fromJson({
            'months': 3,
            'normal_in': 1.0,
            'expected_in': 1.0,
            'confidence': c,
          })!
              .weight;
      expect(weightFor('Low to moderate'), MoistureWeight.usable);
      expect(weightFor('Low'), MoistureWeight.soft);
      expect(weightFor('Very low'), MoistureWeight.planningBaseline);
      expect(weightFor('Moderate'), MoistureWeight.usable);
    });

    test('weight falls back to horizon length with no confidence wording', () {
      MoistureWeight weightFor(int months) => MoistureHorizon.fromJson({
            'months': months,
            'normal_in': 1.0,
            'expected_in': 1.0,
          })!
              .weight;
      expect(weightFor(1), MoistureWeight.usable);
      expect(weightFor(3), MoistureWeight.usable);
      expect(weightFor(6), MoistureWeight.soft);
      expect(weightFor(12), MoistureWeight.planningBaseline);
    });

    // If this fails the UI is over-promising: a 12-month CPC row is mostly
    // normal weather restated, and must never be presented as guidance.
    test('twelve-month row is demoted to a planning baseline', () {
      final twelve = _park().twelveMonth!;
      expect(twelve.weight, MoistureWeight.planningBaseline);
      expect(twelve.weight.caveat, 'Planning baseline, not a forecast');
    });

    test('six-month row is directional only', () {
      expect(_park().sixMonth!.weight.caveat, 'Directional only');
    });

    test('usable rows carry no caveat', () {
      expect(_park().oneMonth!.weight.caveat, isNull);
      expect(_park().threeMonth!.weight.caveat, isNull);
    });

    test('lookup is by month count, not array index', () {
      final o = MoistureOutlook.fromJson(json.decode('''
        {"county": "park", "horizons": [
          {"horizon": "12 months", "months": 12, "normal_in": 26.0, "expected_in": 25.0},
          {"horizon": "1 month",   "months": 1,  "normal_in": 2.0,  "expected_in": 1.9}]}
      ''') as Map<String, dynamic>);
      expect(o.oneMonth!.months, 1);
      expect(o.twelveMonth!.months, 12);
    });
  });

  group('odds', () {
    test('formats a summary line', () {
      expect(_park().odds3Month!.summary, '39% drier · 33% near · 28% wetter');
    });

    test('detects a coin flip', () {
      expect(_park().odds1Month!.isCoinFlip, isTrue, reason: '34 vs 32');
      expect(_park().odds3Month!.isCoinFlip, isFalse, reason: '39 vs 28');
    });
  });

  group('presentation', () {
    test('headline reads "near normal" inside the 95-105 band', () {
      expect(_park().headline, contains('expected to run near normal'));
      expect(_park().headline, contains('97%'));
      expect(_park().headline, contains('26.1 in'));
    });

    test('headline names the direction outside the band', () {
      final dry = MoistureOutlook.fromJson(json.decode('''
        {"county": "park", "county_label": "Park", "horizons": [
          {"horizon": "12 months", "months": 12,
           "normal_in": 26.12, "expected_in": 18.0, "pct_of_normal": 69}]}
      ''') as Map<String, dynamic>);
      expect(dry.headline, contains('leans drier than normal'));
    });

    test('headline degrades safely with no twelve-month row', () {
      final none = MoistureOutlook.fromJson(
          json.decode('{"county": "park", "horizons": []}')
              as Map<String, dynamic>);
      expect(none.headline, 'No outlook published.');
    });

    test('issued line adapts to which outlooks are present', () {
      expect(_park().issuedLine,
          'NOAA monthly Oct 31, 2026 · seasonal Oct 15, 2026');
    });

    test('display name falls back to the slug when the label is absent', () {
      final o = MoistureOutlook.fromJson(
          json.decode('{"county": "lewis_clark", "horizons": []}')
              as Map<String, dynamic>);
      expect(o.displayName, 'Lewis Clark');
    });
  });

  group('county key normalization', () {
    // These must land on the keys the feed actually publishes, which a check
    // against the live file confirms are 'lewis_clark', 'big_horn', etc.
    test('maps typed county names onto feed keys', () {
      String? n(String s) => HcDataService.normalizeCountyName(s);
      expect(n('Park'), 'park');
      expect(n('Park County'), 'park');
      expect(n('  PARK county '), 'park');
      expect(n('Big Horn County'), 'big_horn');
      expect(n('Lewis & Clark County'), 'lewis_clark');
      expect(n('Lewis and Clark'), 'lewis_clark');
      expect(n('lewis and clark county'), 'lewis_clark');
      expect(n('Sweet Grass'), 'sweet_grass');
      expect(n(''), isNull);
      expect(n('   '), isNull);
    });
  });
}
