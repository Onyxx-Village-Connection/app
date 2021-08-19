import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientWishlist extends StatefulWidget{
  ClientWishlist({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientWishlistState createState() => _ClientWishlistState();
}

class _ClientWishlistState extends State<ClientWishlist>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  bool _isSelected = false;

  Widget _buildClientWishlistWidgets(BuildContext context){

    final itemCardButton = GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Icon(
        Icons.star,
        color: _isSelected? Colors.amber: Colors.grey,
        size: 30.0,
      ),
    );

    final itemCard = Row(
      children: <Widget> [
        itemCardButton,
        TextFormField(
          style: textStyle,
          decoration: InputDecoration(
            hintText: 'Enter item name',

          ),
        ),
      ],
    );

    return ListView(
      children: <Widget>[
        itemCardButton,
      ],
    );

  }

  @override
  Widget build(BuildContext context){

    final clientResources = Container(
      color: _backgroundColor,
      child: _buildClientWishlistWidgets(context),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('My Wishlist'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
        backgroundColor: _backgroundColor,
      ),

      body: clientResources,
    );

  }
}
