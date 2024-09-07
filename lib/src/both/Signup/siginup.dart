import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';  // Import the image_picker package
import 'dart:io';

import 'package:ware_house_project/src/Owner/Home/home_page.dart';
import 'package:ware_house_project/src/both/Login/login.dart';
import 'package:ware_house_project/src/both/Signup/bloc/cubit.dart';
import 'package:ware_house_project/src/both/Signup/bloc/status.dart';
import 'package:ware_house_project/src/client/Home/home_page.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class sign_up extends StatefulWidget {
  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  var formKey = GlobalKey<FormState>();
  bool isClient = false; // Boolean to track role selection
  bool showPass = true;

  // Image Picker
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userFirstNameController = TextEditingController();
    TextEditingController userLastNameController = TextEditingController();
    TextEditingController userAddressController = TextEditingController();
    TextEditingController emailAddressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController accountNumberController = TextEditingController(); // Controller for account number

    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInScreenStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            SharedPref.saveData(key: 'token', value: state.signINModel.token)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            SharedPref.saveData(key: 'role', value: state.signINModel.role)
                .then((value) {
              print(SharedPref.getData(key: 'role'));
            });
            if (state.signINModel.role == 'owner') {
              Flushbar(
                  titleText: Text("Hello Owner",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.yellow[600],
                          fontFamily: "ShadowsIntoLightTwo")),
                  messageText: Text("Welcome to our application",
                      style: TextStyle(fontSize: 16.0, color: Colors.green)),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePageAdmin()));
            } else if (state.signINModel.role == 'client') {
              Flushbar(
                  titleText: Text("Hello Client",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.yellow[600],
                          fontFamily: "ShadowsIntoLightTwo")),
                  messageText: Text("Welcome to our application",
                      style: TextStyle(fontSize: 16.0, color: Colors.green)),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageClient()),
                      (Route<dynamic> route) => false);
            } else {
              Flushbar(
                  titleText: Text("Welcome to our application",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.yellow[600],
                          fontFamily: "ShadowsIntoLightTwo")),
                  messageText: Text(
                      "If you are an admin or super admin you can login from the web application",
                      style: TextStyle(fontSize: 16.0, color: Colors.green)),
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8))
                  .show(context);
            }
          }
          if (state is SignInErrorState) {
            Flushbar(
                titleText: Text("Error Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.deepPurple,
                        fontFamily: "ShadowsIntoLightTwo")),
                messageText: Text("Error in your email or password",
                    style: TextStyle(fontSize: 16.0, color: Colors.deepPurple)),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8))
                .show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SignUp'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : AssetImage('assets/image/mm.jpg') as ImageProvider,
                            child: _image == null
                                ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: userFirstNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User First Name Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'User First Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User First Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: userLastNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User Last Name Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'User Last Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User Last Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: userAddressController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User Address Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'User Address',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Phone Number Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                                hintText: 'Enter Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: emailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Enter Email Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          obscureText: SignInCubit.get(context).isPasswordShow,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SignInCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(SignInCubit.get(context).suffix),
                              ),
                              hintText: 'Enter Your Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CheckboxListTile(
                          title: Text("Register as Client"),
                          value: isClient,
                          onChanged: (newValue) {
                            setState(() {
                              isClient = newValue!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // Show the account number field only if isOwner is true
                        if (isClient)
                          TextFormField(
                              controller: accountNumberController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Account Number Please';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Account Number',
                                  prefixIcon: Icon(
                                    Icons.account_balance,
                                  ),
                                  hintText: 'Enter Account Number',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 30.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String role = isClient ? 'client' : 'owner';

                              // Calling the userRegister method with correct parameters
                              SignInCubit.get(context).userRegister(
                                emailAddressController.text,
                                passwordController.text,
                                userFirstNameController.text + ' ' + userLastNameController.text,
                                phoneNumberController.text,
                                role,
                                isClient ? accountNumberController.text : null, // Pass the account number if the user is an owner
                                _image, // Pass the selected image
                              );
                              print(emailAddressController.text+
                                passwordController.text+
                                userFirstNameController.text + ' ' + userLastNameController.text+
                                phoneNumberController.text+
                                role,);
                            }
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            height: 40.0,
                            width: 100.0,
                            child: Center(
                                child: Text('SIGN_UP', style: TextStyle())),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.red,
                                ),
                                onPressed: () {}),
                            const SizedBox(
                              width: 30.0,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {}),
                            const SizedBox(
                              width: 30.0,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
