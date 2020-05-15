import 'package:mobx/mobx.dart';

class RecoverClientModel {

  int id;

  @observable
  String name;
  @action
  recoveredName(String value) => name = value;

  @observable
  String email;
  @action
  recoveredMail(String value) => email = value;
  
  @observable
  String phone;
  @action
  recoveredPhone(String value) => phone = value;

  RecoverClientModel({this.id, this.name, this.email, this.phone});

  RecoverClientModel.fromJson(Map<String, dynamic> json) {
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