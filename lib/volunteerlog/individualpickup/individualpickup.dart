import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/themes.dart';

class IndividualPickup extends StatefulWidget{

  IndividualPickup({Key? key, required this.num, required this.volunteer}) : super(key: key);
  final int num;
  final Volunteer volunteer;
  @override
  _IndividualPickupState createState() => _IndividualPickupState();
}

Widget organize(String txt, String txt2){
  return Column(
    children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 0.0),
          ),
          Container(
            child: Text(txt, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, fontFamily: "BarlowSemiCondensed" ),),//19
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 17.0, 0.0, 15.0),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
          ),
          Icon(Icons.star, color: Color(0xFFE0CB8F), size: 15,),
          Text(
            " " + txt2, style: TextStyle(fontSize: 20, color: CustomTheme.getLight() ? Colors.grey : Color( //17
              0xFFEAD8A3),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 17.0, 0.0, 20.0),
          ),
        ],
      )
    ],
  );
}

class _IndividualPickupState extends State<IndividualPickup> {
  String trueOrFalse(){
    String returning = "No";
    if(widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getRequirements()){
      returning = "Yes";
    }
    return returning;
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('Pickup Item', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          ),
          Image(
            image: AssetImage('images/placeholder.jpg'),
            height: 100,
            width: 1000,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          ),
          organize(" Food name: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getName()),
          organize(" Picked up on: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getDate()),
          organize(" Doner name: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getDonerName()),
          organize(" Pickup address: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getAddress()),
          organize(" # of boxes: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getNumOfBoxes().toString()),
          organize(' # of meals: ', widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getNumOfMeals().toString()),
          organize(' Dimensions: ', widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getDimensions().toString()),
          organize(' Contains allergens: ', widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getAllergens().toString()),
          organize(" Weight of donation: ", widget.volunteer.getVolunteerPickups().elementAt(widget.volunteer.getVolunteerPickups().length-widget.num).getItem().getWeight().toString() + " lbs"),
          organize(" Requires Refrigeration: ", trueOrFalse()),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          ),
        ],
        ),
      ),
    );
  }
}
