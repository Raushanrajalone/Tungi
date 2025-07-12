import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginuicolors/Dashboard.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/newpass.dart';
import 'package:loginuicolors/register.dart';
import 'package:loginuicolors/forgotp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is logged in
        if (snapshot.hasData) {
          return MyDashboard();
        }
        // User is not logged in
        return MyLogin();
      },
    ),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'dashboard': (context) => MyDashboard(),
      'forgotp': (context) => Forgotp(),
      'newpass': (context) => newpass(),
    },
  ));
}