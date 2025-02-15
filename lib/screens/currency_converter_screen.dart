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
      appBar: AppBar(
        title: Image.asset(
          'assets/header_logo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB1D6B5),
        foregroundColor: const Color(0xFF343A40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Information Input',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedCurrency,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, size: 24),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCurrency = newValue!;
                          _convertCurrency();
                        });
                      },
                      items: exchangeRates.keys.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency,
                              style: const TextStyle(fontSize: 18)),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${_yenController.text} yen = ${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
