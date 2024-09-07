abstract class PurchasesStatus {}
class PurchasesInitialized extends PurchasesStatus{}
class PurchasesSuccess extends PurchasesStatus{
  PurchasesModel purchasesModel;

  PurchasesSuccess(this.purchasesModel);
}
class PurchasesError extends PurchasesStatus{}
class PurchasesLoading extends PurchasesStatus{}
class PurchasesModel {
  List<Purchases>? purchases;

  PurchasesModel({this.purchases});

  PurchasesModel.fromJson(Map<String, dynamic> json) {
    if (json['purchases'] != null) {
      purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        purchases!.add(new Purchases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchases != null) {
      data['purchases'] = this.purchases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchases {
  int? purchaseId;
  String? clientName;
  List<Products>? products;
  int? quantity;
  int? totalAmount;
  String? orderDate;

  Purchases(
      {this.purchaseId,
        this.clientName,
        this.products,
        this.quantity,
        this.totalAmount,
        this.orderDate});

  Purchases.fromJson(Map<String, dynamic> json) {
    purchaseId = json['purchase_id'];
    clientName = json['client_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    quantity = json['quantity'];
    totalAmount = json['total_amount'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_id'] = this.purchaseId;
    data['client_name'] = this.clientName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['total_amount'] = this.totalAmount;
    data['order_date'] = this.orderDate;
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  String? productDescription;
  int? productPrice;
  int? productQuantity;
  String? productCompany;
  String? productExpireDate;
  String? productImage;

  Products(
      {this.productId,
        this.productName,
        this.productDescription,
        this.productPrice,
        this.productQuantity,
        this.productCompany,
        this.productExpireDate,
        this.productImage});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productQuantity = json['product_quantity'];
    productCompany = json['product_company'];
    productExpireDate = json['product_expire_date'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_company'] = this.productCompany;
    data['product_expire_date'] = this.productExpireDate;
    data['product_image'] = this.productImage;
    return data;
  }
}