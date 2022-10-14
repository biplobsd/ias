import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final List<BannerAd> myBanners = List.generate(
      3,
      (index) => BannerAd(
            adUnitId: kDebugMode
                ? 'ca-app-pub-3940256099942544/6300978111' // test id
                : 'ca-app-pub-4723890116506303/7702855578', // real id
            size: AdSize.banner,
            request: const AdRequest(),
            listener: const BannerAdListener(),
          ));

  AdsBloc() : super(AdsInitial()) {
    on<AdsBanarLoadEvent>((event, emit) async {
      emit(AdsLoading());
      for (var element in myBanners) {
        element.load();
      }
      emit(AdsLoaded());
    });
  }

  @override
  Future<void> close() {
    for (var element in myBanners) {
        element.dispose();
      }
    return super.close();
  }
}
