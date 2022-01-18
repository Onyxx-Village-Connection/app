import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/volunteerlog/deliveries/deliveries.dart';
import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/individualdelivery/individualdelivery.dart';
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
    await pend.doc("Data").collection("Pickups").add({'donationName':obj.one, 'pickupBy':volunteer.email, 'pickupOn':obj.two}).then((value) => print("Pend added"));

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
      backgroundColor: Colors.white,
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
      body: Column(
        children: [
          DeliveriesStream(),
        ],
      ),
    );
  }
}
int counting = 0;
class DeliveriesStream extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Volunteer')
          .doc('Data')
          .collection('Delivery Data')
          //.collection('donations')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFE0CB8F),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),//(kSecondaryColor),
                  ),
                ],
              ),
            ),
          );
        }
        final orders = snapshot.data!.docs.reversed;
        List<DeliveryList> orderList = [];
        for (var order in orders) {
          final name = order.get('donationName');
          final date = order.get('pickupDate').toString();
          final user = '';//order.get('deliveryBy')
          final address = '';//order.get('address')
          final fridge = order.get('reqFrige');
          final numOfBoxes = order.get('numOfBoxes');
          final weight = (order.get('weight').toInt());
          final width = order.get('width');
          final height = order.get('height');
          final depth = order.get('depth');
          final isGrocery = order.get('isGrocery');
          final meals = order.get('numMeals');
          final hasDairy = order.get('hasDairy');
          final hasNuts = order.get('hasNuts');
          final hasEggs = order.get('hasEggs');

          final orderIndividuals = DeliveryList(
            num: counting,
            one: name,
            two: date,
            three: address,
            four: fridge,
            five: numOfBoxes,
            six: weight,
            meals: meals,
            width: width.toDouble(),
            height: height.toDouble(),
            depth: depth.toDouble(),
            isGrocery: isGrocery,
            hasNuts: hasNuts,
            hasEggs: hasEggs,
            hasDairy: hasDairy,
          );
          if(user == "" || user == null)
          {
            orderList.add(orderIndividuals);
          }
          counting++;
          orderList.sort((a, b) => a.two.compareTo(b.two));
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

class DeliveryList extends StatelessWidget{
  DeliveryList({
    required this.num,
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.six,
    required this.width,
    required this.height,
    required this.depth,
    required this.meals,
    required this.hasDairy,
    required this.hasEggs,
    required this.hasNuts,
    required this.isGrocery,
  });
  final int num;
  final String one;
  final String two;
  final String three;
  final bool four;
  final int five;
  final int six;
  final double width;
  final double height;
  final double depth;
  final int meals;
  final bool hasDairy;
  final bool hasEggs;
  final bool hasNuts;
  final bool isGrocery;

  static CollectionReference pend = FirebaseFirestore.instance.collection("Pickup & Deliveries");
  static CollectionReference pickups = FirebaseFirestore.instance.collection("Volunteer");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0CB8F),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(23.0),
                  bottomRight: Radius.circular(23.0),
                  topLeft: Radius.circular(23.0),
                  bottomLeft: Radius.circular(23.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 30.0, 4.0),
              child: TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryInfo(num: num, name: one, date: two, address: three, boxes: five, weight: six, refrigeration: four, width: width.toInt(), height: height.toInt(), hasDairy: hasDairy, hasEggs: hasEggs, hasNuts: hasNuts, meals: meals, isGrocery: isGrocery, depth: depth.toInt(),)),);},
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            one,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "BarlowSemiCondensed",
                              fontSize: 23.0,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Delivery Date & Time: ',
                            style: TextStyle(
                                fontFamily: "BarlowSemiCondensed",
                                fontSize: 20.0,
                                color: Colors.black45
                            ),
                          ),
                          Text(
                            two.substring(0, 10),
                            style: TextStyle(
                              fontFamily: "BarlowSemiCondensed",
                              fontSize: 20.0,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ),
          ),
          IconButton(
            iconSize: 28.0,
              color: Color(0xFFE0CB8F),
              onPressed: () {
            addToPending(
                Volunteer.matchingCredentials(
                    FirebaseAuth.instance.currentUser!.email.toString()), this, context);},
              icon: Icon(OVCIcons.addicon)),
        ],
      ),
    );
  }

  addToPending(Volunteer volunteer, DeliveryList obj, BuildContext context) async {
    await pend.doc("Data").collection("Deliveries").add({'donationName':obj.one, 'deliveredBy':volunteer.email, 'deliveredOn':obj.two, 'address':obj.three, 'requiresRefrigeration':obj.four, 'numOfBoxes':obj.five, 'weight':obj.six, 'width':obj.width, 'height':obj.height, 'depth':obj.depth, 'numMeals':meals, 'hasDairy':hasDairy, 'hasNuts':hasNuts, 'hasEggs':hasEggs, 'isGrocery':isGrocery}).then((value) => print("Delivery added"));
    await pickups.doc("Data").collection("Delivery Data").doc(obj.one + " " + obj.two).delete();
    // do something here to make firebase rmr that pickup obj is taken
    Deliveries obj1 = Deliveries(Food(obj.one, volunteer.email, "address", 0, false, 0, obj.meals, obj.hasDairy, obj.hasNuts, obj.hasEggs, obj.isGrocery, obj.width.toInt(), obj.height.toInt(), obj.depth.toInt()), obj.two, volunteer, context);
  }
}
