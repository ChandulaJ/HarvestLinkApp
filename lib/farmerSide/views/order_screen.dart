import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harvest_delivery/views/order_details_screen.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: Container(
        color: Color.fromARGB(255, 242, 242, 242),
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
          builder: (context, snapshot) {
            try {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final orders = snapshot.data!.docs;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  try {
                    final orderData =
                        orders[index].data() as Map<String, dynamic>;
                    return OrderCard(
                        orderData: orderData, id: orders[index].id);
                  } catch (e) {
                    print('Error building OrderCard: $e');
                    return SizedBox.shrink();
                  }
                },
              );
            } catch (e) {
              print('Error in StreamBuilder: $e');
              return Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.orderData, required this.id})
      : super(key: key);

  final Map<String, dynamic> orderData;
  final id;

  Future<Map<String, dynamic>> getCustomerDetails(String customerId) async {
    try {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(customerId)
          .get();
      return customerSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching customer details: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('MarketProducts')
          .doc(productId)
          .get();
      return productSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching product details: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder<Map<String, dynamic>>(
          future: getCustomerDetails(orderData['CustomerId']),
          builder: (context, snapshot) {
            String customerName = snapshot.data?['Name'] ?? 'N/A';

            // Format the timestamp
            DateTime orderDateTime =
                (orderData['DateTime'] as Timestamp).toDate();
            String formattedDateTime =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(orderDateTime);

            return Card(
              surfaceTintColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   'Order #${orderData['orderId']}', // Display order number
                        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        // ),
                        Text(
                          '$customerName', // Display customer name
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[800]),
                        ),
                        Text(
                          'Total: \Rs. ${orderData['TotalAmount']}', // Display order total
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      'Date and Time: $formattedDateTime',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),

                    SizedBox(height: 8),
                    //Text('Items:', style: TextStyle(fontSize: 16)),
                    //SizedBox(height: 4),
                    // Display only the first 2 items
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orderData['Items'].length > 2
                          ? 2
                          : orderData['Items'].length, // Limit to 2 items

                      itemBuilder: (context, index) {
                        try {
                          final item = orderData['Items'][index];
                          return FutureBuilder<Map<String, dynamic>>(
                            future: getProductDetails(item['ProductId']),
                            builder: (context, productSnapshot) {
                              String productName =
                                  productSnapshot.data?['Name'] ?? 'N/A';

                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$productName'),
                                    Text('x${item['Quantity']}'),
                                  ],
                                ),
                              );
                            },
                          );
                        } catch (e) {
                          print('Error building ListTile: $e');
                          return SizedBox
                              .shrink(); // Return an empty widget if there's an error
                        }
                      },
                    ),
                    //SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailsScreen(orderId: id),
                              ),
                            );
                          },
                          child: Text('View Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print('Error building OrderCard: $e');
      return SizedBox.shrink(); // Return an empty widget if there's an error
    }
  }
}
