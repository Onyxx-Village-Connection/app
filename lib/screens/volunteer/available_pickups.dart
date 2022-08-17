import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/models/donor_model.dart';
import 'pickup_item.dart';
import '../../widgets/auth/styleConstants.dart';
import '../donors/donation.dart';

class AvailablePickupsScreen extends StatelessWidget {
  const AvailablePickupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('pickupVolunteerId', isNull: true)
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
          if (resourcesSnapshot.hasData) {
            final resources = resourcesSnapshot.data!.docs;
            if (resources.length == 0) {
              return ListTile(
                title: Center(
                  child: Text(
                    'No donations yet',
                    style: TextStyle(
                      fontFamily: 'BigShouldersDisplay',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: widgetColor,
                    ),
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (ctx, index) {
                Map<String, dynamic> resourcesData =
                    resources[index].data()! as Map<String, dynamic>;

                Donation donation = Donation.fromJson(resourcesData);

                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("donors")
                        .doc(donation.donorId)
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        DonorModel donor = DonorModel.fromMap(
                            snapshot.data!, donation.donorId);

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.fastfood,
                              color: Colors.purple,
                            ),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PickupItem(
                                        donation: donation, donor: donor)),
                              );
                            },
                            title: Text(
                              donation.name,
                              style:
                                  TextStyle(fontSize: 24, color: widgetColor),
                            ),
                            subtitle: Text(donor.pickupCity),
                          ),
                        );
                      }
                    });
              },
            );
          } else {
            return ListTile(
              title: Text('No donations yet'),
            );
          }
        });
  }
}
