import 'package:flutter/material.dart';
import '../utils/currency_data.dart';
import '../widgets/currency_conversion_row.dart';

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
      double yen = double.tryParse(_yenController.text) ?? 0.0;
      _convertedAmount = yen * (exchangeRates[_selectedCurrency] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('washihaji'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _yenController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount in yen',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _convertCurrency(),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                  _convertCurrency();
                });
              },
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              '${_yenController.text} yen = ${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
