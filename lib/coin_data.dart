//TODO: Add your imports here.
import 'package:bitcoin_ticker/services/bitcoin_average.dart';
import 'package:provider/provider.dart';

const TAG = "coin_data.dart :";

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD';

class CoinData {
  BitcoinApiService _bitcoinApiService;

  CoinData(BitcoinApiService service) {
    _bitcoinApiService = service;
  }

  Future getCoinData(String CryptoType, String NormalCurrency) async {
    // We can maybe mae this more type safe by having the currency type and crypto type as values
    if (CryptoType == "" && NormalCurrency == "") {
      CryptoType = "BTC";
      NormalCurrency = "USD";
    }
    print("$TAG : ${CryptoType + NormalCurrency}");
    final response = await _bitcoinApiService
        .getCryptoCurrecncyData("${CryptoType + NormalCurrency}");
    if (!response.isSuccessful) {
      print("$TAG Error Server Response Code ${response.statusCode}");
    } else {
      print("$TAG Success API Data Fetched Now Returning...");
      //  print("$TAG Response Body = ${response.body}");
    }

    return response.body;
  }

//TODO: Create your getCoinData() method here.
//  Provider.of
//  final _bitcoinAPI = Provider.of<BitcoinApiService>(context)
}
