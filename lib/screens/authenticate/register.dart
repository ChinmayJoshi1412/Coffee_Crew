import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
class Register extends StatefulWidget {
  Function toggleview;
  Register(this.toggleview);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService auth = AuthService();
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error ='';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text('Sign up to Brew Crew',
          style: TextStyle(
            color: Colors.brown[900]
          ),),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            TextButton.icon(onPressed:(){
              widget.toggleview();
            },
              icon: Icon(Icons.person),
              label:Text('Sign In'),
              style: TextButton.styleFrom(
                  primary: Colors.brown[900]
              ),)
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30,350),
          child: Card(
            shadowColor: Colors.black,
            elevation: 40,
            color: Colors.brown[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val){
                        if(val!.isEmpty) {
                          return 'Enter an email';

                          }
                        else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (val) => val!.length<6?'Enter a password with 6+ characters':null,
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () async{
                      if(formkey.currentState!.validate())
                        {
                          setState(() {
                            loading = true;
                          });
                      dynamic result = await auth.registerwithemailandpassword(email, password);
                      if(result==null)
                        {
                         setState(() {
                           loading = false;
                           error = 'Please use a valid email';
                         });
                        }
                    }}, child:Text('Register'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[600],
                          elevation: 10,
                          shadowColor: Colors.black
                      ),),
                    SizedBox(height: 10,),
                    Text(error,style: TextStyle(color: Colors.red[700],fontSize: 14),)
                  ],
                ),
              ),
            ),
          ),
        ));;
  }
}
