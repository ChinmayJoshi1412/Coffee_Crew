import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final formkey = GlobalKey<FormState>();
  final List <Color> color = [Color(0xFF24D9A2),Color(0xFFF05050),Color(0xFF52CEEA),Color(0xFF9552EA),Color(0xFFEA52A4)];
  final List<String> sugars = ['0','1','2','3','4'];
  String? currentname;
  String? currentsugars;
  int? currentstrength;
  String? currentnote;
  int? currenttilecolor;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
          {
            UserData? userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Text('Update your brew settings.',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF636363)),),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Name',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFDBE0E5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            initialValue: userData!.name,
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                            onChanged: (val) => setState(() {
                              currentname = val;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('No. of sugar cubes',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFDBE0E5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                            value: currentsugars ?? userData!.sugars,
                            items:sugars.map((sugar){
                              return DropdownMenuItem(
                                  value: sugar,
                                  child: Text('$sugar'));
                            }).toList(),
                            onChanged:(val) => setState(() {
                              currentsugars = val!;
                            }), ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Coffee concentration',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
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
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('A note for your crew to see',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFDBE0E5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            initialValue: userData!.note,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            validator: (val) => val!.isEmpty ? 'Please enter a note' : null,
                            onChanged: (val) => setState(() {
                              currentnote = val;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Tile color',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Color(0xFFDBE0E5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            value: currenttilecolor ?? userData!.tilecolor,
                            items:color.map((c){
                              return DropdownMenuItem(
                                  value: color.indexOf(c),
                                  child: CircleAvatar(
                                    backgroundColor: c,
                                  ));
                            }).toList(),
                            onChanged:(val) => setState(() {
                              currenttilecolor = val!;
                            }), ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shadowColor: Color(0xFF31DEAA),
                              primary: Color(0xFF24D9A2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text('Update',style: TextStyle(color: Colors.white),),
                          ),
                          onPressed: () async{
                            print(user.uid);
                            print(currentstrength);
                            print(currentname);
                            print(currentsugars);
                            await DatabaseService(user.uid).updateUserData(
                                currentsugars ?? snapshot.data!.sugars,
                                currentname ?? snapshot.data!.name,
                                currentstrength ?? snapshot.data!.strength,
                                currentnote ?? snapshot.data!.note,
                                currenttilecolor ?? snapshot.data!.tilecolor
                            );
                            Navigator.pop(context);
                            },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  )),
            );
          }
            else{
              return Loading();
        }
      }
    );
  }
}
