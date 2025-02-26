import 'package:flutter/material.dart';
import '../utils/currency_data.dart';

class CurrencyConversionRow extends StatelessWidget {
  final int yenValue;
  final String imagePath;
  final String selectedCurrency;

  const CurrencyConversionRow({
    super.key,
    required this.yenValue,
    required this.imagePath,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final double convertedValue =
        yenValue * (exchangeRates[selectedCurrency] ?? 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCurrencyImage(context),
          Text(
            '= ${convertedValue.toStringAsFixed(2)} $selectedCurrency',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyImage(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showImageDialog(context, imagePath),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$yenValue yen',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: InteractiveViewer(
              child: Image.asset(imagePath),
            ),
          ),
        );
      },
    );
  }
}
