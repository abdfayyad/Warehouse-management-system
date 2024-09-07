import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ware_house_project/src/Owner/Home/home_page.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/cubit.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/productServer.dart';
import 'package:ware_house_project/src/Owner/Warehouses/products/bloc/status.dart';
import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/textField.dart';

class AddProductScreen extends StatefulWidget {
  final int id;

  AddProductScreen(this.id);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  DateTime? _productionDate;
  DateTime? _expirationDate;
  File? _image;
  final ProductService _productService = ProductService(baseUrl: '$BASE_URL/api/owner/products');

  Future<void> _selectDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (field == 'production') {
          _productionDate = picked;
        } else if (field == 'expiration') {
          _expirationDate = picked;
        }
      });
    }
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  Future<void> _addProduct() async {
    try {
      await _productService.addProduct(
        name: _nameController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        company: _companyController.text,
        productionDate: _productionDate!,
        expirationDate: _expirationDate!,
        imagePath: _image?.path ?? '',
        inventoryId: widget.id,
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePageAdmin()),
            (Route<dynamic> route) => false,
      );    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductsCubit(),
      child: BlocConsumer<ProductsCubit, ProductsStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Product'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _getImage,
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: _image != null
                              ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                              : Icon(
                            Icons.add_photo_alternate,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    myTextField(controller: _nameController, hintText: "Name",labelText: "Name"),
                    SizedBox(height: 20.0),
                    myTextField(controller: _descriptionController, hintText: "Description",labelText: "Description"),
                    SizedBox(height: 20.0),
                    myTextField(controller: _priceController, hintText: "Price",labelText: "Price",keyboardType: TextInputType.number),
                    SizedBox(height: 20.0),
                    myTextField(controller: _quantityController, hintText: "Quantity",labelText: "Quantity",keyboardType: TextInputType.number),
                    SizedBox(height: 20.0),
                    myTextField(controller: _companyController, hintText: "Company",labelText: "Company"),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.blue
                                  )
                              ),
                              hintText: "Production date",
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.black,)
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: _productionDate != null
                                  ? '${_productionDate?.day}/${_productionDate?.month}/${_productionDate?.year}'
                                  : '',
                            ),
                            readOnly: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'production'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.blue
                                  )
                              ),
                              hintText: "Expiration date",
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.black,)
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: _expirationDate != null
                                  ? '${_expirationDate?.day}/${_expirationDate?.month}/${_expirationDate?.year}'
                                  : '',
                            ),
                            readOnly: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'expiration'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _addProduct,
                      child: Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
