import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Products/addProduct.dart';
import 'package:ware_house_project/src/Owner/Products/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Products/bloc/status.dart';
import 'package:ware_house_project/src/Owner/Products/showDetailsProduct.dart';
import 'package:ware_house_project/src/client/Warehouses/products/DetailsProduct.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:http/http.dart'as http;
import 'package:ware_house_project/utils/shared_prefirance.dart';
class ProductsOwner extends StatelessWidget {
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

  ProductsOwner({super.key});
 ProductsModel ?productsModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductsCubit()..getProducts(),
      child: BlocConsumer<ProductsCubit, ShowProductStatus>(
        listener: (context, state) {
          if(state is ShowProductSuccess) {
            productsModel=state.productsModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing:
                  10.0, // Spacing between columns
                  mainAxisSpacing:
                  10.0, // Spacing between rows
                  childAspectRatio:
                  2 / 2.3, // Aspect ratio for each item
                ),
                itemCount: productsModel?.products?.length ?? 0,
                // Total number of items
                itemBuilder:
                    (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(products: productsModel!.products![index],)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft:
                              Radius.circular(15.0),
                              topRight:
                              Radius.circular(15.0),
                            ),
                            child: Image.network(
                                '${productsModel?.products?[index].image}',
                              // Replace with your image asset
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Text(
                              '${productsModel!.products![index].name}',
                              style:const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  '\$${productsModel!.products![index].price}',
                                  style:const TextStyle(
                                    color:
                                    Colors.deepPurple,
                                    fontSize: 16.0,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton
                                        .styleFrom(
                                      padding:
                                      EdgeInsets.zero,
                                      backgroundColor:
                                      Colors.deepPurple,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      deleteProduct(context,"${productsModel!.products![index].id}" );
                                    },
                                    child:const Icon(
                                      Icons
                                          .delete,
                                      size: 20,
                                      color: Colors.white,
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
                },
              ),
            ),

          );
        },
      ),
    );
  }
}


