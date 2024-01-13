import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePageTile extends StatelessWidget {
final String img;
final String productName;
final double price;




  const HomePageTile(
      {super.key, required this.img, required this.productName, required this.price, });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),border: Border.all(color:Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage(img))
            ),
          ),
          const SizedBox(height: 20.0,),
          Text(productName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rs. '+ price.toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              Row(
                children: [

                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined)),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
}
