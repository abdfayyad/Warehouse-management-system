import 'package:flutter/material.dart';

import 'bloc/status.dart';


class DetailsInvoice extends StatelessWidget {
   DetailsInvoice({super.key, required this.purchases});
  final Purchases? purchases;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${purchases!.clientName} ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'money amount :${purchases!.totalAmount}\$',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    'number of products :${purchases!.quantity}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    'date pay :${purchases!.orderDate}',
                    style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0), // Adjust the radius as needed
                  ),
                ),
                width: double.infinity,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing:
                      10.0, // Spacing between columns
                      mainAxisSpacing:
                      10.0, // Spacing between rows
                      childAspectRatio:
                      2 / 2.3, // Aspect ratio for each item
                    ),
                    itemCount: purchases!.products!.length, // Total number of items
                    itemBuilder:
                        (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                  Radius.circular(15.0),
                                  topRight:
                                  Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  '${purchases!.products![index].productImage}',
                                  // Replace with your image asset
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  '${purchases!.products![index].productName}',
                                  style:const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  '\$${purchases!.products![index].productPrice}.00',
                                  style:const TextStyle(
                                    color:
                                    Colors.deepPurple,
                                    fontSize: 16.0,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Course'),
          content: Text('Are you sure you want to delete this course?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Dismiss the dialog and return false
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Dismiss the dialog and return true
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        // If confirmed is true, proceed with deletion
        // Add your delete logic here
      }
    });
  }
}
