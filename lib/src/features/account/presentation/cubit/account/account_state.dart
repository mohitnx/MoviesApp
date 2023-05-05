part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class LoadingAccountState extends AccountState {
  @override
  List<Object> get props => [];
}

class LoadedAccountState extends AccountState {
  LoadedAccountState(this.user);

  final User user;

  @override
  Object get props => [user];
}

class ErrorAccountState extends AccountState {
  @override
  List<Object> get props => [];
}
