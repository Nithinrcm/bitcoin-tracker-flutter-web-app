import 'dart:async';
import '../services/api_service.dart';

class BitcoinViewModel {
  final ApiService _apiService = ApiService();
  final StreamController<String> _bitcoinRateController = StreamController<String>();
  String _selectedCurrency = 'USD';

  Stream<String> get bitcoinRate => _bitcoinRateController.stream;
  String get selectedCurrency => _selectedCurrency;

  BitcoinViewModel() {
    _apiService.fetchAllConversionRates().catchError((error) {
      _bitcoinRateController.sink.addError('Failed to fetch conversion rates: $error');
    });
  }

  void updateCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
    fetchBitcoinPrice(newCurrency);
  }

  void fetchBitcoinPrice(String currency) async {
    if (currency != '') {
      try {
          final bitcoinPriceInUSD = await _apiService.fetchBitcoinPriceInUSD();

          double conversionRate = 1.0;
          if (currency != 'USD') {
            conversionRate = _apiService.getConversionRate(currency);
          }

          final convertedPrice = bitcoinPriceInUSD * conversionRate;

          final formattedPrice = '${convertedPrice.toStringAsFixed(2)} $currency';
          _bitcoinRateController.sink.add(formattedPrice);
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
