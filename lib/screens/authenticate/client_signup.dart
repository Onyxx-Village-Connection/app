import 'package:flutter/material.dart';

import './client_login.dart';
import './more_signup_info.dart';

import '../../widgets/auth/emailBox.dart';
import '../../widgets/auth/passwordBox.dart';
import '../../widgets/auth/loginSignupButton.dart';
import '../../widgets/auth/textLinkButton.dart';
import '../../widgets/auth/styleConstants.dart';

class ClientSignup extends StatefulWidget {
  ClientSignup({Key? key, required this.role}) : super(key: key);

  final String role;
  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup> {
  final _form = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String email = '';
  String password = '';

  Widget _buildClientSignupWidgets(BuildContext context) {
    void _saveForm() {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      _form.currentState!.save();

      _navigateToMoreSignupInfoPage(context);
    }

    void _onEmailSaved(value) {
      email = value;
    }

    void _onPasswordSaved(value) {
      password = value;
    }

    void _login(context) {
      _navigateToClientLogin(context);
    }

    return ListView(
      children: <Widget>[
        Image.asset(
          'images/ovclogo.png',
          height: 155,
          width: 155,
          scale: 1.2,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Text(
            'OVC serves its clients facing food insecurity by distributing food and making them aware of other helpful resources',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(height: 2.0),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 8,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
          child: EmailBox(_emailFocusNode, _passwordFocusNode, _onEmailSaved),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: PasswordBox(_passwordFocusNode, _onPasswordSaved),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(145.0, 20.0, 145.0, 15.0),
          child: LoginSignupButton('Next', _saveForm),
        ),
        TextLinkButton('Already have an account?', 'Login', _login),
      ],
    );
  }

  void _navigateToClientLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ClientLogin(role: widget.role);
      },
    ));
  }

  void _navigateToMoreSignupInfoPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MoreSignupInfo(
            title: 'More Signup Info', email: email, password: password);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final signupForm = Container(
      color: backgroundColor,
      child: Form(
        key: _form,
        child: _buildClientSignupWidgets(context),
      ),
    );

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.role + ' Signup'),
      // ),
      body: signupForm,
    );
  }
}
