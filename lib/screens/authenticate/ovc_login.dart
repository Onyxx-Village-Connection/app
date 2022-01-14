import 'package:flutter/material.dart';
import 'package:ovcapp/widgets/auth/helperFns.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/authentication.dart';
import 'ovc_signup.dart';

import '../../widgets/auth/passwordBox.dart';
import '../../widgets/auth/emailBox.dart';
import '../../widgets/auth/errSnackBar.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/textLinkButton.dart';
import '../../widgets/auth/styleConstants.dart';

class OVCLogin extends StatefulWidget {
  OVCLogin({Key? key, required this.role}) : super(key: key);

  final String role;
  @override
  _OVCLoginState createState() => _OVCLoginState();
}

class _OVCLoginState extends State<OVCLogin> {
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
        pushRoleBasedLandingPage(context, widget.role);
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
    _navigateToSignup(context);
  }

  Widget _buildLoginWidgets(BuildContext context) {
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

  void _navigateToSignup(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OVCSignup(role: widget.role)));
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildLoginWidgets(context),
      ),
    );

    return Scaffold(
      body: loginForm,
    );
  }
}
