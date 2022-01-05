import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/client/wishlist_item.dart';

class ClientWishlistScreen extends StatelessWidget {
  const ClientWishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Client Wishlists')
            .where('userId', isEqualTo: user!.uid)
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

          return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (ctx, index) {
                Map<String, dynamic> resourcesData =
                    resources[index].data()! as Map<String, dynamic>;
                return WishlistItem(
                  resourcesData['title'],
                  resourcesData['description'],
                  resourcesData['desiredQuantity'],
                  key: ValueKey(resources[index].id),
                );
              });
        });
  }
}
