import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harvest_delivery/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Added for date formatting
import 'package:image/image.dart' as img;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/harvest.dart';

class AddItem extends StatefulWidget {
  AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  late File _image = File('');

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController pickedDateTextController = TextEditingController();
  DateTime? harvestedDate;

  clearText() {
    nameController.clear();
    priceController.clear();
    quantityController.clear();
    unitController.clear();
    pickedDateTextController.clear();
    setState(() {
      _image = File('');
    });
  }

  bool isValidImage(File file) {
    try {
      img.decodeImage(file.readAsBytesSync());
      return true;
    } catch (e) {
      print('Invalid image file: $e');
      return false;
    }
  }

  Future<void> addItem() async {
    String imageUrl = '';

    if (_image.path.isNotEmpty && isValidImage(_image)) {
    String imageName = DateTime.now().toString() + '.jpg';

    Reference storageReference =
        FirebaseStorage.instance.ref().child('item_images').child(imageName);
    UploadTask uploadTask = storageReference.putFile(_image);
    
    await uploadTask.whenComplete(() async {
      imageUrl = await storageReference.getDownloadURL();
      });
    }
 
    Harvest harvest = Harvest(
      produceId: "",
      name: nameController.text,
      price: double.parse(priceController.text),
      quantity: int.parse(quantityController.text),
      unit: unitController.text,
      harvestedDate: harvestedDate ??
      DateTime.now(), // Use current date if harvestedDate is null
      image: imageUrl,
      farmerId: FirebaseAuth.instance.currentUser!.uid, 
    );
    

    await FirebaseFirestore.instance
        .collection('MarketProducts')
        .add({
          //'ProduceId': harvest.produceId,
          'Name': harvest.name,
          'Price': harvest.price,
          'StockQuantity': harvest.quantity,
          'Unit': harvest.unit,
          'HarvestedDate': harvest.harvestedDate,
          'ImageUrl': harvest.image,
          'FarmerId': harvest.farmerId, 
        })
        .then((value) => print('Item Added'))
        .catchError((error) => print('Failed to Add item: $error'));
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text("Add New Item", style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
        
        backgroundColor: MyApp.primaryColor ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: pickImage,
                  child: _image.path.isNotEmpty
                      ? Image.file(
                          _image,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Click to add image',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 500));
                    RenderObject? object =
                        globalKey.currentContext?.findRenderObject();
                    object?.showOnScreen();
                  },
                  decoration: InputDecoration(
                    labelText: 'Unit',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(),
                  ),
                  controller: unitController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Unit';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Unit Price',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(),
                  ),
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Unit Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(),
                  ),
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                
                TextFormField(
                  readOnly: true,
                  controller: pickedDateTextController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: harvestedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != harvestedDate) {
                      harvestedDate = pickedDate;
                      pickedDateTextController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Harvested Date',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  children: [
                    ElevatedButton(
                      //key: globalKey,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addItem();
                          //clearText();
                          Navigator.pop(context);
                          //Navigator.of(context).popUntil((route) => route.isFirst);
                          //Navigator.of(context).pushNamedAndRemoveUntil('/item-tab-route', (route) => false);
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        backgroundColor: MyApp.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                        height: 12.0), // Adjust the spacing between buttons
                    ElevatedButton(
                      key: globalKey,
                      onPressed: clearText,
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        backgroundColor: MyApp.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
