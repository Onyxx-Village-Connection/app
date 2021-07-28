import 'package:flutter/material.dart';

class NewDonation extends StatelessWidget {
  const NewDonation({Key? key, required this.title}) : super(key: key);

  final String title; // title of page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: NewDonationForm(),
    );
  }
}

// new donation form widget
class NewDonationForm extends StatefulWidget {
  const NewDonationForm({Key? key}) : super(key: key);

  @override
  _NewDonationFormState createState() => _NewDonationFormState();
}

class _NewDonationFormState extends State<NewDonationForm> {
  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _numBoxesController = TextEditingController();
  final _numMealsController = TextEditingController();
  final _dimensionController = TextEditingController();

  var donation = new Donation();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _newDonationField(_nameController, 'Item name', 'Item name'),
            _newDonationField(_weightController, 'Item weight', 'Item weight'),
            _newDonationField(
                _numBoxesController, 'Number of boxes', 'Number of boxes'),
            _newDonationField(
                _numMealsController, 'Number of meals', 'Number of meals'),
            _newDonationField(
                _dimensionController, 'Appx. dimension', 'Appx. dimension'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNewDonation,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newDonationField(
      TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        validator: (text) => (text != null && text.isEmpty) ? hint : null,
      ),
    );
  }

  void _submitNewDonation() {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }

    // show pop up
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Thank You'),
        content: const Text('Your Donation has been submitted to OVC.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class Donation {
  String name = "unknown";
  double weight = 0.0;
  int numBoxes = 0;
  int numMeals = 0;
  String dimension = "";
  double width = 0.0;
  double height = 0.0;
  double depth = 0.0;
  bool hasDairy = false;
  bool hasNuts = false;
  bool hasEggs = false;
  bool reqFrige = false;
  bool isGrocery = false;
  DateTime pickupDateTime = DateTime.now();
}
