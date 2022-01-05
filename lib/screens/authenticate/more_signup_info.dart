import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:phone_number/phone_number.dart';

import '../../screens/client/client_home_tabs.dart';
import '../../widgets/auth/inputBox.dart';
import '../../widgets/auth/styleConstants.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/errSnackBar.dart';
import '../../widgets/auth/validatorFns.dart';
import '../../widgets/client/profile_image.dart';

class MoreSignupInfo extends StatefulWidget {
  MoreSignupInfo(
      {Key? key,
      required this.title,
      required this.email,
      required this.password})
      : super(key: key);

  final String title, email, password;
  @override
  _MoreSignupInfoState createState() => _MoreSignupInfoState();
}

class _MoreSignupInfoState extends State<MoreSignupInfo> {
  File? _profileImgFile;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _timeWithOVCController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _timeWithOVCFocusNode = FocusNode();

  final _auth = FirebaseAuth.instance;

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

  Widget _buildMoreSignupInfoWidgets(BuildContext context) {
    String? _phoneValidator(phoneVal) {
      if (phoneVal == null || phoneVal.isEmpty || phoneVal.length < 2) {
        return 'Please enter your phone number';
      }

      _phoneController.text = phoneVal;
      return null;
    }

    void _saveProfileImgUrl(value) {
      _profileImgFile = value;
    }

    void _saveForm() async {
      final isValid = _form.currentState!.validate();

      bool isPhoneValid =
          await PhoneNumberUtil().validate(_phoneController.text, 'US');
      if (!isPhoneValid) {
        ErrSnackBar.show(context, "Please enter a valid phone number");
        return;
      }

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      await _auth.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);

      _clientSetup();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ClientHomeTabBarScreen()));
    }

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'We need more information from you...',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: ProfileImage('', _saveProfileImgUrl, false),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          child: InputBox(
            'Your Name',
            _nameFocusNode,
            _timeWithOVCFocusNode,
            nameValidator,
            _nameController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: InputBox(
            'How long have you been with OVC?',
            _timeWithOVCFocusNode,
            _cityFocusNode,
            timeWithOVCValidator,
            _timeWithOVCController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: InputBox(
            'Your City',
            _cityFocusNode,
            _phoneFocusNode,
            cityValidator,
            _cityController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: InputBox(
            'Your Phone Number',
            _phoneFocusNode,
            null,
            _phoneValidator,
            _phoneController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(130.0, 20.0, 130.0, 15.0),
          child: LoginSignupButton('Sign Up', _saveForm),
        ),
      ],
    );
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            basename(_profileImgFile!.path))
        .putFile(_profileImgFile!);

    return taskSnapshot.ref.getDownloadURL();
  }

  Future<void> _clientSetup() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    String imgUrl = _profileImgFile != null ? await uploadImage() : '';
    FirebaseFirestore.instance
        .collection('clients')
        .doc(auth.currentUser!.uid)
        .set({
      'name': _nameController.text,
      'phone': formattedPhone,
      'city': _cityController.text,
      'profileImage': imgUrl,
      'timeWithOVC': _timeWithOVCController.text,
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    final moreSignupInfoForm = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildMoreSignupInfoWidgets(context),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: widgetColor,
        ),
        backgroundColor: backgroundColor,
      ),
      body: moreSignupInfoForm,
    );
  }
}
