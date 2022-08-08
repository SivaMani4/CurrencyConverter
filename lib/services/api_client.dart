import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  String uri = "https://0gzg3.mocklab.io/json/1";

  Future<List<String>> getCurrencies() async {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      final list = responseBody["pairs"];
      List<String> currencies = [];
      for (final currency in (list as List)) {
        final currencyValue = currency["from"];
        if (!currencies.contains(currencyValue)) {
          currencies.add(currencyValue);
        }
      }
      return currencies;
    } else {
      throw Exception("Failed to connect to API");
    }
  }

  Future<String> setRate(String? from, String? to) async {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      final list = responseBody["rates"];
      String rate = "0";
      for (final rateItem in (list as List)) {
        if (rateItem["from"] == from && rateItem["to"] == to) {
          rate = rateItem["rate"];
        }
      }
      return rate;
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
