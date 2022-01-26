import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModels {
  final String uid;

  UserModels({required this.uid});
}

class AuthenticationState with ChangeNotifier {
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
        return retval = true;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw ("This email address is already associated with another account");
        case "invalid-email":
          throw ("Please enter a valid email address");
        case "weak-password":
          throw ("Please use a strong password");
        case "operation-not-allowed":
          throw ("This operation is not supported");
      }
    }

    return retval;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
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
