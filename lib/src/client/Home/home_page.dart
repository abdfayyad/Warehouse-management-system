//                icons: const [Icons.dashboard_outlined,Icons.shopping_cart_outlined, Icons.warehouse_outlined, Icons.credit_card, Icons.person],
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ware_house_project/src/client/Home/bloc/cubit.dart';
import 'package:ware_house_project/src/client/Home/bloc/status.dart';
import 'package:ware_house_project/utils/color.dart';

class HomePageClient extends StatefulWidget {
  const HomePageClient({super.key});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageCubit(),
        child: BlocConsumer<HomePageCubit, HomePageStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                title: Text("warehouse",style: TextStyle(color: Colors.deepPurple)),

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
                    icon: Icon(Icons.warehouse_outlined, size: 30),
                    label: 'Warehouses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card, size: 30 ),
                    label: ' cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    ),
                    label: 'Purchases',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 30),
                    label: 'profile',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
