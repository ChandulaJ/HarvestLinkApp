import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MarketProductsRepository {
  static MarketProductsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


}