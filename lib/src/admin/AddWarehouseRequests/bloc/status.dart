abstract class AddWareHouseRequestsAdminStatus{}
class AddWareHouseRequestsAdminInitializedStatus extends AddWareHouseRequestsAdminStatus{}
class AddWareHouseRequestsAdminLoadingStatus extends AddWareHouseRequestsAdminStatus{}
class AddWareHouseRequestsAdminSuccessStatus extends AddWareHouseRequestsAdminStatus{
  AddWarehouseRequestModel addWarehouseRequestModel;

  AddWareHouseRequestsAdminSuccessStatus(this.addWarehouseRequestModel);
}
class AddWareHouseRequestsAdminErrorStatus extends AddWareHouseRequestsAdminStatus{}

class AddWarehouseRequestModel {
  List<Requests>? requests;

  AddWarehouseRequestModel({this.requests});

  AddWarehouseRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requests {
  int? id;
  String? inventoryName;
  String? ownerName;
  int? capacity;
  String? address;
  String? image;

  Requests(
      {this.id,
        this.inventoryName,
        this.ownerName,
        this.capacity,
        this.address,
        this.image});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inventoryName = json['inventory_name'];
    ownerName = json['owner_name'];
    capacity = json['capacity'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inventory_name'] = this.inventoryName;
    data['owner_name'] = this.ownerName;
    data['capacity'] = this.capacity;
    data['address'] = this.address;
    data['image'] = this.image;
    return data;
  }
}