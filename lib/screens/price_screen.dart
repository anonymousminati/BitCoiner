import 'package:bitcoin_ticker/models/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'dart:async';

import 'package:bitcoin_ticker/utils/constants.dart';

import 'package:bitcoin_ticker/Widgets/reusableCurrencyText.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    cryptoCurrencyList = []; // Initialize with an empty list
    getCryptoCurrencyList();
  }

  //set periodic timer to update exchange rate every 30 seconds
  Timer? timer;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String? selectedCurrency = currenciesList.first;
  CoinData coinData = CoinData();
  double? exchangeRate;
  List<Widget>? cryptoCurrencyList;

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = currenciesList
        .map((currency) => DropdownMenuItem<String>(
              child: Text(currency),
              value: currency,
            ))
        .toList();
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (newvalue) {
        setState(() {
          selectedCurrency = newvalue.toString();
          getCryptoCurrencyList();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems =
        currenciesList.map((currency) => Text(currency)).toList();
    return CupertinoPicker(
      itemExtent: 32.0, // Adjust item height as needed
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
        });
      },
      children: pickerItems,
    );
  }

  Future<void> getCryptoCurrencyList() async {
    List<Widget> updatedList = [];
    for (String cryptoCurrency in cryptoList) {
      String url =
          '$coinApiUrl$cryptoCurrency/$selectedCurrency?apikey=$apiKey';
      var exchangeRateData = await coinData.exchangeRateData(url);

      setState(() {
        exchangeRate = exchangeRateData['rate'];
        updatedList.add(
          ReusableCurrencyText(
            cryptoCurrency: cryptoCurrency,
            exchangeRate: exchangeRate.toString(),
            selectedCurrency: selectedCurrency,
          ),
        );
      });
    }
    setState(() {
      cryptoCurrencyList = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        getCryptoCurrencyList();
      });
    });

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoCurrencyList == null ? [] : cryptoCurrencyList!,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}
