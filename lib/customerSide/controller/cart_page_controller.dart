import 'package:get/get.dart';

import '../models/product_data_model.dart';

class CartPageController {
  final RxList<ProductDataModel> cartItems = <ProductDataModel>[
   ].obs;
  final RxInt selectedTabIndex = 0.obs;

  List<ProductDataModel> getCartItems() {
    return cartItems;
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
