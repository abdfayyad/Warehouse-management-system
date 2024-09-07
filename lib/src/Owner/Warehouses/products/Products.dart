import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Home/home_page.dart';
import 'package:ware_house_project/src/Owner/Warehouses/bloc/status.dart';

import 'package:ware_house_project/src/Owner/Warehouses/products/DetailsProduct.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/addProduct.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';

import 'package:http/http.dart'as http;
import 'package:ware_house_project/utils/shared_prefirance.dart';
class ProductsScreen extends StatelessWidget {
   ProductsScreen({super.key, required this.products, required this.id});
 final List<Products>? products;
 final int  ?id;
   Future<void> deleteProduct(BuildContext context,String id) async {
     final url = '$BASE_URL/api/owner/products/$id';

     try {
       print('DELETE URL: $url'); // Debug: Print URL for verification

       final response = await http.delete(Uri.parse(url),headers: {
         'Accept': 'application/json',
         'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
       });

       print('DELETE RESPONSE CODE: ${response.statusCode}'); // Debug: Print response code

       if (response.statusCode == 200) {
         print(response.body); // Debug: Print response body
         Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(builder: (context) => HomePageAdmin()),
               (Route<dynamic> route) => false,
         );
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
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: BlocConsumer<ProductsCubit, ProductsStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Warehouse 1",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
              ),
              elevation: 2,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddProductScreen(id!)));
              },
              backgroundColor: Colors.blue[600],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 2 / 2.3, // Aspect ratio for each item
                ),
                itemCount: products?.length??0, // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsProduct(products: products![index],id: id!,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              '${products![index].image}', // Replace with your image asset
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '${products![index].name}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${products![index].price}',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero, backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      deleteProduct(context,"${products![index].id}" );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
