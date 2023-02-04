import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
class SignUp extends StatefulWidget {
  Function toggleview;
  SignUp(this.toggleview);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService auth = AuthService();
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8),
        child: AppBar(
          backgroundColor: Color(0xFF8A6360),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Image(image: AssetImage('assets/authenticate_image.png'),fit: BoxFit.fill,)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sign In',style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Color(0xff636363)
                            ),),
                            Switch(
                              value: true,
                              onChanged: (value){
                                widget.toggleview();
                              },
                              trackColor: MaterialStateProperty.all(Color(0xFFE0DBDB)),
                              thumbColor: MaterialStateProperty.all(Color(0xFF24D9A2)),),
                            Text('Sign Up',style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Color(0xff636363)
                            ),)
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xFFB2B2B2),
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text('Email',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDBE0E5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
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
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text('Password',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xff636363)
                          ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDBE0E5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              validator: (val) => val!.length<6?'Enter a password with 6+ characters':null,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              obscureText: true,
                              onChanged: (val){
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 29,),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shadowColor: Color(0xFF31DEAA),
                            primary: Color(0xFF24D9A2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed:() async{
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 116),
                          child: Text('Register',style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white
                          ),),
                        ), ),
                      GestureDetector(
                        child: Padding(padding: EdgeInsets.only(top: 10),
                          child: RichText(
                              text: TextSpan(
                              children:[
                                TextSpan(
                                    text: "By clicking the above button, I agree to the app's  ",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700]
                                    )
                                ), TextSpan(
                                    text: "Privacy Policy",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async{
                                        print('Hello');
                                        Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/f107784c-1e8e-4af9-98e9-245cf5d6f54a');
                                        if(await canLaunchUrl(url))
                                        {
                                          await launchUrl(url);
                                        }
                                        else
                                        {
                                          print('Nope');
                                        }
                                      }),

                              ])),),
                        onTap: (){
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 101),
                        child: Container(
                          child: Image(image: AssetImage('assets/coffee_beans.png'),alignment: Alignment.bottomCenter),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
