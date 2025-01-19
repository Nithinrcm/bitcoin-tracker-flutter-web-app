import 'package:flutter/material.dart';
import '../viewmodel/bitcoin_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BitcoinViewModel _viewModel = BitcoinViewModel();
  final List<String> _currencyArray = ['AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'IDR', 'ILS', 'INR', 'ISK', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'USD', 'ZAR'];
  String _selectedCurrency = '';

  @override
  void initState() {
    super.initState();
    _viewModel.fetchBitcoinPrice(_selectedCurrency);
  }

  void _onCurrencyChanged(String newCurrency) {
    setState(() {
      _selectedCurrency = newCurrency;
    });
    _viewModel.updateCurrency(newCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          // Image at the top, always centered
          Padding(
            padding: const EdgeInsets.only(top: 40.0), // Adjust top padding as needed
            child: Center(
              child: Image.asset(
                'assets/images/bitcoin.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between image and text
          // Price text, always below the image
          StreamBuilder<String>(
            stream: _viewModel.bitcoinRate,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(color: Colors.yellow);
              }
              if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              }
              return Text(
                snapshot.data ?? '',
                style: TextStyle(fontSize: 48, color: Colors.yellow),
              );
            },
          ),
          // Spacer to push the currency picker to the bottom
          Spacer(),
          // Currency picker, always at the bottom and centered
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Adjust bottom padding as needed
            child: SizedBox(
              height: 150, // Height of the rotating menu
              child: ListWheelScrollView(
                itemExtent: 50, // Height of each item in the wheel
                perspective: 0.005, // Adjust the depth effect
                diameterRatio: 1.2,
                physics: FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  _onCurrencyChanged(_currencyArray[index]);
                },
                children: _currencyArray.map((currency) {
                  return Text(
                    currency,
                    style: TextStyle(
                      fontSize: 24,
                      color: currency == _selectedCurrency ? Colors.yellow : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
