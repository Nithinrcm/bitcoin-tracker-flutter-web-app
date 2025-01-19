import 'package:flutter/material.dart';
import '../viewmodel/bitcoin_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BitcoinViewModel _viewModel = BitcoinViewModel();
  final List<String> _currencyArray = ['USD', 'EUR', 'GBP'];
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Updated to use an image
            Image.asset(
              'assets/images/bitcoin.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            StreamBuilder<String>(
              stream: _viewModel.bitcoinRate,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: Colors.white);
                }
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Text(
                  '${snapshot.data} $_selectedCurrency',
                  style: TextStyle(fontSize: 48, color: Colors.white),
                );
              },
            ),
            const SizedBox(height: 40),
            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
