import 'package:flutter/material.dart';
import '../utils/currency_data.dart';

class InformationInput extends StatelessWidget {
  final TextEditingController yenController;
  final String selectedCurrency;
  final ValueChanged<String?> onCurrencyChanged;
  final ValueChanged<String> onYenChanged;

  const InformationInput({
    super.key,
    required this.yenController,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.onYenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: yenController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter amount in yen',
              border: OutlineInputBorder(),
            ),
            onChanged: onYenChanged,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButton<String>(
              value: selectedCurrency,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, size: 24),
              style: const TextStyle(fontSize: 18, color: Colors.black),
              underline: const SizedBox(),
              onChanged: onCurrencyChanged,
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency, style: const TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
