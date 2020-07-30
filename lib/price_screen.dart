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
  String currentPrice = '?';

  Future<dynamic> getPriceData() async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$url/BTC/USD?apikey=$kapikey');
    var priceData = await networkHelper.getData();
    updateUI(priceData);
  }

  void updateUI(dynamic priceData) {
    setState(() {
      String halwa = priceData['rate'].toStringAsFixed(2);
      currentPrice = halwa;
    });
  }

  @override
  void initState() {
    super.initState();
    getPriceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $currentPrice USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: IOSPicker(),
          ),
        ],
      ),
    );
  }
}

//Platform.isIOS ? IOSPicker() : AndroidPicker()
