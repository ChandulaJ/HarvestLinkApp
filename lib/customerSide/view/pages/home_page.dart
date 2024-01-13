import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_page_controller.dart';
import '../../models/product_data_model.dart';
import '../components/homepage_tile.dart';

class HomePage extends StatelessWidget {
  final HomePageController homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    homePageController.setContext(context);
    return Obx(() {
      String searchValue = homePageController.searchValue.toString();
      List<ProductDataModel> filteredProducts =
      homePageController.getFilteredProducts(searchValue);

      return ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          ProductDataModel product = filteredProducts[index];

          return HomePageTile(
            img: product.imageUrl,
            productName: product.name,
            price: product.price,
            product_index: index,
          );
        },
      );
    });
  }
}
