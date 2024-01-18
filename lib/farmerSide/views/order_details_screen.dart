import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

Widget _buildDetailRow(IconData icon, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 12),
            Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 243, 159, 33),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Orders').doc(orderId).get(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final orderData = snapshot.data!.data() as Map<String, dynamic>;

            // Fetch customer details from Customers collection
            Future<Map<String, dynamic>> getCustomerDetails() async {
              try {
                DocumentSnapshot customerSnapshot =
                    await FirebaseFirestore.instance
                        .collection('Customers')
                        .doc(orderData['CustomerId'])
                        .get();
                return customerSnapshot.data() as Map<String, dynamic>;
              } catch (e) {
                print('Error fetching customer details: $e');
                return {};
              }
            }

            final items = orderData['Items'] as List<dynamic>;

            // Function to calculate the total amount
            double calculateTotalAmount() {
              double totalAmount = 0.0;
              for (var item in items) {
                totalAmount +=
                    (item['Quantity'] as int) * (item['UnitPrice'] as double);
              }
              return totalAmount;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                   FutureBuilder<Map<String, dynamic>>(
  future: getCustomerDetails(),
  builder: (context, customerSnapshot) {
    String customerName = customerSnapshot.data?['Name'] ?? 'N/A';
    String customerAddress = customerSnapshot.data?['Address'] ?? 'N/A';
    String customerPhone = customerSnapshot.data?['Phone number'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(Icons.person,  customerName),
        _buildDetailRow(Icons.location_on, customerAddress),
        _buildDetailRow(Icons.phone, customerPhone),
        SizedBox(height: 12),
      ],
    );
  },
),
                    Divider(),
                    
                    SizedBox(height: 4),
                    // Display a bill-like structure
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Product', style: TextStyle(fontSize: 15))),
                        DataColumn(label: Text('Quantity', style: TextStyle(fontSize: 15))),
                        DataColumn(label: Text('Amount', style: TextStyle(fontSize: 15))),
                      ],
                      rows: items.map<DataRow>((item) {
                        String productId = item['ProductId'] as String;

                        // Fetch product details from MarketProducts collection
                        Future<Map<String, dynamic>> getProductDetails() async {
                          try {
                            DocumentSnapshot productSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('MarketProducts')
                                    .doc(productId)
                                    .get();
                            return productSnapshot.data() as Map<String, dynamic>;
                          } catch (e) {
                            print('Error fetching product details: $e');
                            return {};
                          }
                        }

                        return DataRow(
                          cells: [
                            DataCell(
                              FutureBuilder<Map<String, dynamic>>(
                                future: getProductDetails(),
                                builder: (context, productSnapshot) {
                                  String productName =
                                      productSnapshot.data?['Name'] ?? 'N/A';
                                  return Text(
                                    productName,
                                    style: TextStyle(fontSize: 14),
                                  );
                                },
                              ),
                            ),
                            DataCell(
                              Text(
                                '${item['Quantity']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                '\Rs. ${(item['Quantity'] as int) * (item['UnitPrice'] as double)}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Total Amount: \Rs. ${calculateTotalAmount().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic for accepting the order
                        // For example, you can update the order status in Firestore
                        // or navigate to a new screen
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 243, 159, 33),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            print('Error in FutureBuilder: $e');
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
