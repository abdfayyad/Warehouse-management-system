
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Warehouses/AddWarehous.dart';
import 'package:ware_house_project/src/Owner/Warehouses/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Warehouses/bloc/status.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/Products.dart';
import 'package:ware_house_project/utils/color.dart';

class WarehousesOwner extends StatelessWidget {
   WarehousesOwner({super.key});
WarehouseModel ?warehouseModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>WarehouseCubit()..getWarehouses(),
        child: BlocConsumer<WarehouseCubit,WarehouseStatus>(
          listener: (context,state){
            if(state is WarehouseSuccess)
              warehouseModel=state.warehouseModel;
          },
          builder: (context,state){
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWarehouse()));
                },
                child: Icon(Icons.add),
              ),
              body:state is  WarehouseSuccess
                  ? ListView.builder(
                itemCount: warehouseModel!.inventories?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsScreen(products: warehouseModel!.inventories![index].products,id: warehouseModel!.inventories![index].id,)));

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2,left: 8.0,right: 8.0,bottom: 2),
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      "${warehouseModel!.inventories![index].image}",
                                    )),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${warehouseModel!.inventories![index].name}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor

                                        ),
                                      ),
                                      Text(
                                        '${warehouseModel!.inventories![index].ownerName}',
                                        overflow: TextOverflow.ellipsis,

                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: mainColor
                                            ,overflow: TextOverflow.clip,


                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Address: ${warehouseModel!.inventories![index].address}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: mainColor
                                    ),
                                  ),
                                  Text(
                                    'Capacity: ${warehouseModel!.inventories![index].capacity}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: mainColor

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              )
                  : Center(child: CircularProgressIndicator()),
            );
          },
        ));
  }
}
