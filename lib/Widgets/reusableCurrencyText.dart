import 'package:flutter/material.dart';

class ReusableCurrencyText extends StatelessWidget {
  const ReusableCurrencyText(
      {super.key,
      required this.cryptoCurrency,
      required this.exchangeRate,
      required this.selectedCurrency});
  final String? cryptoCurrency;
  final String? exchangeRate;
  final String? selectedCurrency;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $exchangeRate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
