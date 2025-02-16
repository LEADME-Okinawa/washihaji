import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    _initializeExchangeRates();
  }

  Future<void> _initializeExchangeRates() async {
    await fetchExchangeRates();
    setState(() {});
  }

  Future<void> _convertCurrency() async {
    final yen = double.tryParse(_yenController.text) ?? 0.0;
    final url = Uri.parse(
      'http://163.43.144.171:8080/api/v1/transform?money=$yen&from=JPY&to=$_selectedCurrency',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final convertedAmount = double.tryParse(response.body.trim()) ?? 0.0;
        setState(() {
          _convertedAmount = convertedAmount;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error fetching exchange rate')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch exchange rate')),
      );
    }
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
