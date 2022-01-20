import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Splash_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 300,
                  child: Image(image: AssetImage('assets/images/logo.jpeg'),)),
              SizedBox(height: 10,),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: 'SHOP',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold)),
                        TextSpan(text: 'MART',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
                      ]
                  )
              ),
              Text('EXPECT THE UNEXPECTED',style: TextStyle(fontSize: 10),)
            ],
          )
      ),
    );
  }
}