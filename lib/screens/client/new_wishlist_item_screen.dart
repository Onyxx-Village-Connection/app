import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewWishlistItemScreen extends StatefulWidget {
  const NewWishlistItemScreen({Key? key}) : super(key: key);

  @override
  State<NewWishlistItemScreen> createState() => _NewWishlistItemScreenState();
}

class _NewWishlistItemScreenState extends State<NewWishlistItemScreen> {
  final _form = GlobalKey<FormState>();
  final _qtyFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  var _initValues = {
    'title': '',
    'description': '',
    'qty': '',
  };

  var _savedValues;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _savedValues = _initValues;
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // add wishlist to firestore
    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('clientWishlists').add({
      'title': _savedValues['title'],
      'description': _savedValues['description'],
      'desiredQuantity': int.tryParse(_savedValues['qty']),
      'userId': user!.uid,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New wishlist Item'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Item Name'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the item you would like.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _savedValues['title'] = value;
                  }),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_qtyFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _savedValues['description'] = value;
                },
              ),
              TextFormField(
                initialValue: _initValues['desiredQuantity'],
                decoration: InputDecoration(labelText: 'Desired Quantity'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _qtyFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the desired quantity.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _savedValues['qty'] = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
