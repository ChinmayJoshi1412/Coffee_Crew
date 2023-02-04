import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings.dart';
import 'package:google_fonts/google_fonts.dart';
class Home extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService("").brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(3),
              child: Image(image: AssetImage('assets/CoffeeCrew.png'),),
            ),
            leadingWidth: 100,
            backgroundColor: Color(0xFF8A6360),
            elevation: 0,
            actions: [
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return Dialog(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)
                   ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 400,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Container(
                                  child: Text('About',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xff636363)
                                  ),),
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Text("Coffee Crew is an app that stores the brew preferences of members of a team.",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Color(0xff636363)
                                  ),),
                              ),
                              SizedBox(height: 25,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Text("Tip:",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xff636363)
                                  ),),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Text("Go to the settings tab to change your brew preference.",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Color(0xff636363)
                                  ),),
                              ),
                              SizedBox(height: 25,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Text("Developed by Chinmay Joshi",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xff636363)
                                  ),),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Text("Designed by Taha Habib",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xff636363)
                                  ),),
                              ),
                              SizedBox(height: 25,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: Color(0xFFB87F7F)
                                ),
                                alignment: Alignment.bottomCenter,
                                height: 124,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Image(image: AssetImage('assets/CoffeeCrew.png'),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }, icon: Icon(Icons.info), color: Color(0xFFE5BEBB)),
              SizedBox(width: 8,),
              IconButton(
                onPressed: () async {
                await auth.signout();
              },
                icon: Icon(Icons.logout,color: Color(0xFFE5BEBB),),
                ),
              IconButton(
                onPressed:(){
                showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context){
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                    child: SettingsForm(),
                  );
                });
              } ,icon: Icon(Icons.settings),
                color: Color(0xFFE5BEBB),
                )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Image(image: AssetImage('assets/Home_Image.png'),fit: BoxFit.fitWidth,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 20,0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Your Crew',style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xff636363)
                ),),
              ),
            ),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey,Colors.grey.withOpacity(0),Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent,Colors.grey.withOpacity(0),Colors.grey],
                ).createShader(rect);
              },
                blendMode: BlendMode.dstOut,
                child: Material(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        child: BrewList()),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),//BrewList()),
      ),
    );

  }
}
