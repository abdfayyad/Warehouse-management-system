import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/AddWarehouseRequests/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/AddWarehouseRequests/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;
class AddWareHouseRequests extends StatelessWidget {
  AddWarehouseModel ?addWarehouseModel;
   AddWareHouseRequests({super.key});
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
  Future<void> rejectRequest(String requestId) async {
    final url = Uri.parse('$BASE_URL/warehouse_requests/$requestId/reject');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Add your authorization token if needed
        },
      );

      if (response.statusCode == 200) {
        print('Request rejected successfully');
      } else {
        print('Failed to reject request: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error rejecting request: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>AddWareHouseRequestsCubit()..getWarhouse(),
    child: BlocConsumer<AddWareHouseRequestsCubit,AddWareHouseRequestsStatus>(
      listener: (context,state){
        if(state is AddWareHouseRequestsSuccess)
          addWarehouseModel=state.addWarehouseModel;
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('Add warehouse requests'),
          ),
          body:addWarehouseModel!=null? ListView.builder(
            itemCount: addWarehouseModel!.pendingInventories?.length, // Replace with actual item count from the state
            itemBuilder: (context, index) {
              // Assuming you have the requestId from the state
              final requestId ="${addWarehouseModel!.pendingInventories![index].id}"; // Replace with actual request ID

              return Card(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.network(
                        "${addWarehouseModel!.pendingInventories![index].image}",
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
                                "${addWarehouseModel!.pendingInventories![index].name}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${addWarehouseModel!.pendingInventories![index].name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${addWarehouseModel!.pendingInventories![index].address}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Breadth:"${addWarehouseModel!.pendingInventories![index].capacity}"',
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
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                              _showConfirmationDialog(context, 'Cancel', () {
                                rejectRequest(requestId);
                              });
                            },
                            child: Text('Reject', style: TextStyle(color: Colors.white)),
                          ),
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
