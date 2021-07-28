import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page.dart';
import 'volunteer_sign_in.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  String passwordConfirm = "";
  String error = "";
  var color = Colors.red;
  PermissionStatus _status = PermissionStatus.denied;
  final _auth = FirebaseAuth.instance;
  String downloadUrl = '';
  var _image;
  final ImagePicker _picker = ImagePicker();
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
    try {
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      await _firestore
          .collection("Volunteer")
          .doc("Data")
          .collection("User Data")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'email': email,
        'url': downloadUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _takePicture() async {
    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _image = File(imageFile.path);
    });
  }

  // void _askPermission() {
  //   PermissionHandler()
  //       .requestPermissions([PermissionGroup.camera]).then(_onStatusRequested);
  // }
  //
  // void _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
  //   // final status = value[PermissionGroup.camera];
  //   final status = PermissionStatus.granted;
  //   if (status == PermissionStatus.granted) {
  //     _takePicture();
  //   } else {
  //     _updateStatus(status);
  //   }
  // }
  //
  // _updateStatus(PermissionStatus value) {
  //   if (value != _status) {
  //     setState(() {
  //       _status = value;
  //     });
  //   }
  // }

  Widget showErrorBanner() {
    if (error != "") {
      return Column(
        children: [
          SizedBox(
            height: 27.5,
          ),
          Container(
            width: double.infinity,
            color: color,
            height: 72.5,
            child: Center(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 27.5,
          ),
        ],
      );
    }
    return SizedBox(
      height: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                showErrorBanner(),
                Container(
                  width: 238.0,
                  height: 151,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.onyxxvillageconnection.org/wp-content/uploads/2020/08/OVC-logo-cropped.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: 300.0,
                  width: 300.0,
                  color: kSecondaryColor,
                  child: _image == null
                      ? Center(child: Text('Take a picture for your profile.'))
                      : Image.file(_image!),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // _askPermission();
                        _takePicture();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        // _askPermission();
                        _takePicture();
                      },
                      child: Text(
                        'Take a Profile Picture',
                        style: TextStyle(
                          color: kSecondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter an email',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Create a password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    passwordConfirm = value;
                    if (password == passwordConfirm) {
                      passwordConfirm = value;
                    } else {
                      passwordConfirm = '';
                    }
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (email == "") {
                          setState(() {
                            error = 'Please enter an email';
                          });
                          return;
                        } else if (!EmailValidator.validate(email)) {
                          setState(() {
                            error = "The email address entered is invalid";
                          });
                          return;
                        } else if (password == "") {
                          setState(() {
                            error = 'Please enter a password';
                          });
                          return;
                        } else if (passwordConfirm == "") {
                          setState(() {
                            error = 'Please confirm your password';
                          });
                          return;
                        } else if (passwordConfirm != password) {
                          setState(() {
                            error = 'Your passwords do not match';
                          });
                          return;
                        } else if (passwordConfirm.length < 6) {
                          setState(() {
                            error =
                                "The password must be at least 6 characters";
                          });
                          return;
                        } else if (_image == null) {
                          setState(() {
                            error = "Please take a profile picture";
                          });
                          return;
                        } else {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: passwordConfirm);
                            if (email != "" || passwordConfirm != "") {
                              setState(() {
                                color = Colors.green;
                                error = "Success!";
                              });
                              await uploadImageToFirebase(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            }
                          } catch (e) {
                            print(e);
                            setState(() {
                              error = e.toString();
                            });
                          }
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: kSecondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
