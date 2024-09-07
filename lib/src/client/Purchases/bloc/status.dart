abstract class PurchasesClientStatus{}
class PurchasesInitializedStatus extends PurchasesClientStatus{}
class PurchasesLoadingStatus extends PurchasesClientStatus{}
class PurchasesSuccessStatus extends PurchasesClientStatus{

  PurchasesModel purchasesModel;

  PurchasesSuccessStatus(this.purchasesModel);
}
class PurchasesErrorStatus extends PurchasesClientStatus{}


class PurchasesModel {
  List<Invoices>? invoices;

  PurchasesModel({this.invoices});

  PurchasesModel.fromJson(Map<String, dynamic> json) {
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoices {
  int? invoiceId;
  String? invoiceDate;
  String? clientName;
  Null? dueDate;
  Null? status;
  int? totalAmount;
  int? numberOfProducts;
  List<Items>? items;

  Invoices(
      {this.invoiceId,
        this.invoiceDate,
        this.clientName,
        this.dueDate,
        this.status,
        this.totalAmount,
        this.numberOfProducts,
        this.items});

  Invoices.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    clientName = json['client_name'];
    dueDate = json['due_date'];
    status = json['status'];
    totalAmount = json['total_amount'];
    numberOfProducts = json['number_of_products'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['invoice_date'] = this.invoiceDate;
    data['client_name'] = this.clientName;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['total_amount'] = this.totalAmount;
    data['number_of_products'] = this.numberOfProducts;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? productId;
  String? productName;
  String? productDescription;
  int? productPrice;
  int? productQuantity;
  String? productCompany;
  String? productExpireDate;
  String? productImage;
  int? quantity;

  Items(
      {this.productId,
        this.productName,
        this.productDescription,
        this.productPrice,
        this.productQuantity,
        this.productCompany,
        this.productExpireDate,
        this.productImage,
        this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productQuantity = json['product_quantity'];
    productCompany = json['product_company'];
    productExpireDate = json['product_expire_date'];
    productImage = json['product_image'];
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
    return data;
  }
}