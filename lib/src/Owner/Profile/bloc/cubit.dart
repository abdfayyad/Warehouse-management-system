import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'dart:convert';
import 'status.dart';

class ProfileOwnerCubit extends Cubit<ProfileOwnerStatus> {
  ProfileOwnerCubit() : super(ProfileInitializedStatus());

  Future<void> showProfileDetails() async {
    emit(ProfileLoadingStatus());

    try {
      final response = await http.get(Uri.parse('$BASE_URL/api/owner/profile'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
          }
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);
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
      final response = await http.post(
        Uri.parse('$BASE_URL/api/owner/profile/edit'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode({'name': newName, 'phone_number': newPhone, 'email': newEmail}),
      );

      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(ProfileChangeStatus());
      } else {
        // Handle different status codes and print error details
        print('Error: ${response.statusCode} - ${response.body}');
        emit(ProfileErrorStatus());
      }
    } catch (error) {
      print('Exception caught: $error');
      emit(ProfileErrorStatus());
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(ProfileLoadingStatus());
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/owner/profile/change_password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode({'old_password': oldPassword, 'new_password': newPassword}),
      );
      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        emit(ProfileChangeStatus());
      } else {
        emit(ProfileErrorStatus());
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      emit(ProfileErrorStatus());
    }
  }
}
