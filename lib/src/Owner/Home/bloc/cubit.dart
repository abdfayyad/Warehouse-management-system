

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Clients/clients.dart';
import 'package:ware_house_project/src/Owner/Home/bloc/status.dart';

import 'package:ware_house_project/src/Owner/Products/showProduct.dart';
import 'package:ware_house_project/src/Owner/Profile/profileScreen.dart';
import 'package:ware_house_project/src/Owner/Purchases/purchases.dart';
import 'package:ware_house_project/src/Owner/Warehouses/Warehouses.dart';



class HomePageCubit extends Cubit<HomePageStatus>{
HomePageCubit():super(InitializedHomePageStatus());
static HomePageCubit get(context)=>BlocProvider.of(context);
int currentIndex = 2;

List<Widget> screen = [
  ProductsOwner(),
  Purchases(),
  WarehousesOwner(),
  ClientsOwner(),
  ProfileOwner(),

];

void changeIndex(int index) {

  currentIndex = index;

  emit(HomeChangeBottomNavBarState());
}
}