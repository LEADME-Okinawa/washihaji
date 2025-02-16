import 'package:flutter/material.dart';
import 'custom_textfield.dart';
import 'custom_dropdown.dart';

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
          CustomTextField(
            controller: yenController,
            onChanged: onYenChanged,
          ),
          const SizedBox(height: 16),
          CustomDropdown(
            selectedCurrency: selectedCurrency,
            onChanged: onCurrencyChanged,
          ),
        ],
      ),
    );
  }
}
