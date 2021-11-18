import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class PendingPickup extends StatefulWidget {
  PendingPickup({Key? key, required this.pend, required this.index}) : super(key: key);
  final Pending pend;
  final int index;
  @override
  _PendingPickupState createState() => _PendingPickupState();
}
CollectionReference pickups = FirebaseFirestore.instance.collection("Pickup & Deliveries").doc("Data").collection("Pickups");
CollectionReference pend = FirebaseFirestore.instance.collection("Pickup & Deliveries").doc("Data").collection("Pending");
int count = 0;
bool wasAdded = false;
bool notAdded = true;

class _PendingPickupState extends State<PendingPickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('Pending Pickup', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(children: [
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
        organize(" Food name: ", widget.pend.one),
        organize(" Pickup on: ", widget.pend.two),
        organize(" Pickup by: ", widget.pend.user),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        ),
        MaterialButton(
          onPressed: addToFirebase,
          color: Color(0xFFE0CB8F),
          child: Text(
            'I have picked up this item.',
          ),
        )
      ],
      ),
    );
  }

  void addToFirebase() async{
      await pickups.add({'pickupBy':widget.pend.user, 'pickupOn':widget.pend.two, 'donationName':widget.pend.one});//pickups.doc(widget.pend.two).set
      //.add({'pickupBy':widget.pend.user, 'pickupOn':widget.pend.two, 'donationName':widget.pend.one}).then((value) => print("Pickup added"));
      await pend.doc(widget.pend.one+widget.pend.two+widget.pend.user).delete();
      //thePends.removeAt(thePends.length-widget.index);
      //Volunteer.allPendingPickups.removeAt(Volunteer.allPendingPickups.length-widget.index);
      count++;

  }

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
            " "+txt2, style: TextStyle(fontSize: 20, color: CustomTheme.getLight() ? Colors.grey : Color( //17
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

class AllPendingPickups extends StatefulWidget {
  AllPendingPickups({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;

  @override
  _AllPendingPickupsState createState() => _AllPendingPickupsState();
}

class _AllPendingPickupsState extends State<AllPendingPickups> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: CustomTheme.getLight() ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),
        title: const Text('My Pending Pickups', style: TextStyle(color: Colors.black, fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          AllPendingStream(volunteer: widget.volunteer,),
        ],
      ),
    );
  }
}

final _firestore = FirebaseFirestore.instance;
int counter = 0;

class AllPendingStream extends StatelessWidget {
  AllPendingStream({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Pickup & Deliveries')
          .doc('Data')
          .collection('Pending')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFE0CB8F),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE0CB8F)),
                  ),
                ],
              ),
            ),
          );
        }
        final orders = snapshot.data!.docs.reversed;
        List<AllPendingPickupList> orderList = [];
        counter = 0;
        for (var order in orders) {
          final name = order.get('donationName');
          final date = order.get('pickupOn');
          final user = order.get('pickupBy');


          if(user == volunteer.email)
          {
            counter++;
            Pending newObj = Pending(name, date, user);
            final orderIndividuals = AllPendingPickupList(
              index: counter,
              volunteer: volunteer,
              one: name,
              two: date,
            );
            orderList.add(orderIndividuals);
            thePends.add(newObj);
            Volunteer.allPendingPickups.add(newObj);
          }

          orderList.sort((b, a) => a.two.compareTo(b.two));
          //Volunteer.sortVolunteerPickups();
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: orderList,
          ),
        );
      },
    );
  }
}

class AllPendingPickupList extends StatelessWidget{
  AllPendingPickupList({
    required this.index,
    required this.volunteer,
    required this.one,
    required this.two,
  });

  final int index;
  final Volunteer volunteer;
  final String one;
  final String two;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        shadowColor: Color(0xFFE0CB8F),
        child: ListTile(
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PendingPickup(pend: thePends.elementAt(thePends.length-index), index: index,),));},//thePends.removeAt(thePends.length-index)
          title: Text(one, style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),),
          subtitle: Text(two, style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F)),),
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
}


