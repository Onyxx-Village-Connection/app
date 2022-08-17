import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  Stream<QuerySnapshot> donations() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp lastWeek = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 200)),
    );

    return FirebaseFirestore.instance
        .collection('donations')
        .where("createdAt", isLessThan: now, isGreaterThan: lastWeek)
        .snapshots();
  }

  Stream<QuerySnapshot> pickups() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp lastWeek = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 200)),
    );

    return FirebaseFirestore.instance
        .collection('volunteerLogEntries')
        .where("activity", isEqualTo: "pickup")
        .where("createdAt", isLessThan: now, isGreaterThan: lastWeek)
        .snapshots();
  }

  Stream<QuerySnapshot> deliveries() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp lastWeek = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 200)),
    );

    return FirebaseFirestore.instance
        .collection('volunteerLogEntries')
        .where("activity", isEqualTo: "delivery")
        .where("createdAt", isLessThan: now, isGreaterThan: lastWeek)
        .snapshots();
  }

  Stream<QuerySnapshot> volunteers() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp lastWeek = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 200)),
    );

    return FirebaseFirestore.instance
        .collection('volunteers')
        .where("createdAt", isLessThan: now, isGreaterThan: lastWeek)
        .snapshots();
  }

  Stream<QuerySnapshot> clients() {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp lastWeek = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 200)),
    );

    return FirebaseFirestore.instance
        .collection('clients')
        .where("createdAt", isLessThan: now, isGreaterThan: lastWeek)
        .snapshots();
  }

  Widget showCount(String label, Icon icon, Stream<QuerySnapshot> streamCount) {
    return StreamBuilder<QuerySnapshot>(
        stream: streamCount,
        builder: (ctx, AsyncSnapshot<QuerySnapshot> resourcesSnapshot) {
          if (resourcesSnapshot.hasError) {
            return Text('Something went wrong:');
          }
          if (resourcesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final resources = resourcesSnapshot.data!.docs;

          return Center(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('$label this week: ${resources.length}'),
                          leading: icon,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          showCount('New Volunteers', Icon(Icons.person), volunteers()),
          showCount('New Clients', Icon(Icons.person_add), clients()),
          showCount('Donations', Icon(Icons.food_bank), donations()),
          showCount('Pickups', Icon(Icons.airport_shuttle), pickups()),
          showCount('Deliveries', Icon(Icons.airport_shuttle), deliveries()),
        ],
      ),
    );
  }
}
