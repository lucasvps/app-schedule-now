import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:app_schedule_now/app/stores/client_store.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final ClientRepository repository;

  final ClientStore clientStore = ClientStore();

  _RegisterControllerBase(this.repository);

  // Lista de usuarios
  @observable
  ObservableFuture<List<ClienteModel>> clients;

  // Instancia do modelo de cliente
  //var client = ClienteModel();

  Future recoveredUser() async {
    return await repository.recoverUser();
  }
  

  // Registrar novo usuario
  Future registerClient(ClienteModel data) {
    return repository.registerUser(data);
  }

   @observable
  bool isObscure = true;

  @action
  void changeVisibility() => isObscure = !isObscure;

  String validateNameController(){
    return clientStore.validateName();
  }

  String validateMailController(){
    return clientStore.validateMail();
  }

  String validatePassController(){
    return clientStore.validatePass();
  }

  String validatePhoneController(){
    return clientStore.validatePhone();
  }

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
}
