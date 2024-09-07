import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Warehouses/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class WarehouseCubit extends Cubit<WarehouseStatus>{
  WarehouseCubit():super(WarehouseInitialized());
late WarehouseModel warehouseModel;
  Future<WarehouseModel?> getWarehouses() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/owner/inventories'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print(" details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      warehouseModel= WarehouseModel.fromJson(parsedJson);

      emit(WarehouseSuccess(warehouseModel!));
    }else {
      print("certificate field");
      emit(WarehouseError());
      throw Exception('Failed to load profile data');
    }
  }
}