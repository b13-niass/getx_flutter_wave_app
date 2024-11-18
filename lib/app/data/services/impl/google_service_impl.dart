import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_wave_app/app/data/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }
}