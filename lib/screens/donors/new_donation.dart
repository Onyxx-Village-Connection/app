// 'New Donation' screen for donor
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import './donation.dart';
import './donations_provider.dart';
import '../../widgets/auth/inputBox.dart';
import '../../widgets/auth/helperFns.dart';

// new donation form widget
class NewDonation extends StatefulWidget {
  final Donation donation;

  const NewDonation({Key? key, required this.donation}) : super(key: key);

  @override
  _NewDonationState createState() => _NewDonationState(donation);
}

class _NewDonationState extends State<NewDonation> {
  Donation donation;
  _NewDonationState(this.donation);

  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _numBoxesController = TextEditingController();
  final _numMealsController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  final _heightController = TextEditingController();
  File? _itemImgFile;

  @override
  initState() {
    super.initState();
    if (!this.widget.donation.name.isEmpty) {
      setState(() {
        _nameController.text = this.widget.donation.name;
        _weightController.text = this.widget.donation.weight.toString();
        _numBoxesController.text = this.widget.donation.numBoxes.toString();
        _numMealsController.text = this.widget.donation.numMeals.toString();
        _widthController.text = this.widget.donation.width.toString();
        _heightController.text = this.widget.donation.height.toString();
        _depthController.text = this.widget.donation.depth.toString();
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _nameController.dispose();
    _weightController.dispose();
    _numBoxesController.dispose();
    _numMealsController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _depthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (donation.docId.isNotEmpty) {
      _nameController.text = donation.name;
      _nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length));
      _weightController.text = donation.weight.toString();
      _weightController.selection = TextSelection.fromPosition(
          TextPosition(offset: _weightController.text.length));
      _numBoxesController.text = donation.numBoxes.toString();
      _numBoxesController.selection = TextSelection.fromPosition(
          TextPosition(offset: _numBoxesController.text.length));
      _numMealsController.text = donation.numMeals.toString();
      _numMealsController.selection = TextSelection.fromPosition(
          TextPosition(offset: _numMealsController.text.length));
      _widthController.text = donation.width.toString();
      _widthController.selection = TextSelection.fromPosition(
          TextPosition(offset: _widthController.text.length));
      _depthController.text = donation.depth.toString();
      _depthController.selection = TextSelection.fromPosition(
          TextPosition(offset: _depthController.text.length));
      _heightController.text = donation.height.toString();
      _heightController.selection = TextSelection.fromPosition(
          TextPosition(offset: _heightController.text.length));
    }
    return Scaffold(
      appBar: AppBar(
        title: (donation.docId.isEmpty
            ? Text('New Donation')
            : Text('Donation: ${donation.name}')),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // avoid overflow when keyboard is shown
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _takePicture,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: donation.itemImgUrl != null
                      ? Image.network(donation.itemImgUrl!)
                      : _itemImgFile != null
                          ? Image.file(
                              File(_itemImgFile!.path),
                              fit: BoxFit.fitWidth,
                            )
                          : Image(image: AssetImage('images/placeholder.jpg')),
                ),
              ),
              InputBox(
                hintText: 'Item Name',
                validatorFn: itemNameValidator,
                controller: _nameController,
              ),
              InputBox(
                hintText: 'Item weight (in lbs.)',
                validatorFn: doubleValueValidator,
                controller: _weightController,
              ),
              InputBox(
                hintText: 'Number of boxes',
                validatorFn: intValueValidator,
                controller: _numBoxesController,
              ),
              InputBox(
                hintText: 'Number of meals',
                validatorFn: intValueValidator,
                controller: _numMealsController,
              ),
              const Text('Dimension (inches)'),
              Row(
                children: [
                  Expanded(
                    child: InputBox(
                      controller: _widthController,
                      validatorFn: doubleValueValidator,
                      hintText: 'Width',
                    ),
                  ),
                  Expanded(
                    child: InputBox(
                      controller: _depthController,
                      hintText: 'Depth',
                      validatorFn: doubleValueValidator,
                    ),
                  ),
                  Expanded(
                    child: InputBox(
                      controller: _heightController,
                      hintText: 'Height',
                      validatorFn: doubleValueValidator,
                    ),
                  ),
                ],
              ),
              const Text('Indicate Possible Allergens:'),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                        title: const Text(
                          'Dairy',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: donation.hasDairy,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            donation.hasDairy =
                                (value != null && value) ? true : false;
                          });
                        }),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                        title: const Text(
                          'Nuts',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: donation.hasNuts,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            donation.hasNuts =
                                (value != null && value) ? true : false;
                          });
                        }),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                        title: const Text(
                          'Eggs',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: donation.hasEggs,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            donation.hasEggs =
                                (value != null && value) ? true : false;
                          });
                        }),
                  ),
                ],
              ),
              const Text('Does this require refrigeration?'),
              Row(
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: true,
                          groupValue: donation.reqFrige,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.reqFrige = true;
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: false,
                          groupValue: donation.reqFrige,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.reqFrige = false;
                            });
                          })),
                ],
              ),
              const Text('Is this a grocery donation?'),
              Row(
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: true,
                          groupValue: donation.isGrocery,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.isGrocery = true;
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: false,
                          groupValue: donation.isGrocery,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.isGrocery = false;
                            });
                          })),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  const Text('Pick up Date: '),
                  OutlinedButton(
                    child: Text(DateFormat.yMd().format(donation.pickupDate)),
                    onPressed: () async {
                      var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: donation.pickupDate,
                        firstDate: donation.pickupDate,
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          donation.pickupDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  const Text('Pick up Time: '),
                  OutlinedButton(
                    child: Text(donation.pickupFromTime.format(context)),
                    onPressed: () async {
                      var pickedTime = await showTimePicker(
                          context: context,
                          initialTime: donation.pickupFromTime);
                      if (pickedTime != null) {
                        setState(() {
                          donation.pickupFromTime = pickedTime;
                        });
                      }
                    },
                  ),
                  const Text(' To '),
                  OutlinedButton(
                    child: Text(donation.pickupToTime.format(context)),
                    onPressed: () async {
                      var pickedTime = await showTimePicker(
                          context: context, initialTime: donation.pickupToTime);
                      if (pickedTime != null) {
                        if ((pickedTime.hour * 60 + pickedTime.minute) >
                            (donation.pickupFromTime.hour * 60 +
                                donation.pickupFromTime.minute)) {
                          setState(() {
                            donation.pickupToTime = pickedTime;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitNewDonation(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _takePicture() async {
    XFile? picFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (picFile != null) {
      _itemImgFile = File(picFile.path);
      setState(() {});
    }
  }

  void _submitNewDonation(BuildContext context) {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }

    // gather all the inputs
    donation.name = _nameController.text;
    donation.weight = double.parse(_weightController.text);
    donation.numBoxes = int.parse(_numBoxesController.text);
    donation.numMeals = int.parse(_numMealsController.text);
    donation.width = double.parse(_widthController.text);
    donation.depth = double.parse(_depthController.text);
    donation.height = double.parse(_heightController.text);
    donation.itemImg = _itemImgFile;

    var donations = DonationsProvider.of(context);
    donations.add(donation);

    // show pop up
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Thank You'),
        content: const Text('Your Donation has been submitted to OVC.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              Navigator.pop(context, donation);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
