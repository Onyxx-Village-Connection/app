import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:ovcapp/volunteer_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'constants.dart';

final _firestore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _image;
  final ImagePicker _picker = ImagePicker();
  String downloadUrl = '';
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
        'email': FirebaseAuth.instance.currentUser!.email,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Picture(),
              IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _askPermission();
                  setState(() async {
                    await _takePicture();
                    await uploadImageToFirebase(context);
                  });
                },
              ),
              GestureDetector(
                onTap: () async {
                  // _askPermission();
                  await _takePicture();
                  await uploadImageToFirebase(context);
                },
                child: Text(
                  'Retake Profile Picture?',
                  style: TextStyle(
                    color: kSecondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Email: ' + FirebaseAuth.instance.currentUser!.email.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    minWidth: 200,
                    height: 42,
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Picture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('Volunteer')
          .doc('Data')
          .collection('User Data')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("NO DATA");
          return Container(
            padding: EdgeInsets.all(8.0),
            height: 300.0,
            width: 300.0,
            color: kSecondaryColor,
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
            ),
          );
        }
        final profilePic = snapshot.data!.docs;
        var urlString;
        for (var pic in profilePic) {
          final url = pic.get('url');
          final email = pic.get('email');
          if (email == FirebaseAuth.instance.currentUser!.email) {
            urlString = Image.network(url);
          }
        }
        return Container(
          key: UniqueKey(),
          padding: EdgeInsets.all(8.0),
          height: 300.0,
          width: 300.0,
          color: kSecondaryColor,
          child: urlString,
        );
      },
    );
  }
}

// class ProfilePic extends StatelessWidget {
//   ProfilePic(this.one, this.two)
//
//   final one;
//   final two;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       height: 300.0,
//       width: 300.0,
//       color: kSecondaryColor,
//       child: Image.network(one),
//     );
//   }
// }
