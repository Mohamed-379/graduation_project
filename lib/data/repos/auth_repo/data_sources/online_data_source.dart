import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../cache/cache_helper.dart';
import '../../../../models/user_dm.dart';
import '../../../../ui/auth/login/login.dart';
import '../../../../ui/home/home_screen.dart';
import '../../../../ui/utils/dialog_utils.dart';

class OnlineDataSource
{
  void login(BuildContext context, String email, String password) async{
    try{
      //todo: Show loading dialog
      showLoadingDialog(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      UserDM currentUser = await getUserFromFirestore(userCredential.user!.uid);
      UserDM.currentUser = currentUser;
      Stopwatch stopwatch = Stopwatch()..start();
      UserDM.checkDocExist(UserDM.currentUser!);
      CacheHelper.setUserId(UserDM.currentUser!.id);
      CacheHelper.setUserName(UserDM.currentUser!.username);
      CacheHelper.setUserEmail(UserDM.currentUser!.email);
      //todo: Hide loading dialog
      // navigate home screen
      Future.delayed(Duration(seconds: stopwatch.elapsed.inSeconds + 2),(){
        CacheHelper.setUserIsPremium(UserDM.isExist!);
        hideLoadingDialog(context);
        EasyLoading.showToast("Successfully Login", toastPosition: EasyLoadingToastPosition.bottom);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    }on FirebaseAuthException catch(e){
      //todo: Hide loading dialog
      hideLoadingDialog(context);
      //todo: Show Errors dialog
      showErrorsDialog(context, e.message ?? "Something went wrong\nPlease try again later");
    }
  }

  Future<UserDM> getUserFromFirestore(String id) async{
    CollectionReference<UserDM> collectionReference = UserDM.getCollection();
    DocumentSnapshot<UserDM> doc = await collectionReference.doc(id).get();
    return doc.data()!;
  }

  void deleteUserFromFirestore(String userId) async
  {
    CollectionReference collectionReference = UserDM.getCollection();
    await collectionReference.doc(userId).delete();
    // CollectionReference collectionReferenceVIP = UserDM.getVIPCollection();
    // await collectionReferenceVIP.doc(userId).delete();
  }

  void register(BuildContext context, String email , String username, String password) async{
    try{
      //todo: Show loading dialog
      showLoadingDialog(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      UserDM newUser = UserDM(id: userCredential.user!.uid, email: email, username: username);
      await addUserToFirebase(newUser);
      UserDM.currentUser = newUser;
      Stopwatch stopwatch = Stopwatch()..start();
      UserDM.checkDocExist(UserDM.currentUser!);
      CacheHelper.setUserId(UserDM.currentUser!.id);
      CacheHelper.setUserName(UserDM.currentUser!.username);
      CacheHelper.setUserEmail(UserDM.currentUser!.email);
      //todo: Hide loading dialog
      // navigate home screen
      Future.delayed(Duration(seconds: stopwatch.elapsed.inSeconds + 2),(){
        CacheHelper.setUserIsPremium(UserDM.isExist!);
        hideLoadingDialog(context);
        EasyLoading.showToast("The Account Was Created Successfully.", toastPosition: EasyLoadingToastPosition.bottom);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    }on FirebaseAuthException catch(e){
      //todo: Hide loading dialog
      hideLoadingDialog(context);
      //todo: Show Errors dialog
      showErrorsDialog(context, e.message ?? "Something went wrong\nPlease try again later");
    }
  }

  Future addUserToFirebase(UserDM user) async {
    CollectionReference<UserDM> usersCollection = UserDM.getCollection();
    usersCollection.doc(user.id).set(user);
  }

  void deleteUser(BuildContext context) async
  {
    try{
      CollectionReference collectionReference = UserDM.getCollection();
      await collectionReference.doc(CacheHelper.id??UserDM.currentUser!.id).delete();
      await FirebaseAuth.instance.currentUser!.delete();
      CacheHelper.deleteUserId();
      CacheHelper.deleteUserEmail();
      CacheHelper.deleteUserName();
      CacheHelper.deleteUserIsPremium();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      EasyLoading.showToast("Account Deleted Successfully", toastPosition: EasyLoadingToastPosition.bottom);
    }on FirebaseAuthException catch(e){
      EasyLoading.showError(e.message ?? "Something went wrong please try again later.");
    }
  }
}