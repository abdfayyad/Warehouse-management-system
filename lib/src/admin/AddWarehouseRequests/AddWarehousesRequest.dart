import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/admin/AddWarehouseRequests/bloc/cubit.dart';
import 'package:ware_house_project/src/admin/AddWarehouseRequests/bloc/status.dart';
import 'package:http/http.dart' as http;
import 'package:ware_house_project/src/both/splash_screen.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'dart:convert';

import '../../../utils/shared_prefirance.dart';

class AddWareHousesRequests extends StatelessWidget {
   AddWareHousesRequests({super.key});
   AddWarehouseRequestModel ?addWarehouseRequestModel;
// Replace these with your actual API endpoints
   String apiBaseUrl = 'https://api.example.com';

// Function to accept a warehouse request
  Future<void> acceptRequest(String requestId,BuildContext context) async {
    final url = Uri.parse('$BASE_URL/api/admin/accept_request/$requestId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Add your authorization token if needed
        },
      );

      if (response.statusCode == 200) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AddWareHousesRequests()), (Route<dynamic> route) => false);

        print('Request accepted successfully');
      } else {
        print('Failed to accept request: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error accepting request: $e');
    }
  }




// Inside your AddWareHousesRequests class:

  void _showConfirmationDialog(BuildContext context, String action, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action Request'),
          content: Text('Are you sure you want to $action this request?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddWareHousesRequestsAdminCubit()..getWarehouses(),
      child: BlocConsumer<AddWareHousesRequestsAdminCubit, AddWareHouseRequestsAdminStatus>(
        listener: (context, state) {
          if(state is AddWareHouseRequestsAdminSuccessStatus)
            addWarehouseRequestModel=state.addWarehouseRequestModel;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Warehouse Requests'),
              actions: [
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
            body:addWarehouseRequestModel!=null? ListView.builder(
              itemCount: addWarehouseRequestModel!.requests!.length, // Replace with actual item count from the state
              itemBuilder: (context, index) {
                // Assuming you have the requestId from the state
                final requestId = '${addWarehouseRequestModel!.requests![index].id}'; // Replace with actual request ID

                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.network(
                          "${addWarehouseRequestModel!.requests![index].image}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${addWarehouseRequestModel!.requests![index].inventoryName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Custodian: ${addWarehouseRequestModel!.requests![index].ownerName}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Address: ${addWarehouseRequestModel!.requests![index].address}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Breadth:${addWarehouseRequestModel!.requests![index].capacity}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () {
                                _showConfirmationDialog(context, 'Approve', () {
                                  acceptRequest(requestId,context);
                                });
                              },
                              child: Text('Approve', style: TextStyle(color: Colors.white)),
                            ),
                            // SizedBox(width: 10),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            //   onPressed: () {
                            //     _showConfirmationDialog(context, 'Reject', () {
                            //       rejectRequest(requestId);
                            //     });
                            //   },
                            //   child: Text('Reject', style: TextStyle(color: Colors.white)),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ):Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }

}
