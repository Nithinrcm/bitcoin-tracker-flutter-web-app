import 'dart:async';
import '../services/api_service.dart';

class BitcoinViewModel {
  final ApiService _apiService = ApiService();
  final StreamController<String> _bitcoinRateController = StreamController<String>();
  String _selectedCurrency = 'USD';

  Stream<String> get bitcoinRate => _bitcoinRateController.stream;
  String get selectedCurrency => _selectedCurrency;

  void updateCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
    fetchBitcoinPrice(newCurrency);
  }

  void fetchBitcoinPrice(String currency) async {
    if (currency != '') {
      try {
      final bitcoinPrice = await _apiService.fetchBitcoinPrice(currency);
      _bitcoinRateController.sink.add(bitcoinPrice.rate.toString());
      } catch (error) {
      _bitcoinRateController.sink.addError(error.toString());
      }
    }
    else{
      _bitcoinRateController.sink.add("Price");
    }

  }

  void dispose() {
    _bitcoinRateController.close();
  }
}
