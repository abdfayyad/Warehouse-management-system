import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Profile/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Profile/bloc/status.dart';
import 'package:ware_house_project/src/both/splash_screen.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class ProfileOwner extends StatelessWidget {
  const ProfileOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileOwnerCubit()..showProfileDetails(),
      child: BlocConsumer<ProfileOwnerCubit, ProfileOwnerStatus>(
        listener: (context, state) {
          if (state is ProfileErrorStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingStatus) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccessStatus) {
            final profile = state.profile;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage('${profile.photo}'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${profile.name}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${profile.phoneNumber}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${profile.email}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showEditProfileDialog(context);
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                _showChangePasswordDialog(context);
                              },
                              icon: Icon(Icons.sync_lock),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            SharedPref.removeData(key: 'token');
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashScreen()), (Route<dynamic> route) => false);

                          },
                          icon: Icon(Icons.logout),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('Error loading profile'));
          }
        },
      ),
    );
  }

  void _showEditProfileDialog(BuildContext parentContext) {
    String? newName;
    String? newPhone;
    String? newEmail;

    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'New Name'),
                onChanged: (value) => newName = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Phone'),
                onChanged: (value) => newPhone = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Email'),
                onChanged: (value) => newEmail = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newName != null && newPhone != null && newEmail != null) {
                  parentContext.read<ProfileOwnerCubit>().editProfile(newName!, newPhone!, newEmail!);
                  print(newName);
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext parentContext) {
    String? oldPassword;
    String? newPassword;

    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                onChanged: (value) => oldPassword = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) => newPassword = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (oldPassword != null && newPassword != null) {
                  parentContext.read<ProfileOwnerCubit>().changePassword(oldPassword!, newPassword!);
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
