class CryptoCurrency {
  final double currentPrice;
  final double dailyAverage;
  final String displaySymbol;

  CryptoCurrency(this.currentPrice, this.dailyAverage, this.displaySymbol);

  CryptoCurrency.fromJSON(Map<String, dynamic> json)
      : currentPrice = json['last'],
        dailyAverage = json['averages']['day'],
        displaySymbol = json['display_symbol'];

  Map<String, dynamic> toJSON() => {
        'currentPrice': currentPrice,
        'dailyAverage': dailyAverage,
        'display_symbol': displaySymbol
      };
}
