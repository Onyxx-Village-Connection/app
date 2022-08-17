import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/auth/styleConstants.dart';

enum VolunteerActivity { pickup, delivery, foodPrep }

class AddLogHoursScreen extends StatefulWidget {
  AddLogHoursScreen({Key? key}) : super(key: key);

  @override
  State<AddLogHoursScreen> createState() => _AddLogHoursScreenState();
}

class _AddLogHoursScreenState extends State<AddLogHoursScreen> {
  int _numHours = 0;
  var _selectedActivity;

  @override
  initState() {
    super.initState();
    _numHours = 0;
    _selectedActivity = VolunteerActivity.pickup;
  }

  void _incrementHours() {
    setState(() {
      _numHours++;
    });
  }

  void _decrementHours() {
    setState(() {
      if (_numHours != 0) {
        _numHours--;
      }
    });
  }

  void _addLogHours(BuildContext context) async {
    await FirebaseFirestore.instance.collection('volunteerLogEntries').add({
      'volunteerId': FirebaseAuth.instance.currentUser!.uid,
      'numHours': _numHours,
      'activity': _selectedActivity.toString().split('.').last,
      'createdAt': FieldValue.serverTimestamp(),
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log Hours")),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Enter today\'s volunteer hours:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: widgetColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: '-',
                        onPressed: _decrementHours,
                        child: Icon(Icons.remove, color: Colors.black),
                        backgroundColor: widgetColor,
                      ),
                      Text(
                        '$_numHours',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: widgetColor,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: '+',
                        onPressed: _incrementHours,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: widgetColor,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Select your Volunteer Activity:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: widgetColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    activeColor: widgetColor,
                    selectedTileColor: widgetColor,
                    title: const Text('Pickups'),
                    value: VolunteerActivity.pickup,
                    groupValue: _selectedActivity,
                    onChanged: (val) {
                      setState(() {
                        _selectedActivity = VolunteerActivity.pickup;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Deliveries'),
                    value: VolunteerActivity.delivery,
                    activeColor: widgetColor,
                    selectedTileColor: widgetColor,
                    groupValue: _selectedActivity,
                    onChanged: (val) {
                      setState(() {
                        _selectedActivity = VolunteerActivity.delivery;
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: widgetColor,
                    selectedTileColor: widgetColor,
                    title: const Text('Food Prep'),
                    value: VolunteerActivity.foodPrep,
                    groupValue: _selectedActivity,
                    onChanged: (val) {
                      setState(() {
                        _selectedActivity = VolunteerActivity.foodPrep;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widgetColor, // Background color
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  _addLogHours(context);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
