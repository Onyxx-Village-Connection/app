import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/client/resource.dart';

class ClientResourcesScreen extends StatelessWidget {
  const ClientResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Client Resources')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> resourcesSnapshot) {
          if (resourcesSnapshot.hasError) {
            return Text('Something went wrong');
          }
          if (resourcesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final resources = resourcesSnapshot.data!.docs;

          return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (ctx, index) {
                Map<String, dynamic> resourcesData =
                    resources[index].data()! as Map<String, dynamic>;
                return Resource(
                  resourcesData['title'],
                  resourcesData['description'],
                  resourcesData['url'],
                  resourcesData['imageUrl'],
                  key: ValueKey(resources[index].id),
                );
              });
        });
  }
}
