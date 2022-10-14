part of 'save_file_location_cubit.dart';

@immutable
abstract class SaveFileLocationState {}

class SaveFileLocationInitial extends SaveFileLocationState {}

class SaveFileLocationShowAgain extends SaveFileLocationState {
  final String msg;
  SaveFileLocationShowAgain({
    required this.msg,
  });
}

class SaveFileLocationError extends SaveFileLocationState {}
