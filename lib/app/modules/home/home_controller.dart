import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:app_schedule_now/app/stores/client_store.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  final ClientRepository repository;


   _HomeControllerBase(this.repository);

   // Instancia do modelo de cliente
  //var client = ClienteModel();


  Future recoveredUser() async {
    return await repository.recoverUser();
  }

  Future refreshToken() async {
    return await repository.resetToken();
  }
  
  
  @observable
  bool isObscure = true;

  @action
  void changeVisibility() => isObscure = !isObscure;

  
  Future loginUser(ClienteModel data) async{
    return await repository.loginUser(data);
  }

  String validateNameController(){
    return repository.clientStore.validateName();
  }

  String validateMailController(){
    return repository.clientStore.validateMail();
  }

  String validatePassController(){
    return repository.clientStore.validatePass();
  }

  String validatePhoneController(){
    return repository.clientStore.validatePhone();
  }

  
  
}
