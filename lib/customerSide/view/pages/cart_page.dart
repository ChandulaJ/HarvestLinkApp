import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/customerSide/view/components/cart_tile.dart';
import 'package:harvest_delivery/customerSide/controller/cart_page_controller.dart';

import '../../models/product_data_model.dart';
import '../components/empty_cart.dart';
import '../components/filled_cart.dart';

class CartPage extends StatelessWidget {
  final CartPageController cartController = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Your Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.left,
              ),
              Obx(() {
                List<ProductDataModel> cartItems = cartController.getCartItems();
      
                return cartItems.isEmpty
                    ? EmptyCart()
                    : FilledCart(cartItems: cartItems);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
