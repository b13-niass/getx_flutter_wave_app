import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService{
  Future<UserCredential?> signIn();
  Future<void> signOut();
}