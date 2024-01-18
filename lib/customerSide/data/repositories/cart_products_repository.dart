import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/customerSide/models/product_data_model.dart';


class CartProductsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<ProductDataModel> cartItems = <ProductDataModel>[].obs;

  Future<List<ProductDataModel>> fetchCartItems() async {
    try {
      print("fetching cart data in repo");
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('CartProducts').get();

      List<ProductDataModel> cartItems = snapshot.docs
          .map((doc) => ProductDataModel.fromMap(doc.data()))
          .toList();

      return cartItems;
    } catch (e) {

      print("Error fetching cart items: $e");
      throw e;
    }
  }


}
