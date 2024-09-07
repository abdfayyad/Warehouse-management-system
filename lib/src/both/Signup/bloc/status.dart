abstract class SignInScreenStates{}

class SignInInitialState extends SignInScreenStates{}
class SignInLoadingState extends SignInScreenStates{}
class SignInSuccessState extends SignInScreenStates
{
SignINModel signINModel;

SignInSuccessState(this.signINModel);
}
class SignInErrorState extends SignInScreenStates{

}
class SignInChangePasswordVisibilityState extends SignInScreenStates{}

class SignINModel {
  String? token;
  String? message;
  String? role;

  SignINModel({this.token, this.message, this.role});

  SignINModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    data['role'] = this.role;
    return data;
  }
}