part of 'get_privacy_policy_cubit.dart';

@immutable
abstract class GetPrivacyPolicyState {}

class GetPrivacyPolicyInitial extends GetPrivacyPolicyState {}

class GetPrivacyPolicyFound extends GetPrivacyPolicyState {
  final String data;
  GetPrivacyPolicyFound({
    required this.data,
  });
}

class GetPrivacyPolicyError extends GetPrivacyPolicyState {
  final String errorMsg;
  GetPrivacyPolicyError({
    required this.errorMsg,
  });
}

class GetPrivacyPolicyLoading extends GetPrivacyPolicyState {}
