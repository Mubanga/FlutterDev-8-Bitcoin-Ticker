import 'dart:convert';

import 'package:bitcoin_ticker/model/cryptocurrency_model.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/services/bitcoin_average.dart';
import 'package:provider/provider.dart';

const TAG = "price_screen.dart :";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String currentPrice = "?";
  List<String> _cryptoPrices = ["?", "?", "?"];
  BitcoinApiService _bitCoinApiService;
  CoinData _coinData;
  List<_buildSingleCard> _cardDisplayCollection = List<_buildSingleCard>();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        String updatedPrice;
        _coinData.getCoinData("BTC", value).then((onValue) {
          print("DropDownButton : Before Decoding Slider Currency = $value");
          //      final decodedPrice = jsonDecode(onValue.body['last']).toString();
          final decodedPrice =
              json.decode(json.encode(onValue['last'])).toString();
          print(
              "DropDownButton : Before SetState $value Price = $decodedPrice");
          updatedPrice = decodedPrice;
        });
        //  initialiseCurrentPrice(value);
        // _coinData.getCoinData("BTC", NormalCurrency)
        //  print("EEEEEE: $str");
        setState(() {
          selectedCurrency = value;
          currentPrice = updatedPrice;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        //  printResponse();
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart

  @override
  void initState() {
    super.initState();
    //print("initState : BEFORE currentPrice = $currentPrice");
    _bitCoinApiService = Provider.of<BitcoinApiService>(context, listen: false);
    _coinData = CoinData(_bitCoinApiService);
//    initialiseCurrentPrice();
    //print("initState : AFTER currentPrice = $currentPrice");
    // This should work because we are in essence calling provider from one level
    // down on the Widget tree.

    //TODO: Call getData() when the screen loads up.
  }

//  Future<String> initialiseCurrentPrice(String currency) async {
//    final resBody = await _coinData.getCoinData("BTC", currency);
//    currentPrice = json.decode(json.encode(resBody['last'])).toString();
//    //  final decodedString = json.decode(json.encode(resBody['last']));
//    print("initialiseCurrentPrice : ${currentPrice}");
//    return currentPrice;
//    // print("As I Print Here : $resBody ");
//    //  return resBody;
//  }

  @override
  Widget build(BuildContext context) {
//    _bitCoinApiService = Provider.of<BitcoinApiService>(context);
//    _coinData = CoinData(_bitCoinApiService);
    //   initialiseCurrentPrice("USD");
//    _bitCoinApiService = Provider.of<BitcoinApiService>(context);
//    _coinData = CoinData(_bitCoinApiService);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: _buildPriceScreenBody(context),
    );
  }

  FutureBuilder _buildMultiBitcoinCards(BuildContext context) {
    return FutureBuilder(
        future: _coinData.getCoinData("BTC", selectedCurrency),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //   Map jsonMap = jsonDecode(jsonEncode(snapshot.data));
            Map jsonMap = Map<String, dynamic>.from(snapshot.data);
            print(" API Map Values = ${jsonMap['last'].toString()} ");
            CryptoCurrency cryptoCurrency = CryptoCurrency.fromJSON(jsonMap);
            currentPrice = cryptoCurrency.currentPrice.toString();
            print(
                "FutureBuilder: BTC $selectedCurrency Current Price Is = $currentPrice");
            return _buildBitCoinBody();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  FutureBuilder _buildPriceScreenBody(BuildContext context) {
    return FutureBuilder(
        future: _coinData.getCoinData("BTC", selectedCurrency),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //   Map jsonMap = jsonDecode(jsonEncode(snapshot.data));
            Map jsonMap = Map<String, dynamic>.from(snapshot.data);
            print(" API Map Values = ${jsonMap['last'].toString()} ");
            CryptoCurrency cryptoCurrency = CryptoCurrency.fromJSON(jsonMap);
            currentPrice = cryptoCurrency.currentPrice.toString();
            print(
                "FutureBuilder: BTC $selectedCurrency Current Price Is = $currentPrice");
            return _buildBitCoinBody();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Column _buildBitCoinBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          children: <Widget>[
            LimitedBox(maxHeight: 200, child: _buildListItems())
//            for (int x = 0; x < cryptoList.length; x++)
//              _buildSingleCard(
//                  crypto: cryptoList[x],
//                  currentPrice: currentPrice,
//                  selectedCurrency: selectedCurrency),
          ],
        ),
        Container(
          height: 150.0,
          alignment: Alignment.center,
          //  padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.lightBlue,
          child: Platform.isIOS ? iOSPicker() : androidDropdown(),
        ),
      ],
    );
  }

  Widget _buildListItems() {
    return ListView.builder(
        itemCount: cryptoList.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return FutureBuilder(
              future:
                  _coinData.getCoinData(cryptoList[index], selectedCurrency),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //   Map jsonMap = jsonDecode(jsonEncode(snapshot.data));
                  Map jMap = Map<String, dynamic>.from(snapshot.data);
                  print(" API Map Values = ${jMap['last'].toString()} ");
                  CryptoCurrency cryptoCurrency = CryptoCurrency.fromJSON(jMap);
                  currentPrice = cryptoCurrency.currentPrice.toString();
                  print(
                      "FutureBuilder: ${cryptoList[index]} $selectedCurrency Current Price Is = $currentPrice");
                  return _buildSingleCard(
                    crypto: cryptoList[index],
                    currentPrice: currentPrice,
                    selectedCurrency: selectedCurrency,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        });
  }
}

class _buildSingleCard extends StatelessWidget {
  const _buildSingleCard({
    Key key,
    @required this.crypto,
    @required this.currentPrice,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String crypto;
  final String currentPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 4, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $crypto = $currentPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
