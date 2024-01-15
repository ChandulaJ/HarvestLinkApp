import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/customerSide/view/pages/cart_page.dart';
import 'package:harvest_delivery/customerSide/view/pages/home_page.dart';
import 'cart_page_controller.dart';
import '../models/product_data_model.dart';

class HomePageController extends GetxController {
  final CartPageController cartController = Get.put(CartPageController());
  late BuildContext context;
  static HomePageController instance =
      Get.find<HomePageController>(); // Add this line

  final RxList<ProductDataModel> marketItems = <ProductDataModel>[
    ProductDataModel(
        id: "001",
        name: "Grapes",
        price: 5000.0,
        imageUrl: "lib/customerSide/view/images/grapes.jpg", unit: 'g'),

    ProductDataModel(
        id: "002",
        name: "Carrots",
        price: 60.0,
        imageUrl: "lib/customerSide/view/images/carrot.jpg", unit: 'g'),
    ProductDataModel(
        id: "003",
        name: "Cucumber",
        price: 70.0,
        imageUrl: "lib/customerSide/view/images/cucumber.jpg", unit: 'g'),
    ProductDataModel(
        id: "004",
        name: "Lettuce",
        price: 80.0,
        imageUrl: "lib/customerSide/view/images/lettuce.jpg", unit: 'g'),
    ProductDataModel(
        id: "005",
        name: "Onions",
        price: 90.0,
        imageUrl: "lib/customerSide/view/images/onions.jpg", unit: 'g'),
    ProductDataModel(
        id: "006",
        name: "Tomato",
        price: 100.0,
        imageUrl: "lib/customerSide/view/images/tomato.jpeg", unit: 'g'),
  ].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxString searchValue = ''.obs;

  void cartAddBtnPressed(int index) {
    cartController.cartItems.add(marketItems[index]);
    showSnackBar();
  }

  List<String> getMarketItemNames() {
    return marketItems.map((item) => item.name).toList();
  }

  ProductDataModel getMarketItemByIndex(int index) {
    return marketItems[index];
  }

  List<ProductDataModel> getFilteredProducts(String searchValue) {
    if (searchValue.isEmpty) {
      return marketItems;
    } else {
      return marketItems
          .where((product) =>
              product.name.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    }
  }

  void setSearchValue(String value) {
    if (searchValue.value != value) {
      searchValue.value = value;
    }

    print("The controller value: $searchValue");
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  void setContext(BuildContext context) {
    this.context = context;
    instance = this;
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Durations.medium4,
        content: const Text('Item added to the cart!'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            HomePageController.instance.setSelectedTabIndex(1);
          },
        ),
      ),
    );
  }
}
