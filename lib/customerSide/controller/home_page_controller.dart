import 'package:get/get.dart';
import 'cart_page_controller.dart';
import '../models/product_data_model.dart';

class HomePageController extends GetxController {
  final CartPageController cartController = Get.put(CartPageController());

  final RxList<ProductDataModel> marketItems = <ProductDataModel>[
    ProductDataModel(
        id: "001", name: "Grapes", price: 50.0, imageUrl: "lib/customerSide/view/images/grapes.jpg"),
    ProductDataModel(
        id: "002", name: "Carrots", price: 60.0, imageUrl: "lib/customerSide/view/images/carrot.jpg"),
    ProductDataModel(
        id: "003", name: "Cucumber", price: 70.0, imageUrl: "lib/customerSide/view/images/cucumber.jpg"),
    ProductDataModel(
        id: "004", name: "Lettuce", price: 80.0, imageUrl: "lib/customerSide/view/images/lettuce.jpg"),
    ProductDataModel(
        id: "005", name: "Onions", price: 90.0, imageUrl: "lib/customerSide/view/images/onions.jpg"),
    ProductDataModel(
        id: "006", name: "Tomato", price: 100.0, imageUrl: "lib/customerSide/view/images/tomato.jpeg"),
  ].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxString searchValue = ''.obs;

  void cartAddBtnPressed(int index) {
    cartController.cartItems.add(marketItems[index]);
  }

  List<String> getMarketItemNames() {
    return marketItems.map((item) => item.name).toList();
  }

  List<ProductDataModel> getFilteredProducts(String searchValue) {
    if (searchValue.isEmpty) {
      return marketItems;
    } else {
      return marketItems
          .where((product) => product.name.toLowerCase().contains(searchValue.toLowerCase()))
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
}
