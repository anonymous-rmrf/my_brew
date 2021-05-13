import 'package:brew_manager/Screen/home/settings.dart';
import 'package:brew_manager/Screen/services/auth.dart';
import 'package:brew_manager/model/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_manager/Screen/services/database.dart';
import 'package:brew_manager/Screen/home/brew_list.dart';
class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Settingform(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DbService().brewdata,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('IIIT Brew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.yellow,),
              label: Text('logout',style: TextStyle(color: Colors.yellow),),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings, color: Colors.yellow,),
              label: Text('settings',style: TextStyle(color: Colors.yellow),),
              onPressed: () => showSettingsPanel(),
            )
        ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/b3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
