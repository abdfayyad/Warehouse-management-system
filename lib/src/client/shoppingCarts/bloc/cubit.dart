import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/shoppingCarts/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart' as http;

class ShoppingCartsCubit extends Cubit<ShoppingCartsStatus> {
  ShoppingCartsCubit() : super(ShoppingCartsInitialized());

  late ShoppingCartsModel shoppingCartsModel;

  Future<void> getCart() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    };

    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/client/carts/my-items'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Cart details fetched successfully");
        final parsedJson = jsonDecode(response.body);
        shoppingCartsModel = ShoppingCartsModel.fromJson(parsedJson);
        emit(ShoppingCartsSuccess(shoppingCartsModel));
      } else {
        print("Failed to fetch cart details: ${response.statusCode}");
        emit(ShoppingCartsError());
      }
    } catch (e) {
      print("Error fetching cart details: $e");
      emit(ShoppingCartsError());
    }
  }
}
