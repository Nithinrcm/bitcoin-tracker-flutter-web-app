class BitcoinPrice {
  final String currency;
  final double rate;

  BitcoinPrice({required this.currency, required this.rate});

  factory BitcoinPrice.fromJson(Map<String, dynamic> json, String currency) {
    return BitcoinPrice(
      currency: currency,
      rate: double.parse(json['bpi'][currency]['rate_float'].toString()),
    );
  }
}
