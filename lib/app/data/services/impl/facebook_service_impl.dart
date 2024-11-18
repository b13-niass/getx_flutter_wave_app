import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:getx_wave_app/app/data/services/auth_service.dart';

class FacebookAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);

        return await _auth.signInWithCredential(credential);
      }
      return null;
    } catch (e) {
      print('Facebook Sign-In Error: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}