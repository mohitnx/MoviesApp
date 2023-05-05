import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/src/features/account/data/models/user_model.dart';
import 'package:movieapp/src/features/account/data/repository/account_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository repository;
  AccountCubit({required this.repository}) : super(AccountInitial());
}
