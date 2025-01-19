import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_price_tracker/services/api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiService = ApiService();
    });

    test('fetchBitcoinPriceInUSD returns correct value', () async {
      // Arrange
      final mockResponse = '{"bpi": {"USD": {"rate_float": 50000.0}}}';
      when(mockHttpClient.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      // Act
      final price = await apiService.fetchBitcoinPriceInUSD();

      // Assert
      expect(price, 50000.0);
    });

    test('fetchBitcoinPriceInUSD throws exception on error', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json')))
          .thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(() async => await apiService.fetchBitcoinPriceInUSD(), throwsException);
    });

  });
}
