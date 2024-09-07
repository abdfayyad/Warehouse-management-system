
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Profile/bloc/status.dart';
import 'package:http/http.dart'as http;
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
class ProfileClientCubit extends Cubit<ProfileClientStatus>{
  ProfileClientCubit():super(ProfileInitializedStatus());

  Future<void> showProfileDetails() async {
    emit(ProfileLoadingStatus());
    print("llllllllllllllllllllll");
    try {
      final response = await http.get(Uri.parse('$BASE_URL/api/client/profile'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',}
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        print("sssssssssssssssssss");
        // Assuming you have a Profile model
        emit(ProfileSuccessStatus(profile: Profile.fromJson(data)));
      } else {
        emit(ProfileErrorStatus());
      }
    } catch (error) {
      emit(ProfileErrorStatus());
    }
  }

  Future<void> editProfile(String newName, String newPhone, String newEmail) async {
    emit(ProfileLoadingStatus());
    try {
      final response = await http.put(
        Uri.parse('$BASE_URL/api/client/profile/edit'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode({'name': newName, 'phone_number': newPhone, 'email': newEmail}),
      );
      if (response.statusCode == 200) {
        emit(ProfileChangeStatus());
      } else {
        emit(ProfileErrorStatus());
      }
    } catch (error) {
      emit(ProfileErrorStatus());
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(ProfileLoadingStatus());
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/client/profile/change_password'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',

        },
        body: jsonEncode({'old_password': oldPassword, 'new_password': newPassword}),
      );
      if (response.statusCode == 200) {
        emit(ProfileChangeStatus());
      } else {
        emit(ProfileErrorStatus());
      }
    } catch (error) {
      emit(ProfileErrorStatus());
    }
  }
}