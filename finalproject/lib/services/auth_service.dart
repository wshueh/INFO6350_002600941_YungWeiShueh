import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _google = GoogleSignIn();

  // Google Sign‑in
  Future<UserCredential?> signInWithGoogle() async {
    final gUser = await _google.signIn();
    if (gUser == null) return null;
    final gAuth = await gUser.authentication;
    final cred = GoogleAuthProvider.credential(
      idToken: gAuth.idToken,
      accessToken: gAuth.accessToken,
    );
    return _auth.signInWithCredential(cred);
  }

  // Email Sign-in
  Future<UserCredential> signInWithEmail(
          {required String email, required String pwd}) =>
      _auth.signInWithEmailAndPassword(email: email, password: pwd);

  // Email Register
  Future<UserCredential> registerWithEmail(
          {required String email, required String pwd}) =>
      _auth.createUserWithEmailAndPassword(email: email, password: pwd);

  // Sign- out
  Future<void> signOut() async {
    await _google.signOut();
    await _auth.signOut();
  }
}
