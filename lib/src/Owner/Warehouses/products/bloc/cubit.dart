import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/status.dart';


class ProductsCubit extends Cubit<ProductsStatus>{
  ProductsCubit():super(ProductsInitialized());
}