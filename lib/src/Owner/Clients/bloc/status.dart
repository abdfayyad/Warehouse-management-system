abstract class ClientsStatus {}
class ClientsInitialized extends ClientsStatus{}
class ClientsSuccess extends ClientsStatus{
  ClientsInOwnerModel clientsInOwnerModel;

  ClientsSuccess(this.clientsInOwnerModel);
}
class ClientsError extends ClientsStatus{}
class ClientsLoading extends ClientsStatus{}


class ClientsInOwnerModel {
  List<Clients>? clients;

  ClientsInOwnerModel({this.clients});

  ClientsInOwnerModel.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clients {
  int? id;
  String? name;
  String? email;
  String? phone;

  Clients({this.id, this.name, this.email, this.phone});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}