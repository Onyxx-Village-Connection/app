import 'package:flutter/material.dart';
import 'package:ovcapp/itemcard_form.dart';

final _backgroundColor = Colors.black87;

class ClientWishlist extends StatefulWidget{
  ClientWishlist({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientWishlistState createState() => _ClientWishlistState();
}

class _ClientWishlistState extends State<ClientWishlist>{

  TextStyle textStyle = TextStyle(fontSize: 18.0, color: Colors.white);

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

    final itemCard = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              itemCardButton,
              Text(
                'Item name',
                style: textStyle.copyWith(color: Colors.amber),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
    );

    return ListView(
      children: <Widget>[
        itemCard,
      ],
    );

  }

  void _navigateToItemCardForm(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context){
        return ItemCardForm(title: 'ItemCardForm');
      },
    ));
  }

  @override
  Widget build(BuildContext context){

    final pageRoutingButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.amber,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'Deliveries',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            onPressed: (){},
          ),
        ),
        Container(
          color: Colors.amber,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'Wishlist',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            onPressed: (){},
          ),
        ),
        Container(
          color: Colors.amber,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'Resources',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            onPressed: (){},
          ),
        ),
      ],
    );

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
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => _navigateToItemCardForm(context),
                child: Icon(
                  Icons.add,
                  size: 26.0,
                  color: Colors.amber,
                ),
              )
          ),
        ],
      ),

      body: clientResources,
      bottomSheet:  Container(
        color: _backgroundColor,
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
        child: pageRoutingButtons,
      ),
    );

  }
}
