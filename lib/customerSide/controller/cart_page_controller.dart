import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data/repositories/cart_products_repository.dart';
import '../models/product_data_model.dart';

class CartPageController {
  final CartProductsRepository _cart_repository = CartProductsRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<ProductDataModel> cartItems = <ProductDataModel>[
   ].obs;
  final RxInt selectedTabIndex = 0.obs;

  List<ProductDataModel> getCartItems() {
    return cartItems;
  }
  Future<void> fetchCartData() async {
    try {
      print("fetching cart data");
      List<ProductDataModel> fetchedItems =
      await _cart_repository.fetchCartItems();
      cartItems.assignAll(fetchedItems);
    } catch (e) {
      print("Error fetching cart items: $e");
    }
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
