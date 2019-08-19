// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitcoin_average.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$BitcoinApiService extends BitcoinApiService {
  _$BitcoinApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = BitcoinApiService;

  Future<Response> getCryptoCurrecncyData(String CryptoID) {
    final $url = '/ticker/${CryptoID}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
