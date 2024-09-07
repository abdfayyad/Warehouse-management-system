
//                icons: const [Icons.dashboard_outlined,Icons.shopping_cart_outlined, Icons.warehouse_outlined, Icons.credit_card, Icons.person],
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/AddWarehouseRequests/add_warehouse_request.dart';

import 'package:ware_house_project/src/Owner/Home/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Home/bloc/status.dart';
import 'package:ware_house_project/utils/color.dart';


class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin>  {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageCubit(),
        child: BlocConsumer<HomePageCubit, HomePageStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Warehouse",style: TextStyle(color: Colors.deepPurple),),
                actions: [
                  IconButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWareHouseRequests()));
                    },
                    icon: Icon(
                      Icons.schedule_send_outlined,color: Colors.deepPurple,
                    ),
                  )
                ],
              ),
              body: HomePageCubit.get(context)
                  .screen[HomePageCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: HomePageCubit.get(context).currentIndex,
                onTap: (index) {
                  HomePageCubit.get(context).changeIndex(index);
                },
                unselectedItemColor: mainColor,
                selectedItemColor: Colors.deepPurple,

                unselectedFontSize: 14,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined, size: 30),
                    label: 'products',
                    //backgroundColor: Colors.red
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined, size: 30),
                    label: 'purchases',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.warehouse_outlined,
                      size: 30,
                    ),
                    label: 'warehouses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card, size: 30),
                    label: 'client',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 30),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
