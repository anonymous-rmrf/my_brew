import 'package:brew_manager/Screen/services/auth.dart';
import 'package:brew_manager/Screen/wrapper.dart';
import 'package:brew_manager/model/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async {
  // These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //root main wala, jo 1st invoke hoga
  @override

  Widget build(BuildContext context) {
    return StreamProvider<CustomerUser>.value(
      value: AuthService().user,      //steams auth data to wrapper cont
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
