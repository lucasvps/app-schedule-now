import 'package:app_schedule_now/app/models/list_schedules_client_model.dart';
import 'package:app_schedule_now/app/models/recover_client_model.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:mobx/mobx.dart';

part 'appointments_controller.g.dart';

class AppointmentsController = _AppointmentsControllerBase
    with _$AppointmentsController;

abstract class _AppointmentsControllerBase with Store {
  
  final ClientRepository repository;
  var appointments = ListSchedulesModel();
  var currentUser = RecoverClientModel();

  _AppointmentsControllerBase(this.repository){
    listSchedulesClient = repository.listOfSchedules().asObservable();
    listSchedulesClientDone = repository.listOfSchedulesDone().asObservable();
  }

   @observable
   ObservableFuture<List<ListSchedulesModel>> listSchedulesClient;

   @observable
   ObservableFuture<List<ListSchedulesModel>> listSchedulesClientDone;


  Future listSchedules() async {
    return await repository.listOfSchedules();
  }

  Future listSchedulesDone() async {
    return await repository.listOfSchedulesDone();
  }

  Future recover() async {
    return await repository.recoverUser();
  }

  Future cancel(String id) async {
    return await repository.cancelSchedule(id);
  }

  

}
