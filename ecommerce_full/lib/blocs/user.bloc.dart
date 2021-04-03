import 'dart:convert';

import 'package:ecommerce_full/models/authenticate-user.model.dart';
import 'package:ecommerce_full/models/create-user.model.dart';
import 'package:ecommerce_full/models/user.model.dart';
import 'package:ecommerce_full/repositories/account.repository.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  var user = UserModel();
  final accountRepository = AccountRepository();

  UserBloc() {
    user = null;
    loadUser();
  }

  Future loadUser() async {
    var prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('user');

    if (user != null) {
      var json = jsonDecode(userData);
      user = UserModel.fromJson(json);
      Settings.user = user;
    }
  }

  Future<UserModel> create(CreateUserModel model) async {
    try {
      final res = await accountRepository.create(model);
      return res;
    } catch (err) {
      return _errorHandler(err);
    }
  }

  Future logout() async {
    var prefs = await SharedPreferences.getInstance();
    user = null;
    await prefs.setString('user', null);
    Settings.user = user;
    notifyListeners();
  }

  Future<UserModel> authenticate(AuthenticateModel model) async {
    try {
      var prefs = await SharedPreferences.getInstance();

      final res = await accountRepository.authenticate(model);
      user = res;
      await prefs.setString('user', jsonEncode(user));

      notifyListeners();
      return user;
    } catch (err) {
      return _errorHandler(err);
    }
  }

  _errorHandler(err) {
    print(err);
    user = null;
    return null;
  }
}
