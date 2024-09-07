import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ware_house_project/src/Owner/Home/home_page.dart';
import 'dart:convert';

import 'package:ware_house_project/utils/end_point.dart';
import 'package:ware_house_project/utils/shared_prefirance.dart';

class AddWarehouse extends StatefulWidget {
  const AddWarehouse({Key? key}) : super(key: key);

  @override
  _AddWarehouseState createState() => _AddWarehouseState();
}

class _AddWarehouseState extends State<AddWarehouse> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Warehouse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Warehouse Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Capacity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imageFile == null
                      ? const Center(child: Text('Pick an Image'))
                      : Image.file(_imageFile!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed:  _saveWarehouse,

                  child: const Text('Save Warehouse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWarehouse() async {
    final name = _nameController.text;
    final capacity = _capacityController.text;
    final address = _addressController.text;

    if (name.isEmpty || capacity.isEmpty || address.isEmpty || _imageFile == null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    final request = http.MultipartRequest('POST', Uri.parse('$BASE_URL/api/owner/inventories/add_inventory'),);
    request.fields['name'] = name;
    request.fields['capacity'] = capacity;
    request.fields['address'] = address;
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    });
    final response = await request.send();

    if (response.statusCode == 200) {
      // Successfully saved, navigate back to warehouses list
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePageAdmin()),  (Route<dynamic> route) => false,);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save warehouse')),
      );
    }
  }
}
