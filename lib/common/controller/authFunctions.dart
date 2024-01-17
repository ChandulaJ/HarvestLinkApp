import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/common/views/pages/signin_page.dart';
import 'package:harvest_delivery/common/views/pages/signup_page.dart';
import 'package:harvest_delivery/customerSide/view/pages/main_page.dart';
import 'package:lottie/lottie.dart';

import 'firebaseFunctions.dart';


class AuthServices {
  static signupCustomer(

      String email, String password, String name, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: Lottie.asset("lib/customerSide/view/images/loading_animation.json"));
      },
    );
    print("In signup customer function");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveCustomer(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
      //TODO: add check to go to farmer signin too
      Navigator.of(context).pop();
      Get.to(CustomerMainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
      Navigator.of(context).pop();
      Get.to(SignUpPage());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      Navigator.of(context).pop();
      Get.to(SignUpPage());
    }

  }


  static signupFarmer(

      String email, String password, String name, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: Lottie.asset("lib/customerSide/view/images/loading_animation.json"));
      },
    );
    print("In signup farmer function");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveFarmer(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
      //TODO: add check to go to farmer signin too
      Navigator.of(context).pop();
      Get.to(CustomerMainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
      Navigator.of(context).pop();
      Get.to(SignUpPage());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      Navigator.of(context).pop();
      Get.to(SignUpPage());
    }

  }


  static signinCustomer(String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: Lottie.asset("lib/customerSide/view/images/loading_animation.json"));

      },
    );
    print("In signin customer function");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
      //TODO: add check to go to farmer signin too
      Navigator.of(context).pop();
      Get.to(CustomerMainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));

      }
      Navigator.of(context).pop();
      Get.to(SignInPage());
    }

  }


  static signinFarmer(String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: Lottie.asset("lib/customerSide/view/images/loading_animation.json"));

      },
    );
    print("In signin farmer function");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
      //TODO: add check to go to farmer signin too
      Navigator.of(context).pop();
      Get.to(CustomerMainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));

      }
      Navigator.of(context).pop();
      Get.to(SignInPage());
    }

  }
}