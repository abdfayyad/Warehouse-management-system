abstract class WarehouseClientStatus {}
class WarehouseInitialized extends WarehouseClientStatus{}
class WarehouseSuccess extends WarehouseClientStatus{
  WarehouseModel warehouseModel;

  WarehouseSuccess(this.warehouseModel);
}
class WarehouseError extends WarehouseClientStatus{}
class WarehouseLoading extends WarehouseClientStatus{}
class WarehouseModel {
  List<Inventories>? inventories;

  WarehouseModel({this.inventories});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    if (json['inventories'] != null) {
      inventories = <Inventories>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Inventories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inventories {
  int? id;
  String? name;
  String? image;
  int? capacity;
  String? address;
  String? ownerName;
  List<Products>? products;

  Inventories(
      {this.id,
        this.name,
        this.image,
        this.capacity,
        this.address,
        this.ownerName,
        this.products});

  Inventories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    capacity = json['capacity'];
    address = json['address'];
    ownerName = json['owner_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['address'] = this.address;
    data['owner_name'] = this.ownerName;
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