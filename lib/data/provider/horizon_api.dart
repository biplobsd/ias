import 'package:dio/dio.dart';

import 'path/horizon_path.dart';

class HorizonApi {
  late Dio client;

  HorizonApi() {
    client = Dio(
      BaseOptions(
        baseUrl: HorizonPath.base,
      ),
    );
    // client.options.headers = <String, String>{
    //   'user-agent':
    //       'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.46 Safari/537.36',
    // };
  }

  Future<void> getAssetAccount(String accountAddress) async {
    final Response response;
    try {
      response = await client.get<dynamic>(
        '${HorizonPath.accounts}/$accountAddress',
      );
    } on Exception {
      // print(e);
      return;
    }
    // if (kDebugMode) {
    //   print('Accounts Data: ${response.data['balances']}');
    // }
  }

    Future<String> getPP() async {
    // ignore: unused_local_variable
    final Response response;
    try {
      response = await client.get<dynamic>(
        HorizonPath.privacyPolicy,
      );
      return response.data as String;
    } on Exception {
      // print(e);
      return '';
    }
  }
}
