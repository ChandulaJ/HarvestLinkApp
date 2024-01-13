import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final String img;
  final String productName;
  final double price;

  const CartTile({
    Key? key,
    required this.img,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: 50.0,
                width: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(img),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                    child: Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Rs. ' + price.toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
