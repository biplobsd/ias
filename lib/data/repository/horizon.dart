
import '../provider/horizon_api.dart';

class Horizon {
  late HorizonApi horizonApi;
  Horizon({
    required this.horizonApi,
  });

  Future<void> getAccount(String accountAddress) {
    return horizonApi.getAssetAccount(accountAddress);
  }

  Future<String> getPP() {
    return horizonApi.getPP();
  }
}
