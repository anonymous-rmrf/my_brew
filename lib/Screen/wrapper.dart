
import 'package:brew_manager/Screen/auth/auth.dart';
import 'package:brew_manager/Screen/home/home.dart';
import 'package:brew_manager/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//wrapper will listen for auth chjanges so as to decide wheter to show register or home page etc
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerUser>(context);
    print(user);

    //either home or dusra wala
    if (user == null) {
      return Auth();
    }
    else {
      return Home();
    }
  }
}