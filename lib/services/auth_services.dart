import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithPasswordandEmail(String email, String password);
  Future<bool> registerWithPasswordandEmail(String email, String password);
  Future<bool> authinicateWithGoogle(); 
  User? currentUser();
  Future<void> logOut();
}

class AuthServicesImp implements AuthServices {
  final _fireAuth = FirebaseAuth.instance;
  @override
  Future<bool> loginWithPasswordandEmail(String email, String password) async {
    final userCredential = await _fireAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithPasswordandEmail(
    String email,
    String password,
  ) async {
    final userCredential = await _fireAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? currentUser() {
    return _fireAuth.currentUser;
  }

  @override
  Future<void> logOut() async {
   await GoogleSignIn.instance.signOut();
   await _fireAuth.signOut();
  }

  @override
  Future<bool> authinicateWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    final GoogleSignInAccount user = await googleSignIn.authenticate();

    final GoogleSignInClientAuthorization? authorization = await user
        .authorizationClient
        .authorizationForScopes(['email', 'profile']);

    final credential = GoogleAuthProvider.credential(
      idToken: user.authentication.idToken,
      accessToken: authorization?.accessToken,
    );
    final userCredential = await _fireAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }


}
