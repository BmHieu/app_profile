part of 'db_cubit.dart';

abstract class DbState extends Equatable {
  final List<Object> objProps;
  const DbState({required this.objProps});

  @override
  List<Object> get props => objProps;
}

class DbInitial extends DbState {
  const DbInitial({required super.objProps});
}

class InitDbFailed extends DbState {
  final String error;
  InitDbFailed({required this.error}) : super(objProps: [error]);

  @override
  String toString() => 'DbInitialFailed { error: $error }';
}

class SyncDataFailure extends DbState {
  final String error;
  SyncDataFailure({required this.error}) : super(objProps: [error]);

  @override
  String toString() => 'SyncDataFailure { error: $error }';
}

class InitDbSuccess extends DbState {
  const InitDbSuccess({required super.objProps});

  @override
  String toString() => 'InitDbSuccess';
}
