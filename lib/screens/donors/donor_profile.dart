// 'Donor Profile' screen
import 'package:flutter/material.dart';
import 'package:ovcapp/screens/donors/donor.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  var donor = new Donor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // avoid overflow when keyboard is shown
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _donorProfileField(_nameController, 'Donor name', 'Donor name'),
              _donorProfileField(
                  _addressController, 'Donor address', 'Donor address'),
              _donorProfileField(
                  _phoneController, 'Donor phone number', 'Donor phone number'),
              _donorProfileField(
                  _emailController, 'Donor email', 'Donor email'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveDonorProfile(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _donorProfileField(
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

  void _saveDonorProfile(BuildContext context) {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }

    donor.name = _nameController.text;
    donor.address = _addressController.text;
    donor.phone = _phoneController.text;
    donor.address = _addressController.text;

    Navigator.pop(context, donor);
  }
}
