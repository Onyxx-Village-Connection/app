import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';

import '../../widgets/auth/inputBox.dart';
import '../../widgets/auth/styleConstants.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/helperFns.dart';
import '../../widgets/auth/errSnackBar.dart';
import '../../landing.dart';
import '../../core/models/donor_model.dart';
import '../../core/models/client_model.dart';
import '../../core/models/volunteer_model.dart';
import '../../widgets/auth/profile_image.dart';
import '../../../core/providers/authentication.dart';

class UserProfileInfo extends StatefulWidget {
  String? password, email;
  String role;

  UserProfileInfo({
    Key? key,
    this.email,
    this.password,
    required this.role,
  }) : super(key: key);

  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  bool _isEditing = false;
  final _form = GlobalKey<FormState>();
  String? _imageUrl;
  String? _uploadedImgUrl;
  File? _uploadedImgFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _timeWithOVCController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _timeWithOVCFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  late DonorModel _currentDonor;
  late ClientModel _currentClient;
  late VolunteerModel _currentVolunteer;

  final authUser = FirebaseAuth.instance.currentUser;

  void _getVolunteerData() {
    FirebaseFirestore.instance
        .collection("volunteers")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentVolunteer = VolunteerModel.fromMap(value.data(), authUser!.uid);

      setState(() {
        _nameController.text = _currentVolunteer.name;
        _phoneController.text = _currentVolunteer.phone;
        _imageUrl = _currentVolunteer.profileImage;
      });
    });
  }

  void _getClientData() {
    FirebaseFirestore.instance
        .collection("clients")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentClient = ClientModel.fromMap(value.data(), authUser!.uid);

      setState(() {
        _nameController.text = _currentClient.name;
        _phoneController.text = _currentClient.phone;
        _cityController.text = _currentClient.city;
        _timeWithOVCController.text = _currentClient.timeWithOVC;
        _imageUrl = _currentClient.profileImage;
      });
    });
  }

  void _getDonorData() {
    FirebaseFirestore.instance
        .collection("donors")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentDonor = DonorModel.fromMap(value.data(), authUser!.uid);

      setState(() {
        _nameController.text = _currentDonor.name;
        _phoneController.text = _currentDonor.phone;
        _cityController.text = _currentDonor.city;
        _addressController.text = _currentDonor.address;
        _zipController.text = _currentDonor.zip;
        _imageUrl = _currentDonor.profileImage;
      });
    });
  }

  bool _isNewSignup() {
    return authUser == null;
  }

  @override
  initState() {
    super.initState();
    if (!_isNewSignup()) {
      switch (this.widget.role) {
        case 'Donor':
          _getDonorData();
          break;

        case 'Client':
          _getClientData();
          break;

        case 'Volunteer':
          _getVolunteerData();
          break;
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _nameController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _timeWithOVCController.dispose();
    _zipController.dispose();

    super.dispose();
  }

  Future<void> _setUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var userData = {
      'name': _nameController.text,
      'phone': formattedPhone,
      'profileImage': _uploadedImgUrl,
      'role': [widget.role],
    };

    if (authUser == null) {
      users.doc(auth.currentUser!.uid).set(userData);
    } else {
      await users.doc(authUser!.uid).update(userData);
    }
    return;
  }

  Future<void> _setDonorInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference donors =
        FirebaseFirestore.instance.collection('donors');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var donorData = {
      'name': _nameController.text,
      'phone': formattedPhone,
      'city': _cityController.text,
      'address': _addressController.text,
      'zip': _zipController.text,
      'profileImage': _uploadedImgUrl,
    };

    if (authUser == null) {
      donors.doc(auth.currentUser!.uid).set(donorData);
    } else {
      await donors.doc(authUser!.uid).update(donorData);
    }
    return;
  }

  Future<void> _setClientInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference clients =
        FirebaseFirestore.instance.collection('clients');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var clientData = {
      'name': _nameController.text,
      'phone': formattedPhone,
      'city': _cityController.text,
      'timeWithOVC': _timeWithOVCController.text,
      'profileImage': _uploadedImgUrl,
    };

    if (authUser == null) {
      clients.doc(auth.currentUser!.uid).set(clientData);
    } else {
      await clients.doc(authUser!.uid).update(clientData);
    }
    return;
  }

  Future<void> _setVolunteerInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference volunteers =
        FirebaseFirestore.instance.collection('volunteers');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var volunteerData = {
      'name': _nameController.text,
      'phone': formattedPhone,
      'profileImage': _uploadedImgUrl,
    };

    if (authUser == null) {
      volunteers.doc(auth.currentUser!.uid).set(volunteerData);
    } else {
      await volunteers.doc(authUser!.uid).update(volunteerData);
    }
    return;
  }

  void _updateUserInfo() async {
    if (_uploadedImgFile != null) {
      _uploadedImgUrl = await uploadProfileImage(_uploadedImgFile!);
    }

    _setUserInfo();

    switch (this.widget.role) {
      case 'Donor':
        _setDonorInfo();
        break;

      case 'Client':
        _setClientInfo();
        break;

      case 'Volunteer':
        _setVolunteerInfo();
        break;
    }
  }

  void _signupUser() async {
    AuthenticationState _authState =
        Provider.of<AuthenticationState>(context, listen: false);

    try {
      if (await _authState.signUpUser(widget.email!, widget.password!)) {
        _updateUserInfo();
        pushRoleBasedLandingPage(context, widget.role);
      }
    } catch (error) {
      ErrSnackBar.show(context, error as String);
    }
  }

  void _updateUser() async {
    _updateUserInfo();
    setState(() {
      _isEditing = false;
    });
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

    if (_isNewSignup()) {
      _signupUser();
    } else {
      _updateUser();
    }
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
    _uploadedImgFile = value;
  }

  Widget _showButtons() {
    if (_isNewSignup()) {
      return Padding(
        padding: EdgeInsets.fromLTRB(130.0, 20.0, 130.0, 15.0),
        child: LoginSignupButton('Sign Up', _saveForm),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: LoginSignupButton('Logout', _logout),
      );
    }
  }

  Widget _buildProfileInfoWidgets(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            _isNewSignup()
                ? 'We need more information from you...'
                : 'Edit Profile',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ProfileImage(
              _imageUrl, _saveProfileImgUrl, _isNewSignup() || _isEditing),
        ),
        InputBox(
          hintText: 'Your Name',
          focusNode: _nameFocusNode,
          nextFocusNode: _phoneFocusNode,
          validatorFn: nameValidator,
          controller: _nameController,
          enabled: _isNewSignup() || _isEditing,
        ),
        InputBox(
          hintText: 'Your Phone Number',
          focusNode: _phoneFocusNode,
          nextFocusNode:
              this.widget.role == 'Donor' ? _addressFocusNode : _cityFocusNode,
          validatorFn: _phoneValidator,
          controller: _phoneController,
          //showHelperText: !_isNewSignup(),
          enabled: _isNewSignup() || _isEditing,
        ),
        this.widget.role == 'Donor'
            ? InputBox(
                hintText: 'Your Street Address',
                focusNode: _addressFocusNode,
                nextFocusNode: _cityFocusNode,
                validatorFn: addressValidator,
                controller: _addressController,
                enabled: _isNewSignup() || _isEditing,
              )
            : SizedBox.shrink(),
        this.widget.role == 'Donor' || this.widget.role == 'Client'
            ? InputBox(
                hintText: 'Your City',
                focusNode: _cityFocusNode,
                nextFocusNode: this.widget.role == 'Donor'
                    ? _zipFocusNode
                    : _timeWithOVCFocusNode,
                validatorFn: cityValidator,
                controller: _cityController,
                enabled: _isNewSignup() || _isEditing,
              )
            : SizedBox.shrink(),
        this.widget.role == 'Donor'
            ? InputBox(
                hintText: 'Your Zip Code',
                focusNode: _zipFocusNode,
                validatorFn: zipValidator,
                controller: _zipController,
                enabled: _isNewSignup() || _isEditing,
              )
            : SizedBox.shrink(),
        this.widget.role == 'Client'
            ? InputBox(
                hintText: 'How long have you been with OVC?',
                focusNode: _timeWithOVCFocusNode,
                validatorFn: timeWithOVCValidator,
                controller: _timeWithOVCController,
                enabled: _isNewSignup() || _isEditing,
              )
            : SizedBox.shrink(),
        _isEditing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: LoginSignupButton('Update', _saveForm),
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
        _showButtons(),
      ],
    );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final profileInfoForm = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildProfileInfoWidgets(context),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          !_isNewSignup()
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                )
              : SizedBox.shrink(),
        ],
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: widgetColor,
        ),
        backgroundColor: backgroundColor,
      ),
      body: profileInfoForm,
    );
  }
}
