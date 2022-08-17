import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VolunteerLogScreen extends StatelessWidget {
  var volunteerActivityIcons = {
    'pickup': Icons.airport_shuttle,
    'delivery': Icons.delivery_dining,
    'foodPrep': Icons.dinner_dining,
  };

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('volunteerLogEntries')
            .where('volunteerId', isEqualTo: user!.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> resourcesSnapshot) {
          if (resourcesSnapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (resourcesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final resources = resourcesSnapshot.data!.docs;

          return ListView(
            children: [
              DataTable(
                  columns: _createColumns(), rows: _createRows(resources)),
            ],
          );
        });
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('# Hours')),
      DataColumn(label: Text('Activity')),
    ];
  }

  List<DataRow> _createRows(List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _showLogEntry(data)).toList();
  }

  DataRow _showLogEntry(DocumentSnapshot data) {
    final date = data['createdAt'].toDate();
    final numHours = data['numHours'];
    final activity = data['activity'];

    DateFormat dateFormat = DateFormat.yMEd();
    String volunteerDate = dateFormat.format(date);

    return DataRow(cells: [
      DataCell(Text(volunteerDate)),
      DataCell(Text(numHours.toString())),
      DataCell(Icon(volunteerActivityIcons[activity])),
    ]);
  }
}
