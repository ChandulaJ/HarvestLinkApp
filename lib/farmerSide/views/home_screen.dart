import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addData() async {
  try {
    // Reference to the collection
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Items');

    // Data to be added
    Map<String, dynamic> data = {
      'Id': '1',
      'Name': 'aaa',
      // Add more fields as needed
    };

    // Add the document with an automatically generated ID
    await collectionReference.add(data);

    print('Document added successfully!');
  } catch (e) {
    print('Error adding document: $e');
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Screen'),
          SizedBox(height: 20), // Add some spacing between text and button
          ElevatedButton(
            onPressed: () {
              addData();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
