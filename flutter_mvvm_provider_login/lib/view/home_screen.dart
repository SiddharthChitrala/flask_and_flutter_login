import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/routes/routes_name.dart';
import '../vm/user_view_model.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final user = await userViewModel.getUser();
    setState(() {
      _user = user;
    });
  }

  void _logout() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.removeUser();
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${_user!.name ?? 'User'}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
