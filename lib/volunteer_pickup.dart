import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/profile_page.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class TabBuilder extends StatefulWidget {
  @override
  _TabBuilderState createState() => _TabBuilderState();
}

class _TabBuilderState extends State<TabBuilder> {
  int i = 0;
  List<Widget> _widgetOptions = <Widget>[
    Pickups(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_rounded),
            label: 'Available Pickups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: i,
        selectedItemColor: kSecondaryColor,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: SafeArea(child: _widgetOptions.elementAt(i)),
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
        title: Text('Pickups'),
      ),
      body: Column(
        children: [
          PickupsStream(),
        ],
      ),
    );
  }
}

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

          final orderIndividuals = PickupList(
            one: name,
            two: date,
          );
          orderList.add(orderIndividuals);
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
              Text(
                'Pickup Date & Time: ' + two,
                style: TextStyle(
                  fontSize: 20.0,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
