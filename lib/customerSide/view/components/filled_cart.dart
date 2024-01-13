import 'package:flutter/cupertino.dart';
import 'package:harvest_delivery/customerSide/view/components/cart_tile.dart';

class FilledCart extends StatelessWidget {
  const FilledCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CartTile(price: 10.0,productName: " vegetablelevege table vegetable  getablevegetable",img: "lib/customerSide/view/images/cucumber.jpg",)

          ],
        )
    );
  }
}
