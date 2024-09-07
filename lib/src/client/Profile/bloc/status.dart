abstract class ProfileClientStatus{}
 class ProfileInitializedStatus extends ProfileClientStatus{}
class ProfileLoadingStatus extends ProfileClientStatus{}
class ProfileChangeStatus extends ProfileClientStatus {}
class ProfileSuccessStatus extends ProfileClientStatus{
 final Profile profile;

 ProfileSuccessStatus({required this.profile});
}
class ProfileErrorStatus extends ProfileClientStatus{}

class Profile {
 String? name;
 String? email;
 String? phoneNumber;
 String? photo;
 int? cardBalance;
 String? cardNumber;

 Profile(
     {this.name,
      this.email,
      this.phoneNumber,
      this.photo,
      this.cardBalance,
      this.cardNumber});

 Profile.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  email = json['email'];
  phoneNumber = json['phone_number'];
  photo = json['photo'];
  cardBalance = json['card_balance'];
  cardNumber = json['card_number'];
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['email'] = this.email;
  data['phone_number'] = this.phoneNumber;
  data['photo'] = this.photo;
  data['card_balance'] = this.cardBalance;
  data['card_number'] = this.cardNumber;
  return data;
 }
}