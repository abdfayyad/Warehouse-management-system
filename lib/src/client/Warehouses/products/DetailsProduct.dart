import 'package:flutter/material.dart';

import 'package:ware_house_project/src/client/Warehouses/bloc/status.dart';



class DetailsProduct extends StatelessWidget {
   DetailsProduct({super.key, required this.products});
  final Products products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Add to Cart'),
        icon: const Icon(Icons.shopping_cart),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Product image
            ClipRRect(
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
                'Product name: ${products.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),

            // Product description
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  'description: ${products.description}'),
            ),

            // Product price
             Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'price : \$${products.price}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'quantity: ${products.quantity}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
