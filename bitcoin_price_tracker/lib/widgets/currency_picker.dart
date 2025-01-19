import 'package:flutter/material.dart';

class CurrencyPicker extends StatelessWidget {
  final String selectedCurrency;
  final Function(String) onCurrencyChanged;

  CurrencyPicker({required this.selectedCurrency, required this.onCurrencyChanged});

  final List<String> currencyArray = ['USD', 'EUR', 'GBP'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCurrency,
      dropdownColor: Colors.teal,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      items: currencyArray.map((currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(
            currency,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onCurrencyChanged(value);
        }
      },
    );
  }
}
