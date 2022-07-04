part of 'packageinfo_cubit.dart';

@immutable
abstract class PackageinfoState {}

class PackageinfoInitial extends PackageinfoState {}

class PackageinfoLoading extends PackageinfoState {}

class PackageinfoFound extends PackageinfoState {
  late final PackageInfo packageInfo;
  PackageinfoFound({
    required this.packageInfo,
  });
}

class PackageinfoError extends PackageinfoState {}
