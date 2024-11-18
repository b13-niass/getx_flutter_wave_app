// Phone Authentication
class PhoneAuthProviderService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(PhoneAuthCredential) verificationCompleted,
      Function(FirebaseAuthException) verificationFailed,
      Function(String, int?) codeSent,
      Function(String) codeAutoRetrievalTimeout,
      ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential?> signInWithPhoneCode(
      String verificationId,
      String smsCode,
      ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Phone Sign-In Error: $e');
      return null;
    }
  }
}