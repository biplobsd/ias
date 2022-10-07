import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'packageinfo_state.dart';

class PackageinfoCubit extends Cubit<PackageinfoState> {
  PackageinfoCubit() : super(PackageinfoInitial()) {
    getPackageInfo();
  }

  Future<void> getPackageInfo() async {
    emit(PackageinfoLoading());
    try {
      emit(PackageinfoFound(packageInfo: await PackageInfo.fromPlatform()));
    } on Exception {
      emit(PackageinfoError());
    }
  }
}
