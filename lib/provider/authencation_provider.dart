import 'package:app_social/models/user_app.dart';
import 'package:app_social/page/login/login_page_account.dart';
import 'package:app_social/routes/navigation_service.dart';
import 'package:app_social/routes/routes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthencationProvider extends ChangeNotifier {
  late UserApp user;
  late final FirebaseFirestore db;
  late final FirebaseAuth auth;
  late final NavigationService navigationService;
  AuthencationProvider() {
    db = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
    navigationService = GetIt.instance.get<NavigationService>();

    // ignore: no_leading_underscores_for_local_identifiers
    auth.authStateChanges().listen((_user) async {
      if (_user != null) {
        DocumentSnapshot snapshot =
            await db.collection('users').doc(_user.uid).get();
        user = UserApp.fromJson(snapshot.data() as Map<String, dynamic>);
        navigationService.goPage(Routes.homePage);
      }
    });
  }

  Future<String> forgotPassword(String email) async {
    String result = '';
    try {
      await auth.sendPasswordResetEmail(email: email);
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> signInWithGoogle() async {
    String result = 'success';
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        // update : phai kiem tra xem nguoi dung dang nhap vao app lan nao chua ??
        UserApp userapp = UserApp(
          uid: userCredential.user!.uid,
          displayname: userCredential.user!.displayName ?? "",
          email: userCredential.user!.email ?? "",
          photoURL: userCredential.user!.photoURL ?? "",
          online: DateTime.now(),
        );
        db.collection('users').doc(userapp.uid).set(userapp.toJson());
      }
    } catch (e) {
      // ignore: avoid_print
      result = e.toString();
    }
    return result;

    // Once signed in, return the UserCredential
  }

  Future<String> signInWithFacebook() async {
    String result = 'success';
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['public_profile']);

      // // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final userCredential =
          await auth.signInWithCredential(facebookAuthCredential);
      UserApp userapp = UserApp(
        uid: userCredential.user!.uid,
        displayname: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? "",
        photoURL: userCredential.user!.photoURL ?? "",
        online: DateTime.now(),
      );
      db.collection('users').doc(userapp.uid).set(userapp.toJson());
    } catch (e) {
      // ignore: avoid_print
      result = e.toString();
    }
    return result;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    navigationService.goToPageAndRemoveAllRoutes(const LoginPageAccount());
  }
}
