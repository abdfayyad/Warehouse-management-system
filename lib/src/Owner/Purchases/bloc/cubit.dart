import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Purchases/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';

import '../../../../utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class PurchasesCubit extends Cubit<PurchasesStatus>{
  PurchasesCubit():super(PurchasesInitialized());
  PurchasesModel ?purchasesModel;
  Future<PurchasesModel?> getPurchases() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/owner/purchases'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      purchasesModel= PurchasesModel.fromJson(parsedJson);

      emit(PurchasesSuccess(purchasesModel!));
    }else {
      print("certificate field");
      emit(PurchasesError());
      throw Exception('Failed to load profile data');
    }
  }
}