import 'package:flutter/material.dart';
import '../utils/currency_data.dart';

class CustomDropdown extends StatelessWidget {
  final String selectedCurrency;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onChanged: onChanged,
        items: exchangeRates.keys.map((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(currency, style: const TextStyle(fontSize: 18)),
          );
        }).toList(),
      ),
    );
  }
}
