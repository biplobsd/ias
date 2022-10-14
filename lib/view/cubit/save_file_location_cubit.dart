import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'save_file_location_state.dart';

class SaveFileLocationCubit extends Cubit<SaveFileLocationState> {
  SaveFileLocationCubit() : super(SaveFileLocationInitial());

  void showMsg(String msg) => emit(SaveFileLocationShowAgain(msg: msg));
}
