import 'package:flutter/material.dart';


Widget myTextField({
  required TextEditingController controller,
  double height = 46,
  double width = double.infinity,
  bool obscureText = false,
  String validatorValue = "",
  String labelText = "",
  String hintText = "",
  Widget? suffixIcon,
  TextInputType? keyboardType,
  Icon? prefixIcon,
  ValueChanged<String>? onFieldSubmitted,

  double radios =5,
  ValueChanged<String>?onChanged

}) =>
    SizedBox(
        height: height,
        width: width,

        child: TextFormField(
          //  style: TextStyle(),
            controller: controller,

            onChanged: onChanged,
            keyboardType: keyboardType,
            onFieldSubmitted: onFieldSubmitted,
            validator: (value) {
              if (value!.isEmpty) {
                return validatorValue;
              }
              return null;
            },
            style: TextStyle(color: Colors.black),
            obscureText: obscureText,
            decoration: InputDecoration(
                filled: true,

                labelText: labelText,
                labelStyle:  TextStyle(color:Colors.blue),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radios),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue
                    )
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffixIconColor:Colors.blue,
                prefixIconColor: Colors.blue,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.blue),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black,)
                )
            )
        )
    );