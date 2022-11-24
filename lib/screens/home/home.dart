import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings.dart';
class Home extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService("").brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Brew Crew',style: TextStyle(color: Colors.brown[900]),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton.icon(onPressed: () async {
              await auth.signout();
            },
              label:Text('Log out'),
              icon: Icon(Icons.person),
            style: TextButton.styleFrom(
              primary: Colors.brown[900]
            ),),
            TextButton.icon(onPressed:(){
              showModalBottomSheet<void>(context: context,builder: (BuildContext context){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                  child: SettingsForm(),
                );
              });
            } ,icon: Icon(Icons.settings),
            label: Text('Settings'),
            style: TextButton.styleFrom(
              primary: Colors.brown[900]
            ),)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover
            )
          ),
            child: BrewList()),
      ),
    );

  }
}
