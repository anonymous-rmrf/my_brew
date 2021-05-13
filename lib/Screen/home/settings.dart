import 'package:brew_manager/Screen/services/database.dart';
import 'package:brew_manager/model/user.dart';
import 'package:brew_manager/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_manager/shared/constants.dart';
import 'package:provider/provider.dart';

class Settingform extends StatefulWidget {
  @override
  _SettingformState createState() => _SettingformState();
}

class _SettingformState extends State<Settingform> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  // form values
  String _currentname;
  String _currentsugars;
  int _currentstrong;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomerUser>(context);


    return StreamBuilder<UserData>(
        stream: DbService(uid: user.uid).userData,
        builder: (context, snapshot) {    //snapshot not to be confused with firebase , ye stream snapshot hai
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textdeco,
                      validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentname = val),
                    ),
                    SizedBox(height: 10.0),
                    //dropdown
                    DropdownButtonFormField(
                      decoration: textdeco,
                      value: _currentsugars ?? userData.sugars,
                      items: sugars.map((sugar){
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar cube sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentsugars = val),
                    ),
                    //slider11
                    Slider(
                      value: (_currentstrong ?? userData.strong).toDouble(),      // if pehele koi data nahi hai default 100 or last apllied assign kar denge
                      activeColor: Colors.brown[_currentstrong ?? userData.strong],
                      inactiveColor: Colors.brown[_currentstrong ?? userData.strong],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) => setState(() => _currentstrong = val.round()),
                    ),
                    //button
                    SizedBox(height: 10.0),
                    ElevatedButton(
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                        if(_formkey.currentState.validate()){
                          await DbService(uid: user.uid).updatedata(
                            _currentsugars ?? userData.sugars,
                            _currentname ?? userData.name,
                            _currentstrong ?? userData.strong,
                          );
                          Navigator.pop(context);
                        }
                        }
                    )
                  ],
                )



            );
          }
          else{
            return Loading();
          }
        }
    );
  }
}
