import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_number/phone_number.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../widgets/auth/styleConstants.dart';
import '../../widgets/client/profile_item.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/validatorFns.dart';
import '../../widgets/auth/errSnackBar.dart';
import '../../landing.dart';
import '../../core/models/client_model.dart';
import '../../widgets/client/profile_image.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key? key}) : super(key: key);

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  bool _isEditing = false;
  final _form = GlobalKey<FormState>();
  String _imageUrl = '';
  File? _uploadedImg;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _timeWithOVCController = TextEditingController();

  late ClientModel currentUser;
  final authUser = FirebaseAuth.instance.currentUser;

  getClientData() {
    FirebaseFirestore.instance
        .collection("clients")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      currentUser = ClientModel.fromMap(value.data(), authUser!.uid);

      setState(() {
        _nameController.text = currentUser.name;
        _phoneController.text = currentUser.phone;
        _cityController.text = currentUser.city;
        _timeWithOVCController.text = currentUser.timeWithOVC;
        _imageUrl = currentUser.profileImage;
      });
    });
  }

  @override
  initState() {
    super.initState();
    getClientData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _nameController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _timeWithOVCController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    final isValid = _form.currentState!.validate();

    bool isPhoneValid =
        await PhoneNumberUtil().validate(_phoneController.text, 'US');
    if (!isPhoneValid) {
      ErrSnackBar.show(context, "Please enter a valid phone number");
      return;
    }
    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    String uploadedImgUrl = '';

    if (_uploadedImg != null) {
      // Save profile pic first and get the download Url to save in client collection
      firebase_storage.Reference profileStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profileImages')
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

      var uploadTask = profileStorageRef.putFile(_uploadedImg!);

      try {
        // Storage tasks function as a Delegating Future so we can await them.
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        uploadedImgUrl = await taskSnapshot.ref.getDownloadURL();
      } on FirebaseException catch (e) {
        // Error while uploading
        print('Error occurred while uploading: $e.code');
      }
    }
    // Update Client document in firebase

    CollectionReference clients =
        FirebaseFirestore.instance.collection('clients');

    await clients.doc(authUser!.uid).update({
      'name': _nameController.text,
      'phone': formattedPhone,
      'city': _cityController.text,
      'timeWithOVC': _timeWithOVCController.text,
      'profileImage': uploadedImgUrl,
    });

    setState(() {
      _isEditing = false;
    });
  }

  String? _phoneValidator(phoneVal) {
    if (phoneVal == null || phoneVal.isEmpty || phoneVal.length < 2) {
      return 'Please enter your phone number';
    }
    _phoneController.text = phoneVal;
    return null;
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    // take user back to landing page
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => OnyxxLanding()),
        (Route<dynamic> route) => false);
  }

  void _saveProfileImgUrl(value) {
    _uploadedImg = value;
  }

  Widget _buildProfilePageWidgets(BuildContext context) {
    return ListView(
      children: <Widget>[
        ProfileImage(_imageUrl, _saveProfileImgUrl, _isEditing),
        ProfileItem(
          'Name',
          _isEditing,
          nameValidator,
          _nameController,
        ),
        ProfileItem(
          'Phone',
          _isEditing,
          _phoneValidator,
          _phoneController,
        ),
        ProfileItem(
          'City',
          _isEditing,
          cityValidator,
          _cityController,
        ),
        ProfileItem(
          'Time with OVC',
          _isEditing,
          timeWithOVCValidator,
          _timeWithOVCController,
        ),
        _isEditing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: LoginSignupButton('Update', _updateProfile),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: LoginSignupButton('Cancel', () {
                      setState(() {
                        _isEditing = false;
                      });
                    }),
                  ),
                ],
              )
            : Container(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          child: LoginSignupButton('Logout', _logout),
        )
      ],
    );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final profilePage = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildProfilePageWidgets(context),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: widgetColor,
        ),
        backgroundColor: backgroundColor,
      ),
      body: profilePage,
    );
  }
}
