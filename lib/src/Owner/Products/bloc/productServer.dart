//
// import 'package:http/http.dart' as http;
// import 'package:ware_house_project/utils/shared_prefirance.dart';
//
// class ProductService {
//   final String baseUrl;
//
//   ProductService({required this.baseUrl});
//
//   Future<void> addProduct({
//     required String name,
//     required double price,
//     required int quantity,
//     required DateTime productionDate,
//     required DateTime expirationDate,
//     required String imagePath,
//   }) async {
//     final url = Uri.parse(baseUrl,);
//     final request = http.MultipartRequest('POST', url);
//     // Set headers
//     request.headers['Authorization'] = 'Bearer ${SharedPref.getData(key: 'token')}';
//     request.headers['Accept'] = 'application/json';
//     request.fields['name'] = name;
//     request.fields['price'] = price.toString();
//     request.fields['quantity'] = quantity.toString();
//     request.fields['company'] = "Microsoft";
//     request.fields['production_date'] = productionDate.toIso8601String();
//     request.fields['expiration_date'] = expirationDate.toIso8601String();
//
//     if (imagePath.isNotEmpty) {
//       request.files.add(await http.MultipartFile.fromPath('image', imagePath));
//     }
//
//     final response = await request.send();
//
//     if (response.statusCode != 201) {
//       throw Exception('Failed to add product');
//     }
//   }
// }
