import 'package:brew_manager/Screen/services/auth.dart';
import 'package:brew_manager/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_manager/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to IIIT Brew'),
        actions: <Widget>[
          TextButton.icon(onPressed: (){
            widget.toggle();
          }, icon: Icon(Icons.person, color: Colors.lightBlueAccent,), label: Text('Register', style: TextStyle(color: Colors.white),) )
        ]
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b1.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textdeco.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'email empty, enter valid email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textdeco.copyWith(hintText: 'Password'),
                validator: (value) {
                  bool password = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(value);
                  if (value.isEmpty || !password) {
                    return 'Not a proper password format';
                  }
                  return null;
                },
               // obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate())
                        {setState(() {loading = true;

                        });
                          dynamic result = await _auth.signinemail(email, password);
                      if (result == null){
                        setState(() {
                          error = ('No such user found, plz register if new user') ;
                          loading=false;
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0,),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),)
            ],
          ),
        ),
      ),
    );
  }
}