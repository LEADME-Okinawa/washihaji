import 'package:flutter/material.dart';
import '../utils/currency_data.dart';
import '../components/currency_conversion_row.dart';
import '../components/custom_appbar.dart';
import '../components/information_input.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  CurrencyConverterScreenState createState() => CurrencyConverterScreenState();
}

class CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _yenController = TextEditingController();
  String _selectedCurrency = 'USD';
  double _convertedAmount = 0.0;

  void _convertCurrency() {
    setState(() {
      final yen = double.tryParse(_yenController.text) ?? 0.0;
      _convertedAmount = yen * (exchangeRates[_selectedCurrency] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InformationInput(
              yenController: _yenController,
              selectedCurrency: _selectedCurrency,
              onCurrencyChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCurrency = newValue;
                    _convertCurrency();
                  });
                }
              },
              onYenChanged: (String value) {
                _convertCurrency();
              },
            ),
            const SizedBox(height: 16),
            _buildConversionResult(),
            const SizedBox(height: 16),
            _buildCurrencyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionResult() {
    return Text(
      '${_yenController.text} yen = ${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCurrencyList() {
    return Expanded(
      child: ListView.builder(
        itemCount: currencyUnits.length,
        itemBuilder: (context, index) {
          final item = currencyUnits[index];
          return CurrencyConversionRow(
            yenValue: item['value'],
            imagePath: item['image'],
            selectedCurrency: _selectedCurrency,
          );
        },
      ),
    );
  }
}
