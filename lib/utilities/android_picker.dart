import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/price_screen.dart';

class AndroidPicker extends StatefulWidget {
  @override
  _AndroidPickerState createState() => _AndroidPickerState();
}

class _AndroidPickerState extends State<AndroidPicker> {
  String selectedCurrency = 'INR';

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getDropdownButton();
  }
}
