import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:google_fonts/google_fonts.dart';
class brewtile extends StatelessWidget {
  List <Color> color = [Color(0xFF24D9A2),Color(0xFFF05050),Color(0xFF52CEEA),Color(0xFF9552EA),Color(0xFFEA52A4)];
  final Brew brew;
  brewtile(this.brew);
  @override
  Widget build(BuildContext context) {
    print(brew.note.length);
    return Padding(padding: EdgeInsets.all(10),
    child: Container(
      height: 120,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Color(0xFFBABABA),
            width: 1
          )
        ),
        margin: EdgeInsets.fromLTRB(20, 6, 20,0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: color[brew.tilecolor]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:15),
              child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/coffee_icon.png'),
                radius: 35,
                backgroundColor: Colors.brown[brew.strength],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(brew.name,style: GoogleFonts.montserrat(fontSize: 15, color: Color(0xff636363),fontWeight: FontWeight.bold)),
                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/sugarcubes.png'),height: 15,),
                      SizedBox(width: 5),
                      Text('Take ${brew.sugars} sugar(s)',style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Color(0xff636363),)),

                    ],
                  ),
                  SizedBox(height: 15),
                  Text("~ ${brew.note}",style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),),
                ],
              ),
          ),
            ),
        ]),
      ),
    ),);
  }
}
