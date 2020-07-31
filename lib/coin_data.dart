import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const kapikey = 'A811D413-7C62-465F-B058-0D0802F0BDCB';
const kapikey2 = 'A8000716-2296-4081-B97D-1F1D7F09745D';
const url = 'https://rest.coinapi.io/v1/exchangerate';
Map<String, String> priceData = {};

class CoinData {
  //Function to get data from the API
  Future<dynamic> getData(String selectedCurrency) async {
    try {
      for (String crypto in cryptoList) {
        http.Response response =
            await http.get('$url/$crypto/$selectedCurrency?apikey=$kapikey2');
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          priceData[crypto] = data['rate'].toStringAsFixed(0);
        } else {
          print('Error ${response.statusCode}');
        }
      }
      return priceData;
    } catch (e) {
      print(e);
    }
  }
}
