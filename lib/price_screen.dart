import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/utilities/android_picker.dart';
import 'package:bitcoin_ticker/utilities/ios_picker.dart';
import 'utilities/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'network/networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String btc = '?';
  String ltc = '?';
  String eth = '?';
  String selectedCurrency = 'INR';

  Future<dynamic> getPriceData(String cryptoCurrency) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$url/$cryptoCurrency/$selectedCurrency?apikey=$kapikey');
    var priceData = await networkHelper.getData();
    updateUI(priceData);
  }

  DropdownButton<String> getAndroidPicker() {
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
          getPriceData('BTC');
          getPriceData('ETH');
          getPriceData('LTC');
        });
      },
    );
  }

  void updateUI(dynamic priceData) {
    setState(() {
      String price = priceData['rate'].toStringAsFixed(2);
      btc = price;
    });
  }

  @override
  void initState() {
    super.initState();
    getPriceData('BTC');
    getPriceData('ETH');
    getPriceData('LTC');
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CurrencyCard(
            currentPrice: btc,
            selectedCurrency: selectedCurrency,
            selectedCryptoCurrency: 'BTC',
          ),
          CurrencyCard(
            currentPrice: btc,
            selectedCurrency: selectedCurrency,
            selectedCryptoCurrency: 'ETH',
          ),
          CurrencyCard(
            currentPrice: btc,
            selectedCurrency: selectedCurrency,
            selectedCryptoCurrency: 'LTC',
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : getAndroidPicker(),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key key,
    @required this.selectedCryptoCurrency,
    @required this.currentPrice,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String currentPrice;
  final String selectedCurrency;
  final String selectedCryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCryptoCurrency = $currentPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
