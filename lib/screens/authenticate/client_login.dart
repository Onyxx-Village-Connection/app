import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/authentication.dart';
import '../authenticate/client_signup.dart';
import '../client/client_home_tabs.dart';
import '../donors/my_donations.dart';
import '../../widgets/auth/passwordBox.dart';
import '../../widgets/auth/emailBox.dart';
import '../../widgets/auth/errSnackBar.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/textLinkButton.dart';
import '../../widgets/auth/styleConstants.dart';

class ClientLogin extends StatefulWidget {
  ClientLogin({Key? key, required this.role}) : super(key: key);

  final String role;
  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {
  final _form = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String email = '';
  String password = '';

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    AuthenticationState _authState =
        Provider.of<AuthenticationState>(context, listen: false);

    try {
      if (await _authState.loginUser(email, password)) {
        switch (widget.role) {
          case 'Client':
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ClientHomeTabBarScreen()));
            break;

          case 'Donor':
            Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (context) => MyDonations()));
            break;

          case 'Volunteer':
            Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
                builder: (context) => ClientHomeTabBarScreen()));
            break;
        }
      }
    } catch (error) {
      ErrSnackBar.show(context, error as String);
    }
  }

  void _onEmailSaved(value) {
    email = value;
  }

  void _onPasswordSaved(value) {
    password = value;
  }

  void _signUp(context) {
    _navigateToClientSignup(context);
  }

  Widget _buildClientLoginWidgets(BuildContext context) {
    return ListView(
      children: <Widget>[
        Image.asset(
          'images/ovclogo.png',
          height: 250,
          width: 250,
          scale: 1.0,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
          child: EmailBox(_emailFocusNode, _passwordFocusNode, _onEmailSaved),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: PasswordBox(_passwordFocusNode, _onPasswordSaved),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 15.0),
          child: LoginSignupButton('Login', _saveForm),
        ),
        TextLinkButton('Do not have an account?', 'Sign up', _signUp),
      ],
    );
  }

  void _navigateToClientSignup(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ClientSignup(role: widget.role);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildClientLoginWidgets(context),
      ),
    );

    return Scaffold(
      body: loginForm,
    );
  }
}
