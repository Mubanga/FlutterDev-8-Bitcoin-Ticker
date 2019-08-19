import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:bitcoin_ticker/coin_data.dart';

part 'bitcoin_average.chopper.dart';

/// So what Chopper Is Basically Trying To Achieve Here Is To Make Sure That
/// Boilerplate Is Eliminated. You Have To Just Extend The "ChopperService"
/// Make Your Class An Abstract Class Necessary For The Codegen Aspect. Essentially
/// The Abstract Class Is The Interface And Then Codegen Goes An Handles The Implementation For You.
///
@ChopperApi(baseUrl: '/ticker')
abstract class BitcoinApiService extends ChopperService {
  @Get(path: '/{symbol}')
  Future<Response> getCryptoCurrecncyData(@Path('symbol') String CryptoID);

  static BitcoinApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://apiv2.bitcoinaverage.com/indices/global',
        services: [_$BitcoinApiService()],
        converter: JsonConverter());
    return _$BitcoinApiService(client);
  }
}
