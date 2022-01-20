import 'package:flutter/material.dart';
import 'package:flutter_todo/users_screen.dart';

import 'bmi_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'messenger_screen.dart';

void main()
{
  runApp(MyApp());
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessengerScreen(),
    );
  }
}