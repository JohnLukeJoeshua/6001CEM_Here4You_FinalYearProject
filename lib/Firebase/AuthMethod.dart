
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Screen/Dashboard/HomeScreen/HomeScreen.dart';
import '../Screen/Log_in_pages/Loading.dart';
import '../Sharepref/Sharepref.dart';
import '../const/Con_widget.dart';
import '../const/Constant_usermast.dart';
import 'Firestore.dart';

class AuthMethod {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<bool> loginEmailUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      SharedPref.SetDataSharepref(Uid: auth.currentUser!.uid.toString(), name: auth.currentUser!.displayName.toString(), Email: email, Password: password, Login: true);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Homescreen();
        },
      ));
      Con_widget.Tost(BuildContext: context, name: "Login Succecfully");
      return true;
    } on FirebaseAuthException catch (exception) {
      print("dkfnkdfnkfnknf$exception");
      switch (exception.code) {
        case "invalid-email":
          Con_widget.Tost(
              BuildContext: context, name: "Not a valid email address");
          print("Not a valid email address.");
          return false;
          break;
        case "INVALID_LOGIN_CREDENTIALS":
          Con_widget.Tost(BuildContext: context, name: "Invalid Email & Password");
          return false;
          break;
        default:
          print("Unknown error.");
          return false;
      }
    }
  }

  static Future<bool> signUpUser({
    required String email,
    required String name,
    required BuildContext context,
    required String password,
  }) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(cred.user);
      var current_user = auth.currentUser;
      current_user?.updateDisplayName(name);
      SharedPref.SetDataSharepref(
        Uid: current_user!.uid.toString(),
          name: name, Email: email, Password: password, Login: true);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Loading();
        },
      ));
      Con_widget.Tost(BuildContext: context, name: "Login Succecfully");
      return true;
    } on FirebaseAuthException catch (exception) {
      print("$exception");
      switch (exception.code) {
        case "invalid-email":
          Con_widget.Tost(
              BuildContext: context, name: "Not a valid email address");
          return false;
          break;
        default:
          print("Unknown error.");
          return false;
      }
    }
  }

  static Future<bool> SignInGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await user?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential = await auth.signInWithCredential(credential);
      var current_user = auth.currentUser;
      current_user?.updateDisplayName(user?.displayName);
      SharedPref.SetDataSharepref(
        Uid:userCredential.user!.uid.toString(),
          Email: userCredential.user!.email.toString(),
          name: userCredential.user?.displayName.toString(),
          Password: "",
          Login: true);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Loading();
        },
      ));
      Con_widget.Tost(BuildContext: context, name: "Login Succecfully");
      return true;
    } catch (e) {
      print("Googleloginerore==$e");
      return false;
    }
  }

  static Future change_password(
      {required String email,
      required String old,
      required String pass}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: old);
      var current_user = await auth.currentUser;
      await current_user?.updatePassword(pass);
      await SharedPref.save_string(SrdPrefkey.Password, pass);
      SharedPref.SyncUserData();
      return true;
    } catch (e) {
      print("=====Change password======$e");
      return false;
    }
  }

  static Future<bool> ResetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("=================$e");
      return false;
    }
  }

  static Future<bool> changeName({required String name}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: Constants_Usermast.Email,
          password: Constants_Usermast.Password);
      var current_user = await auth.currentUser;
      await current_user?.updateDisplayName(name);
      await SharedPref.save_string(SrdPrefkey.Name, name);
      SharedPref.SyncUserData();
      return true;
    } catch (e) {
      print("=========NameChange========$e");
      return false;
    }
  }
  static Future<void> Delete()async
  {
    await Firestore.deleteAllChart();
    await Firestore.deleteAllFav();
    await Firestore.deleteAllNote();
    await Firestore.deleteAllWellness();
    await Firestore.deleteAllAchievements();
    if(Constants_Usermast.Password.isNotEmpty)
      {
        User? user = FirebaseAuth.instance.currentUser;
        AuthCredential credential = EmailAuthProvider.credential(email: Constants_Usermast.Email, password: Constants_Usermast.Password);
        user?.reauthenticateWithCredential(credential).then((authResult) async {
          await user.delete();
          // Now you can perform the sensitive operation
          // For example, delete the account or change sensitive settings
        }).catchError((error) {
          // Handle re-authentication errors
        });
      }
  }
  static Future<void> deleteAccount() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference userDocument = users.doc(Constants_Usermast.UserId); // Reference to the user's document
    return userDocument.delete().then((_) async {
      await FirebaseAuth.instance.currentUser!.delete();
      print("Document deleted successfully");
    }).catchError((error) {
      print("Error deleting document: $error");
    });
  }

  static Logout() async {
    try {
      await auth.signOut();
      SharedPref.clear();
    } catch (e) {
      print("Log Out Erore====$e");
    }
  }
}
