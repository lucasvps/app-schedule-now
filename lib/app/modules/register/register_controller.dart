import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final ClientRepository repository;

  _RegisterControllerBase(this.repository);

  // Lista de usuarios
  @observable
  ObservableFuture<List<ClienteModel>> clients;

  // Instancia do modelo de cliente
  var client = ClienteModel();

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
    return client.validateName();
  }

  String validateMailController(){
    return client.validateMail();
  }

  String validatePassController(){
    return client.validatePass();
  }

  String validatePhoneController(){
    return client.validatePhone();
  }
}
