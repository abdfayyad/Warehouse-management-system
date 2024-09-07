import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Warehouses/products/Products.dart';
import 'package:ware_house_project/src/client/Warehouses/bloc/cubit.dart';
import 'package:ware_house_project/src/client/Warehouses/bloc/status.dart';
import 'package:ware_house_project/utils/color.dart';

class WarehousesClient extends StatefulWidget {
  const WarehousesClient({super.key});

  @override
  _WarehousesClientState createState() => _WarehousesClientState();
}

class _WarehousesClientState extends State<WarehousesClient> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _warehouses = List.generate(5, (index) => 'Warehouse ${index + 1}'); // Dummy data
  List<String> ?_filteredWarehouses;

  @override
  void initState() {
    super.initState();
    _filteredWarehouses = _warehouses;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
WarehouseModel? warehouseModel;
  void _onSearchChanged() {
    setState(() {
      _filteredWarehouses = _warehouses
          .where((warehouse) =>
          warehouse.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WarehouseClientCubit()..getWarehouses(),
      child: BlocConsumer<WarehouseClientCubit, WarehouseClientStatus>(
        listener: (context, state) {
          if(state is WarehouseSuccess) {
            warehouseModel=state.warehouseModel;
          }
        },
        builder: (context, state) {
          return Scaffold(

            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: state is  WarehouseSuccess

                      ? ListView.builder(
                    itemCount: warehouseModel!.inventories?.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsScreenClient(products: warehouseModel!.inventories![index].products,)));

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
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: mainColor
                                                ,overflow: TextOverflow.ellipsis

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
                                            ,overflow: TextOverflow.ellipsis

                                        ),
                                      ),
                                      Text(
                                        'Capacity: ${warehouseModel!.inventories![index].capacity}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: mainColor
                                            ,overflow: TextOverflow.ellipsis

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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
