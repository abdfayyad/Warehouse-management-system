

import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:http/http.dart' as http;
import 'package:ware_house_project/src/both/Signup/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
class SignInCubit extends Cubit<SignInScreenStates> {
  String? errorState;
  SignInCubit() : super(SignInInitialState());
  static SignInCubit get(context) => BlocProvider.of(context);
  late SignINModel signINModel;

  Future<void> userRegister(String email, String password, String name,
      String phone_number, String role, String? accountNumber, File? image) async {
    emit(SignInLoadingState());

    try {
      // Create a multipart request
      final uri = Uri.parse('$BASE_URL/api/register');
      final request = http.MultipartRequest('POST', uri);

      // Add text fields to the request
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['phone_number'] = phone_number;
      request.fields['role'] = role;

      // Add optional account number if provided
      if (accountNumber != null && accountNumber.isNotEmpty) {
        request.fields['card_number'] = accountNumber;
      }

      // Add image file to the request if provided
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      // Send the request and await the response
      final response = await request.send();

      if (response.statusCode == 200) {
        // Parse the response
        final responseData = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseData);
        print(jsonResponse);

        signINModel = SignINModel.fromJson(jsonResponse);
        emit(SignInSuccessState(signINModel));
      } else {
        // Unsuccessful registration
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = json.decode(responseData);
        final errorMessage = jsonResponse['message'] as String;
        print(errorMessage);
        emit(SignInErrorState());
      }
    } catch (e) {
      // Error occurred

      print(e);
      emit(SignInErrorState());
    }
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow ? Icons.visibility : Icons.visibility_off;
    emit(SignInChangePasswordVisibilityState());
  }
}