import 'package:flutter/material.dart';
import 'screens/currency_converter_screen.dart';

void main() {
  runApp(const WashihajiApp());
}

class WashihajiApp extends StatelessWidget {
  const WashihajiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'washihaji',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CurrencyConverterScreen(),
    );
  }
}
