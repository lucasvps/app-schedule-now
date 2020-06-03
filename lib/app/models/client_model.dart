import 'package:mobx/mobx.dart';
part 'client_model.g.dart';

class ClienteModel = _ClienteModelBase with _$ClienteModel;

abstract class _ClienteModelBase with Store {

  String name, email, password, phone;
  
  _ClienteModelBase(
      {this.name,
      this.email,
      this.password,
      this.phone, 
     });

  // Recuperar um json
  _ClienteModelBase.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  // Enviar um json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }

  Map<String, dynamic> toJsonLogin() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }


  // @observable
  // String name;
  // @action
  // setName(String value) => name = value;

  // @observable
  // String email;
  // @action
  // setMail(String value) => email = value;

  // @observable
  // String password;
  // @action
  // setPassword(String value) => password = value;

  // @observable
  // String phone;
  // @action
  // setPhone(String value) => phone = value;



  // @computed
  // bool get isValidRegister{
  //   return validateName() == null && validateMail() == null && validatePass() == null && validatePhone() == null;
  // } 

  // @computed
  // bool get isValidLogin{
  //   return validateMail() == null && validatePass() == null;
  // }



  // String validateName() {
  //   if (name == null || name.isEmpty) {
  //     return "Campo obrigatório";
  //   }

  //   return null;
  // }

  // String validateMail() {
  //   if (email == null || email.isEmpty) {
  //     return "Campo obrigatório";
  //   } else if (!EmailValidator.validate(email)) {
  //     return "Este nao é um email valido";
  //   }

  //   return null;
  // }

  // String validatePass() {
  //   if (password == null || password.isEmpty) {
  //     return "Campo obrigatório";
  //   } else if (password.length < 6) {
  //     return "A senha necessita ter mais que do 6 caracteres";
  //   }

  //   return null;
  // }

  // String validatePhone() {
  //   if (phone == null || phone.isEmpty) {
  //     return "Campo obrigatório";
  //   } else if (phone.length < 9) {
  //     return "Este nao é um numero valido";
  //   }

  //   return null;
  // }
}
