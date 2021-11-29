// 'New Donation' screen for donor
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ovcapp/screens/donors/donation.dart';
import 'package:ovcapp/screens/donors/donations_provider.dart';

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

  Image _picture = Image(image: AssetImage('images/placeholder.jpg'));

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
            : Text('Update Donation')),
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
                  child: _picture,
                ),
              ),
              _newDonationField(
                  _nameController, 'Item name', 'Item name', "text"),
              _newDonationField(_weightController, 'Item weight (lb)',
                  'Item weight (lb)', 'double'),
              _newDonationField(_numBoxesController, 'Number of boxes',
                  'Number of boxes', 'number'),
              _newDonationField(_numMealsController, 'Number of meals',
                  'Number of meals', 'number'),
              const Text('Dimension'),
              Row(
                children: [
                  Expanded(
                    child: _newDonationField(_widthController, 'Width (inch)',
                        'Width (inch)', 'double'),
                  ),
                  Expanded(
                    child: _newDonationField(_depthController, 'Depth (inch)',
                        'Depth (inch)', 'double'),
                  ),
                  Expanded(
                      child: _newDonationField(_heightController,
                          'Height (inch)', 'Height (inch)', 'double', false)),
                ],
              ),
              const Text('Indicate Possible Allergens:'),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                        title: const Text('Dairy'),
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
                        title: const Text('Nuts'),
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
                        title: const Text('Eggs'),
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
                          title: const Text('Yes'),
                          value: true,
                          groupValue: donation.reqFrige,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.reqFrige = true;
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('No'),
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
                          title: const Text('Yes'),
                          value: true,
                          groupValue: donation.isGrocery,
                          onChanged: (bool? value) {
                            setState(() {
                              donation.isGrocery = true;
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('No'),
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

  Widget _newDonationField(
      TextEditingController controller, String label, String hint, String type,
      [bool nextFocus = true]) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: type.contains("num")
            ? TextInputType.number
            : type.contains("double")
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          type.contains("num")
              ? FilteringTextInputFormatter.digitsOnly
              : type.contains("double")
                  ? FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]+\.*[0-9]*'))
                  : FilteringTextInputFormatter.allow(RegExp(r'\w+'))
        ],
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        onEditingComplete: () {
          if (label.contains("name")) {
            donation.name = _nameController.text;
          } else if (label.contains("weight")) {
            donation.weight = double.parse(_weightController.text);
          } else if (label.contains("box")) {
            donation.numBoxes = int.parse(_numBoxesController.text);
          } else if (label.contains("meal")) {
            donation.numMeals = int.parse(_numMealsController.text);
          } else if (label.contains("Width")) {
            donation.width = double.parse(_widthController.text);
          } else if (label.contains("Depth")) {
            donation.depth = double.parse(_depthController.text);
          } else if (label.contains("Height")) {
            donation.height = double.parse(_heightController.text);
          } else {
            // do nothing
          }
          nextFocus
              ? FocusScope.of(context).nextFocus()
              : FocusScope.of(context).unfocus();
        },
        validator: (text) => (text != null && text.isEmpty) ? hint : null,
      ),
    );
  }

  void _takePicture() async {
    XFile? picFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (picFile != null) {
      setState(() {
        _picture = Image.file(
          File(picFile.path),
          fit: BoxFit.fitWidth,
        );
      });
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

    var donations = DonationsProvider.of(context);
    print("Before adding new donation, num of donations: " +
        donations.length().toString());
    print("Add new donation: " + donation.name);
    donations.add(donation);
    print("After adding new donation, num of donations: " +
        donations.length().toString());

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
