import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/profile_page.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ovcapp/assets/ovcicons.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class TabBuilder extends StatefulWidget {
  const TabBuilder({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  @override
  _TabBuilderState createState() => _TabBuilderState();
}

class _TabBuilderState extends State<TabBuilder> {
  int i = 0;
  

  void _onItemTapped(int index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[ //moved here to access widget
       Pickups(),
       Delivery(),
       VolunteerLog(volunteer: widget.volunteer,), 
    ];
    return MaterialApp(
      theme: CustomTheme.getLight() ? CustomTheme.getLightTheme() : CustomTheme.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
      backgroundColor: Color(0xFFE0CB8F),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFE0CB8F),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_rounded),
            label: 'Available Pickups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airport_shuttle_rounded),
            label: 'Deliveries',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'My Log',
          ),
        ],
        currentIndex: i,
        selectedItemColor: kSecondaryColor,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: SafeArea(child: _widgetOptions.elementAt(i)),
      ),
      ),          
      ),
    );     
  }
}

class Pickups extends StatefulWidget {
  @override
  _PickupsState createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          backgroundColor: Color(0xFFE0CB8F),
         leading: GestureDetector(
          onTap: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );},//profile should be here
          child: Icon(
            OVCIcons.profileicon, size: 30.0,
          ),
        ), 
        title: Text('Onyxx Village Connection', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,  
      ),
      body: Column(
        children: [
          PickupsStream(),
        ],
      ),
    );
  }
}
int counter = 0;
class PickupsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Volunteer')
          .doc('Data')
          .collection('Pickup Data')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: kPrimaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                  ),
                ],
              ),
            ),
          );
        }
        final orders = snapshot.data!.docs.reversed;
        List<PickupList> orderList = [];
        for (var order in orders) {
          final name = order.get('name');
          final date = order.get('date');
          final user = order.get('pickupBy');  

          final orderIndividuals = PickupList(
            one: name,
            two: date,
          );
          if(user == "" || user == null)
            {
              orderList.add(orderIndividuals);
            }
          if((user != "" || user != null) && counter == 0)
          {
            Volunteer.allPendingPickups.add(Pending(name, date, user));
          }
            counter++;
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

class PickupList extends StatelessWidget {
  PickupList({
    required this.one,
    required this.two,
  });

  final String one;
  final String two;

  static CollectionReference pend = FirebaseFirestore.instance.collection("Pickup & Deliveries");
  static CollectionReference pickups = FirebaseFirestore.instance.collection("Volunteer");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        color: kSecondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ' + one,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  color: kPrimaryColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Pickup Date & Time: ' + two,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: kPrimaryColor,
                    ),
                  ),
                  IconButton(onPressed: () {addToPending(Volunteer.matchingCredentials(FirebaseAuth.instance.currentUser!.email.toString()), this);}, icon: Icon(OVCIcons.addicon))
                ],
              ),

            ],//
          ),
        ),
      ),
    );
  }

  addToPending(Volunteer volunteer, PickupList obj) async {
    //await pickups.add({'pickupBy':volunteer.email, 'pickupOn':obj.two, 'donationName':obj.one});
    //await pend.doc("Data").collection("Pending").doc(obj.one+obj.two+volunteer.email).set({'donationName':obj.one, 'pickupBy':volunteer.email, 'pickupOn':obj.two}).then((value) => print("Pend added"));//pend.doc(FirebaseAuth.instance.currentUser!.email).set({'user':widget.volunteer.getName(), 'hoursEntered':_starter, 'totalHours':_total + _starter, 'editedHours':0}).then((value) => print("Hours added"));

    await pend.doc("Data").collection("Pickups").add({'donationName':obj.one, 'pickupBy':volunteer.email, 'pickupOn':obj.two}).then((value) => print("Pend added"));
    //await pickups.doc("Data").collection("Pickup Data").doc(obj.one).set({'name':obj.one, 'date':obj.two, 'pickupBy':volunteer.email});

    // do something here to make firebase rmr that pickup obj is taken
    Pending obj1 = Pending(obj.one, obj.two, volunteer.email);
    Volunteer.allPendingPickups.add(obj1);
  }
}

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE0CB8F),  
        leading: GestureDetector(
          onTap: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );},
          child: Icon(
            OVCIcons.profileicon, size: 30.0, // add custom icons also
          ),
        ),
        title: Text('Onyxx Village Connection', style: TextStyle(fontFamily: "BigShouldersDisplay", fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Text('Deliveries'))
      ),
    );
  }
}
