import 'package:flutter/material.dart';
import 'package:flutter_login/screens/login_screen.dart';
import 'package:flutter_login/screens/register_screen.dart';

void main()
{
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}



