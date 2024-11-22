import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth;
  FirebaseFirestore firebaseFirestore;

  AuthService(this._auth, this.firebaseFirestore);

  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
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

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

        return await _auth.signInWithCredential(credential);
      }
      return null;
    } catch (e) {
      print('Facebook Sign-In Error: $e');
      return null;
    }
  }

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
      String smsCode
      ) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Phone Sign-In Error: $e');
      return null;
    }
  }

  String generateOTP() {
    final random = Random();
    final otp = random.nextInt(900000) + 100000; // Ensures a 6-digit number
    return otp.toString();
  }

  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    final query = await firebaseFirestore
        .collection('users')
        .where('telephone', isEqualTo: phoneNumber)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      final userId = doc.id;
      final otp = generateOTP();
      await firebaseFirestore.collection('users').doc(userId).update({
        'codeVerification': otp,
      });
      print('Generated OTP: $otp for user: $userId');
      return UserModel.fromJson({
        ...doc.data(),
        'codeVerification': otp,
      });
    } else {
      return null;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final query = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;

      return UserModel.fromJson({
        ...doc.data()
      });
    } else {
      return null;
    }

  }


  Future<UserModel?> verifyOtpAndTelephone(String phoneNumber, String otp) async {
    final query = await firebaseFirestore
        .collection('users')
        .where('telephone', isEqualTo: phoneNumber)
        .where('codeVerification', isEqualTo: otp)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return UserModel.fromJson({
        ...doc.data(),
        'id': doc.id,
      });
    } else {
      return null;
    }
  }

  Future<UserModel?> verifyPasswordAndTelephone(String telephone, String password) async {
    try {
      final query = await firebaseFirestore
          .collection('users')
          .where('telephone', isEqualTo: telephone)
          .where('password', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        return UserModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      } else {
        return null;
      }
    } catch (e) {
      print('Error verifying user: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await TokenStorage.deleteObject('user');
    await _auth.signOut();
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
  }

  // Check Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}