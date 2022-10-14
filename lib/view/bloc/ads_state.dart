part of 'ads_bloc.dart';

@immutable
abstract class AdsState {}

class AdsInitial extends AdsState {}

class AdsLoaded extends AdsState {
  AdsLoaded();
}

class AdsLoading extends AdsState {}

class AdsDismis extends AdsState {}

class AdsError extends AdsState {}
