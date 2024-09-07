import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';

import 'package:ware_house_project/src/Owner/Products/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class ProductDetailsScreen extends StatelessWidget {
 // Add a productId field to identify the product

  ProductDetailsScreen({super.key, required this.products});
final Products products;
  Future<void> deleteProduct(BuildContext context) async {
    final url = '$BASE_URL/api/owner/products/${products.id}';

    try {
      print('DELETE URL: $url'); // Debug: Print URL for verification

      final response = await http.delete(Uri.parse(url),headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      });

      print('DELETE RESPONSE CODE: ${response.statusCode}'); // Debug: Print response code

      if (response.statusCode == 200) {
        print(response.body); // Debug: Print response body

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product deleted successfully')),
        );


      } else {
        throw Exception('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('DELETE ERROR: $error'); // Debug: Print error for debugging

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $error')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(color: Colors.deepPurple)),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${products.image}', // Replace with your image asset
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            // Product title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                '${products.name}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.deepPurple),
              ),
            ),
            // Product description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${products.description}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            // Product price
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '\$${products.price}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple),
              ),
            ),
            // Product size options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                'quantity :${products.quantity}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            // Product color options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                'Company: ${products.company}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            // Product availability
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                'Expire Date:  ${products.expireDate}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
