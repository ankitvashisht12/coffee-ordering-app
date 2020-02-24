
import 'package:coffee_ordering_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:coffee_ordering_app/screens/home/home.dart';
import 'package:coffee_ordering_app/screens/authenticate/authentiate.dart';
import 'package:provider/provider.dart';

  class Wrapper extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      
      final user = Provider.of<User>(context);

      if(user != null){
        return Home();
      }else{
        return Authenticate();
      }
    }
  }

