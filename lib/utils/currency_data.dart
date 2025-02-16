import 'package:http/http.dart' as http;

final Map<String, double> exchangeRates = {
  'USD': 0.0,
  'KRW': 0.0,
  'CNY': 0.0,
  'EUR': 0.0,
};

final List<Map<String, dynamic>> currencyUnits = [
  {'value': 10000, 'image': 'assets/images/ten-thousand.png'},
  {'value': 5000, 'image': 'assets/images/five-thousand.png'},
  {'value': 1000, 'image': 'assets/images/thousand.png'},
  {'value': 500, 'image': 'assets/images/five-hundred.png'},
  {'value': 100, 'image': 'assets/images/hundred.png'},
  {'value': 50, 'image': 'assets/images/fifty.png'},
  {'value': 10, 'image': 'assets/images/ten.png'},
  {'value': 5, 'image': 'assets/images/five.png'},
  {'value': 1, 'image': 'assets/images/one.png'},
];

Future<void> fetchExchangeRates() async {
  final currencies = ['USD', 'KRW', 'CNY', 'EUR'];

  for (String currency in currencies) {
    try {
      final response = await http.get(
        Uri.parse(
          'http://163.43.144.171:8080/api/v1/transform?money=1&from=JPY&to=$currency',
        ),
      );

      if (response.statusCode == 200) {
        final String responseBody = response.body.trim();
        final double? rate = double.tryParse(responseBody);

        if (rate != null) {
          exchangeRates[currency] = rate;
        } else {
          print('Unexpected response format for $currency: $responseBody');
        }
      } else {
        print('Error ${response.statusCode}: Failed to fetch $currency');
      }
    } catch (e) {
      print('Exception while fetching $currency: $e');
    }
  }
}
