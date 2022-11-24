import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class brewtile extends StatelessWidget {

  final Brew brew;
  brewtile(this.brew);
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 20,
      shadowColor: Colors.black,
      margin: EdgeInsets.fromLTRB(20, 6, 20,0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/coffee_icon.png'),
          radius: 25,
          backgroundColor: Colors.brown[brew.strength],
        ),
        title: Text(brew.name,style: TextStyle(color: Colors.brown[900]),),
        subtitle: Text('Take ${brew.sugars} sugar(s)'),
      ),
    ),);
  }
}
