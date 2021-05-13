import 'package:brew_manager/Screen/auth/register.dart';
import 'package:brew_manager/Screen/auth/sign_in.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget {

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool showSignIn = true;
  void toggle(){
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
        if(showSignIn){
          return SignIn(toggle: toggle);
    } else {
          return Register(toggle: toggle);
    }

  }
}
