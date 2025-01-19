import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bitcoin_price.dart';

class ApiService {
  final String _baseUrl = 'https://api.coindesk.com/v1/bpi/currentprice.json';

  Future<BitcoinPrice> fetchBitcoinPrice(String currency) async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return BitcoinPrice.fromJson(data, currency);
    } else {
      throw Exception('Failed to fetch Bitcoin price');
    }
  }
}
