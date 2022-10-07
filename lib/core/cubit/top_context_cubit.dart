import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/horizon.dart';
part 'top_context_state.dart';

class TopContextCubit extends Cubit<TopContextState> {
  late BuildContext topContextBackup;
  final Horizon horizon;
  TopContextCubit({required this.horizon}) : super(TopContextInitial());
}
