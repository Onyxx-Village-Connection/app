import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientResources extends StatefulWidget{
  ClientResources({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientResourcesState createState() => _ClientResourcesState();
}

class _ClientResourcesState extends State<ClientResources>{

  TextStyle textStyle = TextStyle(fontSize: 18.0, color: Colors.white);

  Widget _buildClientResourcesWidgets(BuildContext context){

    return ListView(
      children: <Widget>[

      ],
    );

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


    final clientWishlist = Container(
      color: _backgroundColor,
      child: _buildClientResourcesWidgets(context),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Resources'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
        backgroundColor: _backgroundColor,
      ),

      body: clientWishlist,
      bottomSheet: Container(
        color: _backgroundColor,
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
        child: pageRoutingButtons,
      ),
    );

  }
}