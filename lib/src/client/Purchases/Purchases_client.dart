
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Purchases/bloc/cubit.dart';
import 'package:ware_house_project/src/client/Purchases/bloc/status.dart';
import 'package:ware_house_project/src/client/Purchases/invoiceDetails.dart';

class PurchasesClient extends StatelessWidget {
   PurchasesClient({super.key});
PurchasesModel? purchasesModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PurchasesClientCubit()..getPurchases(),
      child: BlocConsumer<PurchasesClientCubit, PurchasesClientStatus>(
        listener: (context, state) {
          if(state is PurchasesSuccessStatus)
            purchasesModel=state.purchasesModel;
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8.0),
              child:purchasesModel!=null? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 8 / 2, // Aspect ratio for each item
                ),
                itemCount: purchasesModel!.invoices!.length, // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsInvoice(invoices: purchasesModel!.invoices![index],)));
                    },
                    child: Container(
                      height: 100, // Increased height
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
                            ),
                            child: Image.asset(
                              'assets/image/b.png',
                              width: 90,
                              height: double.infinity, // Ensures the image fits the container height
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${purchasesModel!.invoices![index].clientName}',
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'money amount  \$${purchasesModel!.invoices![index].totalAmount}.00',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    'number of products:${purchasesModel!.invoices![index].numberOfProducts} ',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    '${purchasesModel!.invoices![index].invoiceDate}',
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
                    )

                  );
                },
              ):Container(),
            ),
          );
        },
      ),
    );
  }
}
