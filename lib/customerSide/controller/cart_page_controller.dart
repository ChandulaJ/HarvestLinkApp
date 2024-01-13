import 'package:get/get.dart';

import '../models/product_data_model.dart';

class CartPageController {
  final CartPageController cartController = Get.put(CartPageController());

  final RxList<ProductDataModel> cartItems = <ProductDataModel>[].obs;
}
