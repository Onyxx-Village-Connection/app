import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/pickups/pickups.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
int counter = 0;

class AllPickup extends StatefulWidget{
  AllPickup({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _AllPickupState createState() => _AllPickupState();
}

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
      body: Column(
        children: [
          AllPickupsStream(volunteer: widget.volunteer,),
        ],
      ),
    );
  }
}

class AllPickupsStream extends StatelessWidget {
  AllPickupsStream({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Pickup & Deliveries')
          .doc('Data')
          .collection('Pickups')
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
        List<AllPickupList> orderList = [];
        for (var order in orders) {
          final name = order.get('donationName');
          final date = order.get('pickupOn');
          final user = order.get('pickupBy');

          Pickups newObj = Pickups(Food(name, "donerName", "address", 0, false, 0), date, volunteer);
          final orderIndividuals = AllPickupList(
            index: counter,
            volunteer: volunteer,
            one: name,
            two: date,
          );
          if(user == volunteer.email)
          {
            orderList.add(orderIndividuals);
            Volunteer.volunteerPickups.add(newObj);
          }
          /*else{
            Volunteer.allPendingPickups.add(Pending(name, date, user));
          }*/
          counter++;
          orderList.sort((b, a) => a.two.compareTo(b.two));
          Volunteer.sortVolunteerPickups();
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


class AllPickupList extends StatelessWidget {
  AllPickupList({
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
            MaterialPageRoute(builder: (context) => NamesDates().whichWidg(volunteer.getVolunteerPickups().length-index, "pick", volunteer)),);},
          title: Text(one, style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),),
          subtitle: Text("Picked up on "+two, style: TextStyle(color: CustomTheme.getLight() ? Colors.black : Color(0xFFE0CB8F)),),
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
