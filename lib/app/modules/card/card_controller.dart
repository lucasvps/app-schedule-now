import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:mobx/mobx.dart';

part 'card_controller.g.dart';

class CardController = _CardControllerBase with _$CardController;

abstract class _CardControllerBase with Store {
  final ClientRepository repository;

  _CardControllerBase(this.repository) {
    //client = repository.recoverUser().asObservable();
  }

  Future logout() async {
    return await repository.logoutUser();
  }


  // @observable
  // ObservableFuture<List<ClienteModel>> client;

  // Future<List<ClienteModel>> currentUser() async {
  //   return await repository.recoverUser();
  // }

}
