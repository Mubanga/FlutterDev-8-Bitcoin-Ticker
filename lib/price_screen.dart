import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _SelectedCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? MaterialDropDownButton()
                : CoupertinoScrollPicker(),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> _DropDownItemBuilder(int NumberOfItems) {
  if (NumberOfItems <= 0 || NumberOfItems >= currenciesList.length) {
    NumberOfItems = currenciesList.length;
  }

  List<DropdownMenuItem<String>> _Items = List<DropdownMenuItem<String>>();
  for (int x = 0; x < NumberOfItems; x++) {
    final CurrentItem = DropdownMenuItem<String>(
      child: Text(currenciesList[x]),
      value: currenciesList[x],
    );
    _Items.add(CurrentItem);
  }
  return _Items;
}

/// Material DropDownButton
class MaterialDropDownButton extends StatefulWidget {
  @override
  _MaterialDropDownButtonState createState() => _MaterialDropDownButtonState();
}

class _MaterialDropDownButtonState extends State<MaterialDropDownButton> {
  String _SelectedCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: _SelectedCurrency,
        items: _DropDownItemBuilder(currenciesList.length),
        onChanged: (value) {
          setState(() {
            _SelectedCurrency = value;
          });
        });
  }
}

/// Cupertino Style Picker
class CoupertinoScrollPicker extends StatefulWidget {
  @override
  _CoupertinoScrollPickerState createState() => _CoupertinoScrollPickerState();
}

class _CoupertinoScrollPickerState extends State<CoupertinoScrollPicker> {
  String _SelectedCurrency;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
        looping: true,
        backgroundColor: Colors.blue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedItemIndex) {
          print("Selected Currency Is ${currenciesList[selectedItemIndex]}");
        },
        children: [for (String currency in currenciesList) Text(currency)]);
  }
}

//DropdownButton<String> _MaterialDropDownButton() {
//  return DropdownButton < String > (
//      value: _SelectedCurrency,
//      items: _DropDownItemBuilder(currenciesList.length),
//  onChanged: (value) {
//  setState(() {
//  _SelectedCurrency = value;
//  });
//  }
