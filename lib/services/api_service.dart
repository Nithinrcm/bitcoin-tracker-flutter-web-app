import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart'; // Import constants

class ApiService {
  final Map<String, double> _conversionRates = {}; // Cache for conversion rates

  Future<double> fetchBitcoinPriceInUSD() async {
    final response = await http.get(Uri.parse(bitcoinApiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return double.parse(data['bpi']['USD']['rate_float'].toString());
    } else {
      throw Exception('Failed to fetch Bitcoin price in USD');
    }
  }

  Future<void> fetchAllConversionRates() async {
    if (_conversionRates.isNotEmpty) {
      return;
    }

    final response = await http.get(Uri.parse('$fixerApiUrl?apikey=$fixerApiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rates = data['data'] as Map<String, dynamic>;

      // Store conversion rates in the cache
      rates.forEach((currency, rate) {
        _conversionRates[currency] = double.parse(rate.toString());
      });
    } else {
      throw Exception('Failed to fetch conversion rates');
    }
  }

  double getConversionRate(String targetCurrency) {
    if (_conversionRates.containsKey(targetCurrency)) {
      return _conversionRates[targetCurrency]!;
    } else {
      fetchAllConversionRates();
      return getConversionRate(targetCurrency);
    }
  }
}
