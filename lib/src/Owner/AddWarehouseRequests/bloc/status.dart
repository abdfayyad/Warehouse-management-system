abstract class AddWareHouseRequestsStatus {}
class AddWareHouseRequestsInitialized extends AddWareHouseRequestsStatus{}
class AddWareHouseRequestsSuccess extends AddWareHouseRequestsStatus{
  AddWarehouseModel addWarehouseModel;

  AddWareHouseRequestsSuccess(this.addWarehouseModel);
}
class AddWareHouseRequestsError extends AddWareHouseRequestsStatus{}
class AddWareHouseRequestsLoading extends AddWareHouseRequestsStatus{}


class AddWarehouseModel {
  List<PendingInventories>? pendingInventories;

  AddWarehouseModel({this.pendingInventories});

  AddWarehouseModel.fromJson(Map<String, dynamic> json) {
    if (json['pending inventories'] != null) {
      pendingInventories = <PendingInventories>[];
      json['pending inventories'].forEach((v) {
        pendingInventories!.add(new PendingInventories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingInventories != null) {
      data['pending inventories'] =
          this.pendingInventories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingInventories {
  int? id;
  String? name;
  String? address;
  int? capacity;
  String? image;
  String? status;
  int? ownerId;
  String? createdAt;
  String? updatedAt;

  PendingInventories(
      {this.id,
        this.name,
        this.address,
        this.capacity,
        this.image,
        this.status,
        this.ownerId,
        this.createdAt,
        this.updatedAt});

  PendingInventories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    capacity = json['capacity'];
    image = json['image'];
    status = json['status'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['capacity'] = this.capacity;
    data['image'] = this.image;
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}