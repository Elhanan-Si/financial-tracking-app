import 'dart:convert';
import 'package:http/http.dart' as http;

class FinnhubQuote {
  final double currentPrice;
  final double highPrice;
  final double lowPrice;
  final double openPrice;
  final double previousClose;
  final double changePercent;
  final DateTime timestamp;

  const FinnhubQuote({
    required this.currentPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.openPrice,
    required this.previousClose,
    required this.changePercent,
    required this.timestamp,
  });

  factory FinnhubQuote.fromJson(Map<String, dynamic> json) {
    final c = (json['c'] as num?)?.toDouble() ?? 0.0;
    final pc = (json['pc'] as num?)?.toDouble() ?? c;
    final dp = (json['dp'] as num?)?.toDouble() ?? (pc > 0 ? ((c - pc) / pc) * 100 : 0.0);
    final t = (json['t'] as num?)?.toInt();

    return FinnhubQuote(
      currentPrice: c,
      highPrice: (json['h'] as num?)?.toDouble() ?? c,
      lowPrice: (json['l'] as num?)?.toDouble() ?? c,
      openPrice: (json['o'] as num?)?.toDouble() ?? c,
      previousClose: pc,
      changePercent: dp,
      timestamp: t != null ? DateTime.fromMillisecondsSinceEpoch(t * 1000) : DateTime.now(),
    );
  }
}

/// Client for fetching stock quotes and forex rates from Finnhub API
class FinnhubApiService {
  final String _apiKey;
  final http.Client _client;

  static const String defaultApiKey = 'da45eehr01qo2j872nb0da45eehr01qo2j872nbg';
  static const String baseUrl = 'https://finnhub.io/api/v1';

  FinnhubApiService({String? apiKey, http.Client? client})
      : _apiKey = apiKey ?? defaultApiKey,
        _client = client ?? http.Client();

  /// Fetches real-time stock/ETF quote
  Future<FinnhubQuote> fetchQuote(String ticker) async {
    final cleanTicker = ticker.trim().toUpperCase();
    final url = Uri.parse('$baseUrl/quote?symbol=$cleanTicker&token=$_apiKey');

    final response = await _client.get(url).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final quote = FinnhubQuote.fromJson(json);
      if (quote.currentPrice == 0.0 && quote.previousClose == 0.0) {
        throw Exception('לא נמצאו נתונים עבור הטיקר $cleanTicker');
      }
      return quote;
    } else {
      throw Exception('שגיאת שרת Finnhub (${response.statusCode})');
    }
  }

  /// Fetches real-time exchange rates against USD (e.g. USD/ILS, EUR/USD)
  Future<Map<String, double>> fetchForexRates({String base = 'USD'}) async {
    final url = Uri.parse('$baseUrl/forex/rates?base=$base&token=$_apiKey');

    final response = await _client.get(url).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final quoteObj = json['quote'] as Map<String, dynamic>? ?? {};
      final rates = <String, double>{};

      quoteObj.forEach((key, val) {
        if (val is num) {
          rates[key] = val.toDouble();
        }
      });
      return rates;
    } else {
      throw Exception('שגיאה בקבלת שערי חליפין (${response.statusCode})');
    }
  }
}
