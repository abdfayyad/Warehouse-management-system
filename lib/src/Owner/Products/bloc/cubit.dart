import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Products/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class ProductsCubit extends Cubit<ShowProductStatus>{
  ProductsCubit():super(ShowProductInitialized());
  ProductsModel ?productsModel;
  Future<ProductsModel?> getProducts() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/owner/products/allProducts'),headers: headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      productsModel= ProductsModel.fromJson(parsedJson);
      emit(ShowProductSuccess(productsModel!));
    }else {
      print("certificate field");
      emit(ShowProductError());
      throw Exception('Failed to load profile data');
    }
  }
}