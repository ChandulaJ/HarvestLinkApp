import 'package:get/get.dart';

import '../models/product_data_model.dart';

class CartPageController {
  final RxList<ProductDataModel> cartItems = <ProductDataModel>[
    ProductDataModel(
        id: "001",
        name: "Grapes",
        price: 50.0,
        imageUrl: "lib/customerSide/view/images/grapes.jpg"),
    ProductDataModel(
        id: "002",
        name: "Carrots",
        price: 60.0,
        imageUrl: "lib/customerSide/view/images/carrot.jpg"),
    ProductDataModel(
        id: "003",
        name: "Cucumber",
        price: 70.0,
        imageUrl: "lib/customerSide/view/images/cucumber.jpg"),
  ].obs;
  final RxInt selectedTabIndex = 0.obs;

  List<ProductDataModel> getCartItems() {
    return cartItems;
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
