import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  String? currentname;
  String? currentsugars;
  int? currentstrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
          {
            UserData? userData = snapshot.data;
            return Form(
                key: formkey,
                child: Column(
                  children: [
                    Text('Update your brew settings.',
                      style: TextStyle(fontSize: 18,color: Colors.brown[900]),),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputDecoration.copyWith(hintText: ''),
                      validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() {
                        currentname = val;
                      }),
                    ),
                    SizedBox(height: 20,),
                    DropdownButtonFormField(
                      decoration:textInputDecoration.copyWith(focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown,))),
                      value: currentsugars ?? userData!.sugars,
                      items:sugars.map((sugar){
                        return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar'));
                      }).toList(),
                      onChanged:(val) => setState(() {
                        currentsugars = val!;
                      }), ),
                    Slider(
                      value: (currentstrength ?? userData!.strength).toDouble(),
                      activeColor: Colors.brown[currentstrength??userData!.strength],
                      inactiveColor: Colors.brown[50],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) => setState(() {
                        currentstrength = val.round();
                      }),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[600],
                          elevation: 10,
                          shadowColor: Colors.black
                      ),
                      child: Text('Update'),
                      onPressed: () async{
                        print(user.uid);
                        print(currentstrength);
                        print(currentname);
                        print(currentsugars);
                        await DatabaseService(user.uid).updateUserData(
                            currentsugars ?? snapshot.data!.sugars,
                            currentname ?? snapshot.data!.name,
                            currentstrength ?? snapshot.data!.strength);
                        Navigator.pop(context);
                        },
                    )
                  ],
                ));
          }
            else{
              return Loading();
        }
      }
    );
  }
}
