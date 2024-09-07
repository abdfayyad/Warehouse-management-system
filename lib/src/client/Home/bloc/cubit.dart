

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/client/Purchases/Purchases_client.dart';
import 'package:ware_house_project/src/client/Home/bloc/status.dart';
import 'package:ware_house_project/src/client/Profile/profileScreen.dart';
import 'package:ware_house_project/src/client/Warehouses/WarehousesClient.dart';
import 'package:ware_house_project/src/client/shoppingCarts/ShoppingCarts.dart';



class HomePageCubit extends Cubit<HomePageStatus>{
HomePageCubit():super(InitializedHomePageStatus());
static HomePageCubit get(context)=>BlocProvider.of(context);
int currentIndex = 0;

List<Widget> screen = [
  WarehousesClient(),
  ShoppingCarts(),
  PurchasesClient(),
  ProfileClient(),
];

void changeIndex(int index) {

  currentIndex = index;

  emit(HomeChangeBottomNavBarState());
}
}