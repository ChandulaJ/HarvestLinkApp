import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harvest_delivery/main.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String selectedStatus = 'Pending';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: MyApp.primaryColor,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Orders').doc(orderId).get(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final orderData = snapshot.data!.data() as Map<String, dynamic>;

            Future<Map<String, dynamic>> getCustomerDetails() async {
              try {
                DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
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

            double calculateTotalAmount() {
              double totalAmount = 0.0;
              for (var item in items) {
                totalAmount +=
                    (item['Quantity'] as int) * (item['UnitPrice'] as double);
              }
              return totalAmount;
            }

            DateTime orderDateTime = (orderData['DateTime'] as Timestamp).toDate();
            String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(orderDateTime);

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
                            _buildDetailRow(Icons.person, 'Customer Name:', customerName),
                            _buildDetailRow(Icons.location_on, 'Customer Address:', customerAddress),
                            _buildDetailRow(Icons.phone, 'Customer Phone:', customerPhone),
                            SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
                    Divider(),

                    _buildDetailRow(Icons.date_range, 'Order Date and Time:', formattedDateTime),
                    _buildDetailRow(Icons.category, 'Order Status:', orderData['Status'] ?? 'N/A'),
                    Divider(),
                    SizedBox(height: 4),
                    SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16, // Adjust the spacing between columns as needed
                      columns: [
                        DataColumn(label: Text('Product', style: TextStyle(fontSize: 15))),
                        DataColumn(label: Text('Qty', style: TextStyle(fontSize: 15))),
                        DataColumn(label: Text('Unit Price (Rs.)', style: TextStyle(fontSize: 15))),
                        DataColumn(label: Text('Amount (Rs.)', style: TextStyle(fontSize: 15))),
                      ],
                      rows: items.map<DataRow>((item) {
                        String productId = item['ProductId'] as String;

                        // Fetch product details from MarketProducts collection
                        Future<Map<String, dynamic>> getProductDetails() async {
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

                        return DataRow(
                          cells: [
                            DataCell(
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: getProductDetails(),
                                  builder: (context, productSnapshot) {
                                    String productName = productSnapshot.data?['Name'] ?? 'N/A';
                                    String unit = productSnapshot.data?['Unit'] ?? 'N/A';

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productName,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          '($unit)',
                                          style: TextStyle(fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${item['Quantity']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: getProductDetails(),
                                  builder: (context, productSnapshot) {
                                    double unitPrice = productSnapshot.data?['Price'] ?? 0.0;

                                    return Text(
                                      '${unitPrice.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 15),
                                    );
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${((item['Quantity'] as int) * (item['UnitPrice'] as double)).toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                    SizedBox(height: 20),
                    Text(
                      'Total Amount: \Rs. ${calculateTotalAmount().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
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
