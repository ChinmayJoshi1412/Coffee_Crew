import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brewtile.dart';
import 'package:brew_crew/shared/loading.dart';
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return brews==null? Loading(): ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: brews?.length ?? 0,
    itemBuilder: (context,index){
      return brewtile(brews![index]);
    },);
  }
}
