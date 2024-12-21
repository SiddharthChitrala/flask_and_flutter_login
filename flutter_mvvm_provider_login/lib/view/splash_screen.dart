import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_provider_login/utils/routes/routes_name.dart';

import '../vm/auth_view_model.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final user = await authViewModel.getUser(''); // Check user status
    if (user != null) {
      // User exists, navigate to home
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      });
    } else {
      // No user found, navigate to login
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
