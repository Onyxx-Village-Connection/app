import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';

class AllDelivery extends StatefulWidget{
  AllDelivery({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _AllDeliveryState createState() => _AllDeliveryState();
}
class _AllDeliveryState extends State<AllDelivery> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('My Past Deliveries', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontSize: 25), ),
        centerTitle: true,
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              itemCount: widget.volunteer.getVolunteerDeliveries().length,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Card(
                    shadowColor: Color(0xFFE0CB8F),
                    child: ListTile(
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NamesDates().whichWidg(widget.volunteer.getVolunteerDeliveries().length-index, "delivery", widget.volunteer)),);},
                      title: Text(widget.volunteer.getVolunteerDeliveries().elementAt(index).getName(), style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 21),),
                      subtitle: Text("Delivered on "+widget.volunteer.getVolunteerDeliveries().elementAt(index).getDate(), style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F)),),
                      tileColor: CustomTheme.getLight() ? Colors.white : Colors.black,
                      leading: Icon(
                        Icons.airport_shuttle_rounded,
                        color: Color(0xFFE0CB8F),
                        size: 32,
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
