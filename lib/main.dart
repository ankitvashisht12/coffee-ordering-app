import 'package:coffee_ordering_app/models/user.dart';
import 'package:coffee_ordering_app/screens/wrapper.dart';
import 'package:coffee_ordering_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().userStream,
        child: MaterialApp( 
        title: 'Cafe Cup',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'ProductSans',
          primarySwatch: Colors.brown,
        ),
        home: Wrapper(),
      ),
    );
  }
}

