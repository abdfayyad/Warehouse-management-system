import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Purchases/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class PurchasesClientCubit extends Cubit<PurchasesClientStatus>{
  PurchasesClientCubit():super(PurchasesInitializedStatus());
late PurchasesModel purchasesModel;
  Future<PurchasesModel?> getPurchases() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/client/invoices'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      purchasesModel= PurchasesModel.fromJson(parsedJson);

      emit(PurchasesSuccessStatus(purchasesModel));
    }else {
      print(response.body);
      print("certificate field");
      emit(PurchasesErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}