import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:memebahadur/Screens/Login/loginscreen.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future loginWithFB(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email', 'public_profile']);

    print("Result : ${result.status}");
    print("ERRORRRRRRRRR" + result.errorMessage.toString());
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          var fbtoken = result.accessToken.token;
          print(fbtoken);

          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${fbtoken}');

          final profile = jsonDecode(graphResponse.body);
          final credential = FacebookAuthProvider.credential(fbtoken);
          _auth.signInWithCredential(credential);
          print('\n\n\n${graphResponse.body} \n\n\n');
          print('Profile $profile');
          return profile;
        } catch (e) {
          print(e);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("error before profile"),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }

        break;

      case FacebookLoginStatus.cancelledByUser:
        // setState(() => _isLoggedIn = false);
        break;

      case FacebookLoginStatus.error:
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error Connecting Server"),
            content: Text("Try Other Method"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        break;
    }
  }

  static Future<bool> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }),
      );
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<User> loginWithEmail({String email, String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<User> signInWithEmail({String email, String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      result.user.sendEmailVerification();

      return result.user;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<User> signinWithGoogle() async {
    final GoogleSignIn gs = GoogleSignIn();
    final googleUser = await gs.signIn();
    final googleAuth = await googleUser.authentication;
    final credetial = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final res = await _auth.signInWithCredential(credetial);
    print('-' * 100);
    print(res.user);
    return res.user;
  }
}
