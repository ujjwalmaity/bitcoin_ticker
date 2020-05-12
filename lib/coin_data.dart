import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiUrl = 'https://api.nomics.com/v1/currencies/ticker';
const apiKey = 'demo-26240835858194712a4f8cc0dc635c7a';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      var url = '$apiUrl?key=$apiKey&ids=$crypto&interval=1d,30d&convert=$selectedCurrency';

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var lastPrice = jsonResponse[0]['price'];
        cryptoPrices[crypto] = lastPrice.split('.')[0];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
