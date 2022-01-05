import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModels {
  final String uid;

  UserModels({required this.uid});
}

class AuthenticationState with ChangeNotifier {
  String _uid = '';
  String _email = '';

  String get getUid => _uid;
  String get getEmail => _email;

  // FirebaseAuth auth;
  // User user;

// AuthenticationState() {
//   auth = FirebaseAuth.instance;
//   setupAuthListener();
// }

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModels? _userFromFirebaseUser(User? user) {
    return user != null ? UserModels(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModels?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Using Stream to listen to Authentication State
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> signUpUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email as String;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  setupAuthListener() {
    _auth.authStateChanges().listen((user) {
      print('Is User Signed in: ${user != null} as ${user?.uid}');
      //this.user = user;
      if (user != null) {
        // do something
      }
    });
  }

  Future<bool> loginUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email as String;
        return retval = true;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
        case "wrong-password":
        case "user-not-found":
          throw ("Incorrect email address or password.");

        case "user-disabled":
          throw ("This account is disabled");
      }
    }

    return retval;
  }
}
