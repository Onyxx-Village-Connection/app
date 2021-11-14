import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/volunteerlog/pickups/pickups.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';

class AllPickup extends StatefulWidget{
  AllPickup({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _AllPickupState createState() => _AllPickupState();
}
final String allPickups = Pickups.printList();
class _AllPickupState extends State<AllPickup> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('My Past Pickups', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.volunteer.getVolunteerPickups().length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Card(
                    shadowColor: Color(0xFFE0CB8F),
                    child: ListTile(
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NamesDates().whichWidg(widget.volunteer.getVolunteerPickups().length-index, "pick", widget.volunteer)),);},
                      title: Text(widget.volunteer.getVolunteerPickups().elementAt(index).getName(), style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),),
                      subtitle: Text("Picked up on "+widget.volunteer.getVolunteerPickups().elementAt(index).getDate(), style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F)),),
                      tileColor: CustomTheme.getLight() ? Colors.white : Colors.black,
                      leading: Icon(
                        OVCIcons.pickupicon,
                        color: Color(0xFFE0CB8F),
                        size: 33,
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
