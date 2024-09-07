import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Clients/bloc/status.dart';

import '../../../../utils/end_point.dart';
import '../../../../utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class ClientsCubit extends Cubit<ClientsStatus>{
  ClientsCubit():super(ClientsInitialized());

  ClientsInOwnerModel ?clientsInOwnerModel;
  Future<ClientsInOwnerModel?> getClients() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('${BASE_URL}/api/owner/clients'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      clientsInOwnerModel= ClientsInOwnerModel.fromJson(parsedJson);
      print(clientsInOwnerModel);
      emit(ClientsSuccess(clientsInOwnerModel!));
    }else {
      print("certificate field");
      emit(ClientsError());
      throw Exception('Failed to load profile data');
    }
  }
}