import 'package:flutter/material.dart';

class ClientDeliveriesScreen extends StatelessWidget {
  const ClientDeliveriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('We deliver Monday thru Friday from 2-6pm',
          style: TextStyle(fontSize: 16)),
    );
  }
}
