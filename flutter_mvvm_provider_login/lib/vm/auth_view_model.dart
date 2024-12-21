import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../provider/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login(String userIdentifier, String otp, BuildContext context) async {
    setLoading(true);
    try {
      final data = {'userIdentifier': userIdentifier, 'otp': otp};
      final user = await _authRepository.loginApi(data);

      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      await userViewModel.saveUser(user); // Save user details in local storage

      Utils.toastMessage('You have logged in successfully.');
      Navigator.pushReplacementNamed(context, RoutesName.home);
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    try {
      final user = await _authRepository.createUser(data);

      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      await userViewModel.saveUser(user); // Save user details in local storage

      Utils.toastMessage('You have registered successfully.');
      Navigator.pushReplacementNamed(context, RoutesName.home);
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  Future<UserModel?> getUser(String userIdentifier) async {
    try {
      return await _authRepository.getUser(userIdentifier);
    } catch (e) {
      return null; // Return null if there is any error
    }
  }
}
