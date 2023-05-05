import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/account/data/models/user_model.dart';

class AccountRepository {
  final Dio dio;

  AccountRepository(this.dio);
////////////////////////////
  User _user = User(
    id: '',
    token: '',
    name: '',
    password: '',
    email: '',
  );
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
  }

  void setUserFromModel(User user) {
    _user = user;
  }

  /////////////////////////////////
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    final String pathUrl = '$urll/api/signup';
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        token: '',
      );

      var response = await dio.post(
        pathUrl,
        data: user.toJson(),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        print(e);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
