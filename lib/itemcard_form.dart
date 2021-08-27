import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ItemCardForm extends StatefulWidget{
  ItemCardForm({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ItemCardFormState createState() => _ItemCardFormState();
}

class _ItemCardFormState extends State<ItemCardForm>{

  TextStyle textStyle = TextStyle(fontSize: 18.0, color: Colors.white);

  OutlineInputBorder focusedField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(
      color: Colors.amberAccent,
    ),
  );

  OutlineInputBorder enabledField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(
      color: Colors.amber,
      width: 2.0,
    ),
  );

  Widget _buildItemCardFormWidgets(BuildContext context){

    final itemNameBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Item name',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter the name of your item';
        }
      },
    );

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: itemNameBox,
        ),

      ],
    );

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