import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_provider_login/utils/routes/routes_name.dart';

import 'utils/routes/routes.dart';
import 'vm/auth_view_model.dart';
import 'vm/user_view_model.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
