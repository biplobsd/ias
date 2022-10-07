part of 'reset_cp_cubit.dart';

@immutable
abstract class ResetCpState {}

class ResetCpInitial extends ResetCpState {}

class ResetCpReseting extends ResetCpState {}

class ResetCpReseted extends ResetCpState {}

class ResetCpError extends ResetCpState {
  final String msg;
  ResetCpError({
    required this.msg,
  });
}
