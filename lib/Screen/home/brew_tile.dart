import 'package:flutter/material.dart';
import 'package:brew_manager/model/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew ;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0,20.0 , 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strong],      //stregth ke hisab se color ka weightage change hoga
            backgroundImage: AssetImage('assets/p1.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
