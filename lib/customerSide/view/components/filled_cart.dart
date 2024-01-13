import 'package:flutter/material.dart';
import 'package:harvest_delivery/customerSide/controller/cart_page_controller.dart';
import 'package:harvest_delivery/customerSide/models/product_data_model.dart';
import 'cart_tile.dart';

class FilledCart extends StatelessWidget {
  final List<ProductDataModel> cartItems;

  FilledCart({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            ),
          );
        },
      ),
    );
  }
}
