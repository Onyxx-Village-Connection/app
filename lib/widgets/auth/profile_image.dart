import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovcapp/assets/ovcicons.dart';

import 'styleConstants.dart';

class ProfileImage extends StatefulWidget {
  String? imgUri;
  final Function saveImgUrl;
  bool isEditing;

  ProfileImage(this.imgUri, this.saveImgUrl, this.isEditing);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _imageFile;
  ImagePicker picker = ImagePicker();

  Widget _chooseProfileImage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: widgetColor,
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _imageFile!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  Widget _displayProfileImage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              if (this.widget.isEditing) {
                _showPicker(context);
              }
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: widgetColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: this.widget.imgUri == null
                    ? Icon(OVCIcons.profileicon)
                    : Image.network(
                        this.widget.imgUri!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _imageFile != null ? _chooseProfileImage() : _displayProfileImage();
  }

  _imgFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );
    if (image != null) {
      _imageFile = File(image.path);
      this.widget.saveImgUrl(_imageFile);
    }
    setState(() {});
  }

  _imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      _imageFile = File(image.path);
      this.widget.saveImgUrl(_imageFile);
    }
    setState(() {});
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
