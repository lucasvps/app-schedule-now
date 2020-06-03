import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;

abstract class _ClientStoreBase with Store {
  final ClienteModel clienteModel = ClienteModel();

  @observable
  String name;
  @action
  setName(String value) => name = value;

  @observable
  String email;
  @action
  setMail(String value) => email = value;

  @observable
  String password;
  @action
  setPassword(String value) => password = value;

  @observable
  String phone;
  @action
  setPhone(String value) => phone = value;

  @computed
  bool get isValidRegister{
    return validateName() == null && validateMail() == null && validatePass() == null && validatePhone() == null;
  } 

  @computed
  bool get isValidLogin{
    return validateMail() == null && validatePass() == null;
  }


  String validateName() {
    if (name == null || name.isEmpty) {
      return "Campo obrigatório";
    }

    return null;
  }

  String validateMail() {
    if (email == null || email.isEmpty) {
      return "Campo obrigatório";
    } else if (!EmailValidator.validate(email)) {
      return "Este nao é um email valido";
    }

    return null;
  }

  String validatePass() {
    if (password == null || password.isEmpty) {
      return "Campo obrigatório";
    } else if (password.length < 6) {
      return "A senha necessita ter mais que do 6 caracteres";
    }

    return null;
  }

  String validatePhone() {
    if (phone == null || phone.isEmpty) {
      return "Campo obrigatório";
    } else if (phone.length < 9) {
      return "Este nao é um numero valido";
    }

    return null;
  }
}