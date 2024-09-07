abstract class ShoppingCartsStatus {}
class ShoppingCartsInitialized extends ShoppingCartsStatus{}
class ShoppingCartsSuccess extends ShoppingCartsStatus{
  ShoppingCartsModel shoppingCartsModel;

  ShoppingCartsSuccess(this.shoppingCartsModel);
}
class ShoppingCartsError extends ShoppingCartsStatus{}
class ShoppingCartsLoading extends ShoppingCartsStatus{}

class ChangeValueIndex extends ShoppingCartsStatus{}
class ShoppingCartsModel {
  Data? data;

  ShoppingCartsModel({this.data});

  ShoppingCartsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? clientName;
  int? itemCount;
  List<Products>? products;
  int? totalPrice;

  Data(
      {this.id,
        this.clientName,
        this.itemCount,
        this.products,
        this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
    itemCount = json['item_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_name'] = this.clientName;
    data['item_count'] = this.itemCount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? quantity;
  String? company;
  String? image;
  String? expireDate;

  Products(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.quantity,
        this.company,
        this.image,
        this.expireDate});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    company = json['company'];
    image = json['image'];
    expireDate = json['expire_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['company'] = this.company;
    data['image'] = this.image;
    data['expire_date'] = this.expireDate;
    return data;
  }
}