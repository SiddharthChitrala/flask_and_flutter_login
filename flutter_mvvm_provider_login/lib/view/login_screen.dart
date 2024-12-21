import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_provider_login/utils/utils.dart';

import '../vm/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userIdentifierController = TextEditingController();
  final _otpController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _userIdentifierController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    try {
      await authViewModel.login(
        _userIdentifierController.text,
        _otpController.text,
        context,
      );
    } catch (e) {
      Utils.toastMessage(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userIdentifierController,
              decoration: InputDecoration(labelText: 'User Identifier'),
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_loading)
              Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
