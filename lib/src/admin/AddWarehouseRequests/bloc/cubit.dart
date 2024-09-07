import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/AddWarehouseRequests/bloc/status.dart';
import 'package:ware_house_project/src/admin/AddWarehouseRequests/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class AddWareHousesRequestsAdminCubit extends Cubit<AddWareHouseRequestsAdminStatus>{
  AddWareHousesRequestsAdminCubit():super(AddWareHouseRequestsAdminInitializedStatus() );
late AddWarehouseRequestModel addWarehouseRequestModel;
  Future<AddWarehouseRequestModel?> getWarehouses() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(
        Uri.parse('$BASE_URL/api/admin/show_requests'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      addWarehouseRequestModel= AddWarehouseRequestModel.fromJson(parsedJson);

      emit(AddWareHouseRequestsAdminSuccessStatus(addWarehouseRequestModel));
    }else {
      print(response.body);
      print("certificate field");
      emit(AddWareHouseRequestsAdminErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}