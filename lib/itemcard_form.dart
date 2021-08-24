import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ItemCardForm extends StatefulWidget{
  ItemCardForm({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ItemCardFormState createState() => _ItemCardFormState();
}

class _ItemCardFormState extends State<ItemCardForm>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  Widget _buildItemCardFormWidgets(BuildContext context){

    return ;

  }

  @override
  Widget build(BuildContext context){

    final itemCardForm = Container(
      color: _backgroundColor,
      child: _buildItemCardFormWidgets(context),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
        backgroundColor: _backgroundColor,
      ),

      body: itemCardForm,
    );

  }
}