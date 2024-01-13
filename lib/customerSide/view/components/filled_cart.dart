import 'package:flutter/cupertino.dart';
import 'package:harvest_delivery/customerSide/controller/cart_page_controller.dart';
import 'package:harvest_delivery/customerSide/view/components/cart_tile.dart';

import '../../models/product_data_model.dart';

class FilledCart extends StatelessWidget {
  const FilledCart({super.key});

  @override
  Widget build(BuildContext context) {
   // return
            //CartTile(price: 10.0,productName: "cucumber",img: "lib/customerSide/view/images/cucumber.jpg",);
    List<ProductDataModel> inCartProducts =
    CartPageController() as List<ProductDataModel>;
    return ListView.builder(
      itemCount: inCartProducts.length,
      itemBuilder: (context, index) {
        ProductDataModel productCart = inCartProducts[index];

        return CartTile(
          img: productCart.imageUrl,
          productName: productCart.name,
          price: productCart.price,
        );
      },

    );


  }
}
