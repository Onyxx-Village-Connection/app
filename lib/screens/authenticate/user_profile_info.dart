import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_number/phone_number.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

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

enum TimeWithOVCUnits { years, months }

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
  TimeWithOVCUnits _timeWithOVCUnits = TimeWithOVCUnits.years;

  List<String> _languages = [
    'Arabic',
    'Chinese',
    'English',
    'French',
    'Japanese',
    'Portuguese',
    'Russian',
    'Spanish',
    'Other',
  ];

  List<String> _tasks = [
    'Meal Preparation',
    'Food Pick Up',
    'Food Delivery',
  ];

  List<String> _taskDescriptions = [
    'Monday – Thursday, 11am – 2pm\nResponsibilities: Package food for distribution',
    'Responsibilities: Pick up donated food from partners',
    'Monday – Thursday, 2pm – 5pm\nResponsibilities: Distribute pre-made dinners to the community – requires driving license/car',
  ];

  List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  GroupController _languagesController =
      GroupController(isMultipleSelection: true);
  GroupController _tasksController = GroupController(isMultipleSelection: true);
  GroupController _availabilityController =
      GroupController(isMultipleSelection: true);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _zipController = TextEditingController();

  TextEditingController _name2Controller = TextEditingController();
  TextEditingController _city2Controller = TextEditingController();
  TextEditingController _phone2Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _zip2Controller = TextEditingController();

  TextEditingController _timeWithOVCController = TextEditingController();
  TextEditingController _volunteerStmtController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _timeWithOVCFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  final _name2FocusNode = FocusNode();
  final _city2FocusNode = FocusNode();
  final _phone2FocusNode = FocusNode();
  final _zip2FocusNode = FocusNode();
  final _address2FocusNode = FocusNode();

  DonorModel? _currentDonor;
  ClientModel? _currentClient;
  VolunteerModel? _currentVolunteer;

  final authUser = FirebaseAuth.instance.currentUser;

  void _getVolunteerData() {
    FirebaseFirestore.instance
        .collection("volunteers")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentVolunteer = VolunteerModel.fromMap(value.data(), authUser!.uid);

      if (_currentVolunteer != null) {
        setState(() {
          _nameController.text = _currentVolunteer!.name;
          _phoneController.text = _currentVolunteer!.phone;
          _imageUrl = _currentVolunteer!.profileImage;
        });
      }
    });
  }

  void _getClientData() {
    FirebaseFirestore.instance
        .collection("clients")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentClient = ClientModel.fromMap(value.data(), authUser!.uid);

      if (_currentClient != null) {
        setState(() {
          _nameController.text = _currentClient!.name;
          _phoneController.text = _currentClient!.phone;
          _cityController.text = _currentClient!.city;
          _timeWithOVCController.text =
              getTimeWithOVC(_currentClient!.timeWithOVC);
          _imageUrl = _currentClient!.profileImage;
        });
      }
    });
  }

  void _getDonorData() {
    FirebaseFirestore.instance
        .collection("donors")
        .doc(authUser!.uid)
        .get()
        .then((value) {
      _currentDonor = DonorModel.fromMap(value.data(), authUser!.uid);

      if (_currentDonor != null) {
        setState(() {
          _nameController.text = _currentDonor!.orgName;
          _phoneController.text = _currentDonor!.corpPhone;
          _cityController.text = _currentDonor!.corpCity;
          _addressController.text = _currentDonor!.corpAddress;
          _zipController.text = _currentDonor!.corpZip;

          _name2Controller.text = _currentDonor!.contactName;
          _phone2Controller.text = _currentDonor!.contactPhone;
          _city2Controller.text = _currentDonor!.pickupCity;
          _address2Controller.text = _currentDonor!.pickupAddress;
          _zip2Controller.text = _currentDonor!.pickupZip;

          _imageUrl = _currentDonor!.profileImage;
        });
      }
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

    _name2Controller.dispose();
    _city2Controller.dispose();
    _phone2Controller.dispose();
    _address2Controller.dispose();
    _zip2Controller.dispose();
    _volunteerStmtController.dispose();

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

    String formatted2Phone =
        await PhoneNumberUtil().format(_phone2Controller.text, 'US');

    var newDonor = DonorModel(
      uid: authUser == null ? '' : auth.currentUser!.uid,
      orgName: _nameController.text,
      corpPhone: formattedPhone,
      corpCity: _cityController.text,
      corpAddress: _addressController.text,
      corpZip: _zipController.text,
      contactName: _name2Controller.text,
      contactPhone: formatted2Phone,
      pickupCity: _city2Controller.text,
      pickupAddress: _address2Controller.text,
      pickupZip: _zip2Controller.text,
      profileImage: _uploadedImgUrl,
      createdAt: _currentDonor != null ? _currentDonor!.createdAt : null,
    );

    if (authUser == null) {
      donors.doc(auth.currentUser!.uid).set(newDonor.toMap());
    } else {
      await donors.doc(authUser!.uid).update(newDonor.toMap());
    }
    return;
  }

  String getTimeWithOVC(double timeInMonths) {
    if (timeInMonths >= 12) {
      _timeWithOVCUnits = TimeWithOVCUnits.years;
      return (timeInMonths / 12).toString();
    } else {
      _timeWithOVCUnits = TimeWithOVCUnits.months;
      return timeInMonths.toString();
    }
  }

  double getTimeInMonths(String duration) {
    var timeEntered = double.parse(duration);
    if (_timeWithOVCUnits == TimeWithOVCUnits.years) {
      return timeEntered * 12;
    } else
      return timeEntered;
  }

  Future<void> _setClientInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference clients =
        FirebaseFirestore.instance.collection('clients');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var newClient = ClientModel(
      uid: authUser == null ? '' : auth.currentUser!.uid,
      name: _nameController.text,
      phone: formattedPhone,
      city: _cityController.text,
      timeWithOVC: getTimeInMonths(_timeWithOVCController.text),
      profileImage: _uploadedImgUrl,
      createdAt: _currentClient != null ? _currentClient!.createdAt : null,
    );

    if (authUser == null) {
      clients.doc(auth.currentUser!.uid).set(newClient.toMap());
    } else {
      await clients.doc(authUser!.uid).update(newClient.toMap());
    }
    return;
  }

  Future<void> _setVolunteerInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference volunteers =
        FirebaseFirestore.instance.collection('volunteers');

    String formattedPhone =
        await PhoneNumberUtil().format(_phoneController.text, 'US');

    var langList = [];
    _languagesController.selectedItem
        .forEach((item) => langList.add(_languages[item]));
    var taskList = [];
    _tasksController.selectedItem.forEach((item) => taskList.add(_tasks[item]));
    var availabilityList = [];
    _availabilityController.selectedItem
        .forEach((item) => availabilityList.add(_days[item]));

    var newVolunteer = VolunteerModel(
      uid: authUser == null ? '' : auth.currentUser!.uid,
      name: _nameController.text,
      phone: formattedPhone,
      profileImage: _uploadedImgUrl,
      languages: langList.toString(),
      tasks: taskList.toString(),
      availability: availabilityList.toString(),
      volunteerStmt: _volunteerStmtController.text,
      createdAt:
          _currentVolunteer != null ? _currentVolunteer!.createdAt : null,
    );

    if (authUser == null) {
      volunteers.doc(auth.currentUser!.uid).set(newVolunteer.toMap());
    } else {
      await volunteers.doc(authUser!.uid).update(newVolunteer.toMap());
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
    try {
      if (await signUpUser(widget.email!, widget.password!)) {
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

    // Check that volunteer widgets were set properly
    if (this.widget.role == 'Volunteer') {
      if (_tasksController.selectedItem.length == 0 ||
          _availabilityController.selectedItem.length == 0 ||
          _languagesController.selectedItem.length == 0) {
        ErrSnackBar.show(context,
            "Please specify your languages, interest area and availability");
        return;
      }
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

  Widget _nameBox({second = false}) {
    return InputBox(
      hintText: 'Name',
      focusNode: second ? _name2FocusNode : _nameFocusNode,
      nextFocusNode: second ? _phone2FocusNode : _phoneFocusNode,
      validatorFn: nameValidator,
      controller: second ? _name2Controller : _nameController,
      enabled: _isNewSignup() || _isEditing,
    );
  }

  Widget _phoneBox({second = false}) {
    return InputBox(
      hintText: 'Phone Number',
      focusNode: second ? _phone2FocusNode : _phoneFocusNode,
      nextFocusNode: this.widget.role == 'Donor'
          ? second
              ? _address2FocusNode
              : _addressFocusNode
          : second
              ? _city2FocusNode
              : _cityFocusNode,
      validatorFn: _phoneValidator,
      controller: second ? _phone2Controller : _phoneController,
      enabled: _isNewSignup() || _isEditing,
    );
  }

  Widget _addressBox({second = false}) {
    return InputBox(
      hintText: 'Street Address',
      focusNode: second ? _address2FocusNode : _addressFocusNode,
      nextFocusNode: second ? _city2FocusNode : _cityFocusNode,
      validatorFn: addressValidator,
      controller: second ? _address2Controller : _addressController,
      enabled: _isNewSignup() || _isEditing,
    );
  }

  Widget _cityBox({second = false}) {
    return InputBox(
      hintText: 'City',
      focusNode: second ? _city2FocusNode : _cityFocusNode,
      nextFocusNode: this.widget.role == 'Donor'
          ? second
              ? _zip2FocusNode
              : _zipFocusNode
          : _timeWithOVCFocusNode,
      validatorFn: cityValidator,
      controller: second ? _city2Controller : _cityController,
      enabled: _isNewSignup() || _isEditing,
    );
  }

  Widget _zipBox({second = false}) {
    return InputBox(
      hintText: 'Zip Code',
      focusNode: second ? _zip2FocusNode : _zipFocusNode,
      validatorFn: zipValidator,
      controller: second ? _zip2Controller : _zipController,
      enabled: _isNewSignup() || _isEditing,
    );
  }

  Widget _timeWithOVCBox() {
    return Column(
      children: [
        InputBox(
          hintText: 'How long have you been with OVC?',
          focusNode: _timeWithOVCFocusNode,
          validatorFn: doubleValueValidator,
          controller: _timeWithOVCController,
          enabled: _isNewSignup() || _isEditing,
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<TimeWithOVCUnits>(
                  title: const Text(
                    'Years',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  value: TimeWithOVCUnits.years,
                  groupValue: _timeWithOVCUnits,
                  onChanged: (TimeWithOVCUnits? value) {
                    setState(() {
                      _timeWithOVCUnits = TimeWithOVCUnits.years;
                    });
                  }),
            ),
            Expanded(
                child: RadioListTile<TimeWithOVCUnits>(
                    title: const Text(
                      'Months',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    value: TimeWithOVCUnits.months,
                    groupValue: _timeWithOVCUnits,
                    onChanged: (TimeWithOVCUnits? value) {
                      setState(() {
                        _timeWithOVCUnits = TimeWithOVCUnits.months;
                      });
                    })),
          ],
        ),
      ],
    );
  }

  Widget _languagesSpokenGroup() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Languages Spoken:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SimpleGroupedChips<int>(
            controller: _languagesController,
            values: List.generate(_languages.length, (index) => index),
            itemTitle: _languages,
            backgroundColorItem: Colors.black26,
            isScrolling: false,
            chipGroupStyle: ChipGroupStyle.minimize(
              backgroundColorItem: Color(0xFFE0CB8F),
              itemTitleStyle: TextStyle(
                fontSize: 14,
              ),
            ),
            onItemSelected: (values) {
              print(values);
            },
          ),
        ],
      ),
    );
  }

  Widget _tasksGroup() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How would you like to help?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SimpleGroupedCheckbox<int>(
            controller: _tasksController,
            itemsTitle: _tasks,
            itemsSubTitle: _taskDescriptions,
            values: List.generate(_tasks.length, (index) => index),
            groupStyle: GroupStyle(
                activeColor: Color(0xFFE0CB8F),
                itemTitleStyle: TextStyle(fontSize: 14)),
            checkFirstElement: false,
          )
        ],
      ),
    );
  }

  Widget _availability() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What days are you available?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SimpleGroupedChips<int>(
            controller: _availabilityController,
            values: List.generate(_days.length, (index) => index),
            itemTitle: _days,
            backgroundColorItem: Colors.black26,
            isScrolling: false,
            chipGroupStyle: ChipGroupStyle.minimize(
              backgroundColorItem: Color(0xFFE0CB8F),
              itemTitleStyle: TextStyle(
                fontSize: 14,
              ),
            ),
            onItemSelected: (values) {
              print(values);
            },
          ),
        ],
      ),
    );
  }

  Widget _volunteerStmt() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why would you like to volunteer with us?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          TextField(
            controller: _volunteerStmtController,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  List<Widget> _donorWidgets() {
    return [
      _addressBox(),
      _cityBox(),
      _zipBox(),
      Divider(),
      Text(
        'Contact Person Information:',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      _nameBox(second: true),
      _phoneBox(second: true),
      Text(
        'Donations Pickup Address:',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      _addressBox(second: true),
      _cityBox(second: true),
      _zipBox(second: true),
    ];
  }

  List<Widget> _clientWidgets() {
    return [
      _cityBox(),
      _timeWithOVCBox(),
    ];
  }

  List<Widget> _volunteerWidgets() {
    if (_currentVolunteer != null)
      return [];
    else
      return [
        _languagesSpokenGroup(),
        _tasksGroup(),
        _availability(),
        _volunteerStmt(),
      ];
  }

  Widget _showEditingButtons() {
    return Row(
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
    );
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
        !_isNewSignup()
            ? Center(
                child: Text('${FirebaseAuth.instance.currentUser!.email}',
                    style: textStyle))
            : Text(''),
        if (this.widget.role == 'Donor')
          Text(
            'Corporation/Organization Info:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        _nameBox(),
        _phoneBox(),
        if (this.widget.role == 'Donor')
          ..._donorWidgets()
        else if (this.widget.role == 'Client')
          ..._clientWidgets()
        else if (this.widget.role == 'Volunteer')
          ..._volunteerWidgets(),
        _isEditing ? _showEditingButtons() : Container(),
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
