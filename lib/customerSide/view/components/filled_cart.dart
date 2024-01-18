import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:harvest_delivery/customerSide/controller/cart_page_controller.dart';
import 'package:harvest_delivery/customerSide/models/product_data_model.dart';
import '../pages/checkout_page.dart';
import 'cart_tile.dart';

class FilledCart extends StatelessWidget {
  final List<ProductDataModel> cartItems;

  FilledCart({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              ProductDataModel product = cartItems[index];

              return Padding(
                padding: const EdgeInsets.only(top: 10.0,),
                child: CartTile(
                  img: product.imageUrl,
                  productName: product.name,
                  price: product.price,
                  quantity: product.quantity,
                ),

              );
            },
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(bottom:20.0,top: 10.0),
          child: FilledButton(
            onPressed: () {
              Get.to(CheckoutPage());
            },
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        )
      ],
    );
  }
}
