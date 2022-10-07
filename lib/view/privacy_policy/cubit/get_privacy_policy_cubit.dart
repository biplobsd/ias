import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/horizon.dart';

part 'get_privacy_policy_state.dart';

class GetPrivacyPolicyCubit extends Cubit<GetPrivacyPolicyState> {
  final Horizon horizon;
  GetPrivacyPolicyCubit({
    required this.horizon,
  }) : super(GetPrivacyPolicyInitial());

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/privacy_policy.md');
  }

  void fetch() async {
    emit(GetPrivacyPolicyLoading());
    String rawData = await horizon.getPP();
    String data;
    try {
      if (rawData.isNotEmpty) {
        data = rawData;
      } else {
        data = await loadAsset();
      }
    } catch (e) {
      emit(GetPrivacyPolicyError(errorMsg: e.toString()));
      return;
    }
    emit(GetPrivacyPolicyFound(data: data));
  }
}
