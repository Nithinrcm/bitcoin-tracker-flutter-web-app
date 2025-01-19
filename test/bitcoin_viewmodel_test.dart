import 'package:flutter_test/flutter_test.dart';
import 'package:bitcoin_price_tracker/viewmodel/bitcoin_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:bitcoin_price_tracker/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('BitcoinViewModel', () {
    late BitcoinViewModel bitcoinViewModel;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      bitcoinViewModel = BitcoinViewModel();
    });

    test('updateCurrency updates selected currency and fetches Bitcoin price', () {
      // Arrange
      when(mockApiService.fetchBitcoinPriceInUSD()).thenAnswer((_) async => 50000.0);
      when(mockApiService.getConversionRate('EUR')).thenReturn(0.85);
      when(mockApiService.fetchAllConversionRates()).thenAnswer((_) async => {});

      // Act
      bitcoinViewModel.updateCurrency('EUR');

      // Assert
      expect(bitcoinViewModel.selectedCurrency, 'EUR');
    });

    test('fetchBitcoinPrice returns formatted price in selected currency', () async {
      // Arrange
      when(mockApiService.fetchBitcoinPriceInUSD()).thenAnswer((_) async => 50000.0);
      when(mockApiService.getConversionRate('EUR')).thenReturn(0.85);
      when(mockApiService.fetchAllConversionRates()).thenAnswer((_) async => {});

      // Act
      bitcoinViewModel.fetchBitcoinPrice('EUR');

      // Assert
      expect(await bitcoinViewModel.bitcoinRate.first, '42500.00 EUR');
    });
  });
}
