import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientResources extends StatefulWidget{
  ClientResources({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientResourcesState createState() => _ClientResourcesState();
}

class _ClientResourcesState extends State<ClientResources>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  Widget _buildClientResourcesWidgets(BuildContext context){

    //final itemCard = Row(
    //children: <Widget> [
    //starButton,
    //],
    //);

    return ListView(
      children: <Widget>[
      ],
    );

  }

  @override
  Widget build(BuildContext context){

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
    );

  }
}