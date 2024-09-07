import 'package:http/http.dart' as http;
import 'package:ware_house_project/utils/shared_prefirance.dart';

class ProductService {
  final String baseUrl;

  ProductService({required this.baseUrl});

  Future<void> addProduct({
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String company,
    required DateTime productionDate,
    required DateTime expirationDate,
    required String imagePath,
    required int inventoryId,
  }) async {
    final url = Uri.parse(baseUrl);
    final request = http.MultipartRequest('POST', url);
    // Set headers
    request.headers['Authorization'] = 'Bearer ${SharedPref.getData(key: 'token')}';
    request.headers['Accept'] = 'application/json';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['quantity'] = quantity.toString();
    request.fields['company'] = company;
    request.fields['expire_date'] = expirationDate.toIso8601String();
    request.fields['inventory_id'] = inventoryId.toString();

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('product_image', imagePath));
    }

    final response = await request.send();
if(response.statusCode==200){
  print(response);
}
    if (response.statusCode != 201) {
      // final String responseBody = await response.stream.bytesToString();
      // throw Exception(' Status Code: ${response.statusCode}, Response: $responseBody');
    }

  }
}
