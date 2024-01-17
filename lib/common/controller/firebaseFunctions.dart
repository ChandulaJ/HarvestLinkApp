import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveCustomer(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(uid)
        .set({'Email': email, 'Name': name,'Address':'','Phone number':''});
  }
  static saveFarmer(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .set({'Email': email, 'Name': name,'Address':'','Phone number':''});
  }
}