import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harvest_delivery/customerSide/models/product_data_model.dart';


class MarketRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductDataModel>> fetchMarketItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('market_items').get();

      List<ProductDataModel> marketItems = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        ProductDataModel product = ProductDataModel(
          id: document.id,
          name: document['Name'],
          price: document['Price'].toDouble(),
          imageUrl: document['Image'],
          unit: document['Unit'],
        );

        marketItems.add(product);
      }

      return marketItems;
    } catch (e) {
      print("Error fetching market items: $e");
      return [];
    }
  }
}
