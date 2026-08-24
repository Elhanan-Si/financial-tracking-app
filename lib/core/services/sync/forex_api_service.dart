import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for fetching live foreign exchange rates (USD/ILS, EUR/ILS, GBP/ILS, etc.)
class ForexApiService {
  final http.Client _client;

  ForexApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches latest exchange rates for base currency (default USD)
  Future<Map<String, double>> fetchLatestRates({String base = 'USD'}) async {
    final rates = <String, double>{};

    // Primary endpoint: open.er-api.com (Free, highly reliable, real-time, no API key required)
    try {
      final url = Uri.parse('https://open.er-api.com/v6/latest/$base');
      final response = await _client.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['result'] == 'success' && data['rates'] is Map) {
          final rawRates = data['rates'] as Map<String, dynamic>;
          rawRates.forEach((k, v) {
            if (v is num) {
              rates[k.toUpperCase()] = v.toDouble();
            }
          });
          if (rates.containsKey('ILS') && rates['ILS']! > 0) {
            return rates;
          }
        }
      }
    } catch (_) {
      // Fallback to secondary provider
    }

    // Secondary endpoint: frankfurter.app (Free open source ECB exchange rates)
    try {
      final url = Uri.parse('https://api.frankfurter.app/latest?from=$base');
      final response = await _client.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['rates'] is Map) {
          final rawRates = data['rates'] as Map<String, dynamic>;
          rawRates.forEach((k, v) {
            if (v is num) {
              rates[k.toUpperCase()] = v.toDouble();
            }
          });
          rates[base] = 1.0;
          if (rates.containsKey('ILS') && rates['ILS']! > 0) {
            return rates;
          }
        }
      }
    } catch (_) {
      // Fallback
    }

    // Third endpoint: floatrates.com
    try {
      final url = Uri.parse('https://www.floatrates.com/daily/${base.toLowerCase()}.json');
      final response = await _client.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        rates[base] = 1.0;
        data.forEach((k, v) {
          if (v is Map && v['rate'] is num) {
            rates[k.toUpperCase()] = (v['rate'] as num).toDouble();
          }
        });
        if (rates.containsKey('ILS') && rates['ILS']! > 0) {
          return rates;
        }
      }
    } catch (_) {
      // Fallback
    }

    if (rates.isEmpty) {
      throw Exception('לא ניתן לטעון שערי חליפין משרתי הרשת (מצב לא מקוון)');
    }
    return rates;
  }
}
