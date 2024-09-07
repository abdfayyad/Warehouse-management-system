
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Purchases/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Purchases/bloc/status.dart';
import 'package:ware_house_project/src/Owner/Purchases/invoice.dart';
class Purchases extends StatelessWidget {
   Purchases({Key ?key});
PurchasesModel? purchasesModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PurchasesCubit()..getPurchases(),
      child: BlocConsumer<PurchasesCubit, PurchasesStatus>(
        listener: (context, state) {
          if(state is PurchasesSuccess) {
            purchasesModel=state.purchasesModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
          
            body: purchasesModel!=null
                ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 8 / 2, // Aspect ratio for each item
              ),
              itemCount: purchasesModel?.purchases!.length, // Total number of items
              itemBuilder: (BuildContext context, int index) {
                var purchase = purchasesModel!.purchases![index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsInvoice(purchases:purchase)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(0.0),
                          ),
                          child: Image.asset(
                            'assets/image/b.png',
                            // Replace with your image asset
                            width: 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${purchasesModel!.purchases![index].clientName}',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                                Text(
                                  'money amount  \$${purchasesModel!.purchases![index].totalAmount}.00',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14.0,

                                  ),
                                ),
                                Text(
                                  'number of products:${purchasesModel!.purchases![index].quantity}  ',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14.0,

                                  ),
                                ),
                                Text(
                                  '${purchasesModel!.purchases![index].orderDate}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
                : CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Course"),
          content: Text("Are you sure you want to delete c++?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Delete"),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
