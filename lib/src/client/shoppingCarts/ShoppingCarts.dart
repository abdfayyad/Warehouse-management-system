import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Home/home_page.dart';
import 'package:ware_house_project/src/client/shoppingCarts/bloc/cubit.dart';
import 'package:ware_house_project/src/client/shoppingCarts/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShoppingCarts extends StatelessWidget {
  ShoppingCarts({Key? key}) : super(key: key);

  ShoppingCartsModel? shoppingCartsModel;

  Future<void> acceptRequest(int? id) async {
    final url = Uri.parse('$BASE_URL/warehouse_requests/$id/accept');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
      );

      if (response.statusCode == 200) {
        print('Request accepted successfully');
      } else {
        print('Failed to accept request: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error accepting request: $e');
    }
  }

  Future<void> payCart(BuildContext context) async {
    final url = Uri.parse('$BASE_URL/api/client/carts/items/buy');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
      );

      if (response.statusCode == 200) {
        print('Payment successful');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePageClient()),
              (Route<dynamic> route) => false,
        );
      } else {
        print('Failed to make payment: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error making payment: $e');
    }
  }

  void _showConfirmationDialog(BuildContext context, String action, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action'),
          content: Text('Are you sure you want to $action this request?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCartsCubit()..getCart(),
      child: BlocConsumer<ShoppingCartsCubit, ShoppingCartsStatus>(
        listener: (context, state) {
          if (state is ShoppingCartsSuccess) {
            shoppingCartsModel = state.shoppingCartsModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _showConfirmationDialog(context, 'Pay', () => payCart(context));
                  },
                  backgroundColor: Colors.deepPurple,
                  label: const Text('Pay', style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 2 / 2.3,
                ),
                itemCount: shoppingCartsModel?.data?.products?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = shoppingCartsModel!.data!.products![index];
                  return InkWell(
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
                              product.image ?? '',
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.name ?? '',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${product.price}',
                                  style: const TextStyle(
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
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      _showConfirmationDialog(context, 'Delete', () {
                                        acceptRequest(product.id);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
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
