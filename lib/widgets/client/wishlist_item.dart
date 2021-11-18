import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  final String title;
  final String description;
  final int desiredQuantity;
  final Key key;

  WishlistItem(this.title, this.description, this.desiredQuantity,
      {required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFFE0CB8F),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(description),
          trailing: Text('Quantity requested: $desiredQuantity'),
        ),
      ),
    );
  }
}
