import 'package:dailycanhan/services/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'db_state.dart';

class DbCubit extends Cubit<DbState> {
  DbCubit() : super(const DbInitial(objProps: []));

  Future<void> initLocalDb() async {
    try {
      await AppHiveDb.instance.init();
      emit(const InitDbSuccess(objProps: []));
    } catch (error) {
      emit(InitDbFailed(error: error.toString()));
    }
  }

  Future<void> syncLocalData() async {}
}
