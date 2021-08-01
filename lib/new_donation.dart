// 'New Donation' screen for donor
import 'package:flutter/material.dart';
import 'package:ovcapp/donation.dart';

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
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  final _heightController = TextEditingController();

  var donation = new Donation();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        // avoid overflow when keyboard is shown
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _newDonationField(_nameController, 'Item name', 'Item name'),
            _newDonationField(_weightController, 'Item weight', 'Item weight'),
            _newDonationField(
                _numBoxesController, 'Number of boxes', 'Number of boxes'),
            _newDonationField(
                _numMealsController, 'Number of meals', 'Number of meals'),
            const Text('Dimension (inch)'),
            Row(
              children: [
                Expanded(
                  child: _newDonationField(_widthController, 'Width', 'Width'),
                ),
                Expanded(
                  child: _newDonationField(_depthController, 'Depth', 'Depth'),
                ),
                Expanded(
                  child: _newDonationField(
                      _heightController, 'Height', 'Height', false),
                ),
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
      TextEditingController controller, String label, String hint,
      [bool nextFocus = true]) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        onEditingComplete: () => nextFocus
            ? FocusScope.of(context).nextFocus()
            : FocusScope.of(context).unfocus(),
        validator: (text) => (text != null && text.isEmpty) ? hint : null,
      ),
    );
  }

  void _submitNewDonation() {
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
