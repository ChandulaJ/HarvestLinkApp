import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../components/empty_cart_tile.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  bool cartIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Your Cart",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 30.0),
              textAlign: TextAlign.left,
            ),

            // if the cart is empty
            EmptyCart()
          ],
        ),
      ),
    );
  }
}
