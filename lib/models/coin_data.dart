import 'dart:convert';
import 'package:bitcoin_ticker/utils/constants.dart';
import 'package:async/async.dart';
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

class CoinData {
  String currency = 'USD';
  String CryptoCurrency = 'BTC';

  Future<dynamic> exchangeRateData(String url) async {
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body); // Assuming JSON response
  }
}
