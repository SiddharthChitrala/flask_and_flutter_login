import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userIdentifier', user.userIdentifier ?? '');
    notifyListeners();
    return true;
  }

  Future<UserModel?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userIdentifier = sp.getString('userIdentifier');

    if (userIdentifier != null) {
      return UserModel(userIdentifier: userIdentifier);
    }
    return null;
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('userIdentifier');
    notifyListeners();
    return true;
  }
}
