import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> logout() async {
    try {
      await _auth.signOut();

      return true;
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
    GoogleSignIn gs = GoogleSignIn();
    final googleUser = await gs.signIn();
    final googleAuth = await googleUser.authentication;
    final credetial = await GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final res = await _auth.signInWithCredential(credetial);
    return res.user;
  }
}
