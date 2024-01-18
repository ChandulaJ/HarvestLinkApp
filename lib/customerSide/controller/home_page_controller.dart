import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/customerSide/data/repositories/market_products_repository.dart';

import 'cart_page_controller.dart';
import '../models/product_data_model.dart';

class HomePageController extends GetxController {
    final MarketProductsRepository _repository = MarketProductsRepository();
  late BuildContext context;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CartPageController cartController = Get.put(CartPageController());
  late BuildContext homecontext;
  static HomePageController instance =
      Get.find<HomePageController>(); // Add this line

  final RxList<ProductDataModel> marketItems = <ProductDataModel>[].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxString searchValue = ''.obs;

    Future<void> fetchData() async {
      try {
        print("fetching data");
        List<ProductDataModel> fetchedItems =
        await _repository.fetchMarketItems();
        marketItems.assignAll(fetchedItems);
      } catch (e) {
        print("Error fetching market items: $e");
      }
    }


    void cartAddBtnPressed(int index, double qty) {

      ProductDataModel productToAdd = marketItems[index];
      productToAdd = productToAdd.copyWith(quantity: qty);
      cartController.cartItems.add(productToAdd);

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
