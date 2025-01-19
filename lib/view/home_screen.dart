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
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Image.asset(
                'assets/images/bitcoin.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: 150,
              child: ListWheelScrollView(
                itemExtent: 50,
                perspective: 0.005,
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
