import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harvest_delivery/customerSide/view/components/product_counter.dart';

import '../../models/product_data_model.dart';
import 'checkout_page.dart';

class MoreDetailsPage extends StatelessWidget {
  final int itemIndex;
  final ProductDataModel product;

  MoreDetailsPage({Key? key, required this.itemIndex, required this.product})
      : super(key: key);

  RxInt buycount = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_circle_left_rounded,
            color: Colors.black,
            size: 40.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(product.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rs. ${product.price} per ${product.unit}',
                  style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45),
                ),
                SizedBox(
                  height: 20.0,
                ),
               
                Obx(
                  () => FilledButton(
                    onPressed: () {
                      // Add the buycount to cart or perform other actions
                      Get.to(CheckoutPage());
                    },
                    child: Text(
                      'Add ${buycount.value} to cart - LKR ${buycount.value * product.price}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
