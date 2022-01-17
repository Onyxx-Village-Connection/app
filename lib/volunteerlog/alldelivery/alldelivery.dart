import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ovcapp/volunteerlog/deliveries/deliveries.dart';
import 'package:ovcapp/volunteerlog/food/food.dart';
import 'package:ovcapp/volunteerlog/individualdelivery/individualdelivery.dart';
import 'package:ovcapp/volunteerlog/loghours/loghours.dart';
import 'package:ovcapp/volunteerlog/volunteerlog.dart';
import 'package:ovcapp/themes.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ovcapp/assets/ovcicons.dart';

final _firestore = FirebaseFirestore.instance;
int counter = 0;

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

      body:
      Column(
        children: [
          AllDeliveriesStream(volunteer: widget.volunteer,)
        ],
      )
    );
  }
}
int counter111=0;
class AllDeliveriesStream extends StatelessWidget{
  AllDeliveriesStream({Key? key, required this.volunteer}) : super(key: key);
  final Volunteer volunteer;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Pickup & Deliveries')
          .doc('Data')
          .collection('Deliveries')
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
        counter111 = 0;
        final orders = snapshot.data!.docs.reversed;
        List<AllDeliveriesList> orderList = [];

        for (var order in orders) {
          final name = order.get('donationName');
          final date = order.get('deliveredOn');
          final user = order.get('deliveredBy');
          final address = '';//order.get('address')
          final fridge = order.get('requiresRefrigeration');
          final numOfBoxes = order.get('numOfBoxes');
          final weight = order.get('weight');
          final width = order.get('width');
          final height = order.get('height');
          final depth = order.get('depth');
          final isGrocery = order.get('isGrocery');
          final meals = order.get('numMeals');
          final hasDairy = order.get('hasDairy');
          final hasNuts = order.get('hasNuts');
          final hasEggs = order.get('hasEggs');

          Deliveries newObj = Deliveries(Food(name, user, address, weight, fridge, numOfBoxes, meals, hasDairy, hasNuts, hasEggs, isGrocery, width.toInt(), height.toInt(), depth.toInt()), date, volunteer, context);
          final orderIndividuals = AllDeliveriesList(
            index: counter111,
            volunteer: volunteer,
            one: name,
            two: date,
            three: address,
            four: fridge,
            five: numOfBoxes,
            six: weight,
            meals: meals,
            hasDairy: hasDairy,
            hasNuts: hasNuts,
            hasEggs: hasEggs,
            isGrocery: isGrocery,
            depth: depth.toInt(),
            height: height.toInt(),
            width: width.toInt(),
          );
          if(user == volunteer.email)//&& isn't the same obj
          {
            orderList.add(orderIndividuals);
            volunteer.addDelivery(newObj);
            counter111++;
          }
          orderList.sort((b, a) => a.two.compareTo(b.two));
          Volunteer.sortVolunteerDeliveries();
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

class AllDeliveriesList extends StatelessWidget{
  AllDeliveriesList({
    required this.index,
    required this.volunteer,
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.six,
    required this.meals,
    required this.hasDairy,
    required this.hasNuts,
    required this.hasEggs,
    required this.isGrocery,
    required this.depth,
    required this.height,
    required this.width
  });

  final int index;
  final Volunteer volunteer;
  final String one;
  final String two;
  final String three;
  final bool four;
  final int five;
  final int six;
  final int meals;
  final bool hasDairy;
  final bool hasNuts;
  final bool hasEggs;
  final bool isGrocery;
  final int depth;
  final int height;
  final int width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        shadowColor: Color(0xFFE0CB8F),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeliveryInfo(num: index, name: one, date: two, address: three, boxes: five, meals: meals, width: width, height: height, hasDairy: hasDairy, hasEggs: hasEggs, hasNuts: hasNuts, isGrocery: isGrocery, depth: depth, weight: six, refrigeration: four),
                  //NamesDates().whichWidg(volunteer.getVolunteerDeliveries().length-index, "delivery", volunteer)),
                  ));//
          },
          title: Text(one,
            style: TextStyle(fontSize: 21, fontFamily: "BarlowSemiCondensed"),),
          subtitle: Text("Delivered on " + two.substring(0, 10), style: TextStyle(
              color: CustomTheme.getLight() ? Colors.black : Color(
                  0xFFE0CB8F)),),
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
