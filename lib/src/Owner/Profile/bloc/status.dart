abstract class ProfileOwnerStatus {}

class ProfileInitializedStatus extends ProfileOwnerStatus {}

class ProfileLoadingStatus extends ProfileOwnerStatus {}
class ProfileChangeStatus extends ProfileOwnerStatus {}

class ProfileSuccessStatus extends ProfileOwnerStatus {
 final Profile profile;

 ProfileSuccessStatus({required this.profile});
}

class ProfileErrorStatus extends ProfileOwnerStatus {}
class Profile {
 String? name;
 String? email;
 String? phoneNumber;
 String? photo;

 Profile({this.name, this.email, this.phoneNumber, this.photo});

 Profile.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  email = json['email'];
  phoneNumber = json['phone_number'];
  photo = json['photo'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['email'] = this.email;
  data['phone_number'] = this.phoneNumber;
  data['photo'] = this.photo;
  return data;
 }
}
