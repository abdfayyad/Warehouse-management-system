abstract class ShowProductStatus {}
class ShowProductInitialized extends ShowProductStatus{}
class ShowProductSuccess extends ShowProductStatus{
  ProductsModel productsModel;

  ShowProductSuccess(this.productsModel);
}
class ShowProductError extends ShowProductStatus{}
class ShowProductLoading extends ShowProductStatus{}

class ProductsModel {
  List<Products>? products;

  ProductsModel({this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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




