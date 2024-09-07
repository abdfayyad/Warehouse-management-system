import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Home/home_page.dart';
import 'package:ware_house_project/src/Owner/Warehouses/bloc/status.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/status.dart';
import 'package:http/http.dart'as http;
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({super.key, required this.products, required this.id});
final Products products;
final int id ;
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

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePageAdmin()),
              (route) => false,
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
    return BlocProvider(create: (context)=>ProductsCubit(),
      child: BlocConsumer<ProductsCubit,ProductsStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Details'),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.deepPurple),
                  onPressed: () {
                    deleteProduct(context); // Call deleteProduct function
                  },
                ),
              ],
            ),

            body:Padding(
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
        },
      ),
    );
  }
}
