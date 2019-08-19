import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'price_screen.dart';
import 'package:bitcoin_ticker/services/bitcoin_average.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => BitcoinApiService.create(),
      dispose: (_, BitcoinApiService service) => service.dispose(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white),
        home: PriceScreen(),
      ),
    );
  }
}
