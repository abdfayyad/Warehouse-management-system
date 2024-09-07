import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Clients/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Clients/bloc/status.dart';
import 'package:http/http.dart' as http;
import 'package:ware_house_project/utils/end_point.dart';
import 'dart:convert';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class ClientsOwner extends StatelessWidget {
  ClientsOwner({super.key});

  ClientsInOwnerModel? clientsInOwnerModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ClientsCubit()..getClients(),
      child: BlocConsumer<ClientsCubit, ClientsStatus>(
        listener: (context, state) {
          if (state is ClientsSuccess) {
            clientsInOwnerModel = state.clientsInOwnerModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ListView.builder(
              itemCount: clientsInOwnerModel?.clients?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: Offset(0, 0.1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/image/d.jpg"),
                      ),
                      title: Text("${clientsInOwnerModel!.clients![index].name}"),
                      subtitle: Text("${clientsInOwnerModel!.clients![index].email}"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final TextEditingController moneyController = TextEditingController();
                            return AlertDialog(
                              title: Text('Client Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Name: ${clientsInOwnerModel!.clients![index].name}'),
                                  Text('Email: ${clientsInOwnerModel!.clients![index].email}'),
                                  Text('Phone: ${clientsInOwnerModel!.clients![index].phone}'),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: moneyController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final amount = moneyController.text;
                                    final clientId = clientsInOwnerModel!.clients![index].id;
                                    chargeMoney(context, "$clientId", amount);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Charge Money'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> chargeMoney(BuildContext context, String clientId, String amount) async {
    final url = Uri.parse('$BASE_URL/api/owner/clients/$clientId/charge_card'); // Replace with your API endpoint
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
        body: jsonEncode(<String, String>{
          'money': amount,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Money charged successfully')),
        );
        print('Money charged successfully');
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to charge money: ${response.statusCode}')),
        );
        print('Failed to charge money: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to charge money: $error')),
      );
      print('Exception caught: $error');
    }
  }
}
