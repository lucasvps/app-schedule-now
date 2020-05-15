import 'package:app_schedule_now/app/models/make_schedule_client_model.dart';
import 'package:app_schedule_now/app/models/make_schedule_professional_model.dart';
import 'package:app_schedule_now/app/models/professional_model.dart';
import 'package:app_schedule_now/app/models/recover_client_model.dart';
import 'package:app_schedule_now/app/models/scheduled_model.dart';
import 'package:app_schedule_now/app/models/service_model.dart';
import 'package:app_schedule_now/app/repositories/professional_repository.dart';
import 'package:mobx/mobx.dart';

part 'schedule_controller.g.dart';

class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {

  // Instancia do modelo de cliente
  var recovered = RecoverClientModel();
  var professional = ProfessionalModel();
  var schedule = ScheduledModel();
  var service = ServiceModel();
  var makeScheduleClient = MakeScheduleClientModel();
  
  
  final ProfessionalRepository professionalRepository;
  
  _ScheduleControllerBase(this.professionalRepository);



  Future profByService(String service) async {
    return await professionalRepository.professionalsByService(service);
  }

  Future getId(String name) async {
    return await professionalRepository.getIdByName(name);
  }

  Future getScheduledTime(String date, String profId) async {
    return await professionalRepository.scheduledTime(date, profId);
  }

  Future makeSchedule(MakeScheduleClientModel data) async {
    return await professionalRepository.makeScheduleByClient(data);
  }

  Future makeScheduleProfessional(MakeScheduleProfessionalModel data, String id) async {
    return await professionalRepository.makeScheduleByProfessional(data, id);
  }

  String validateDate(){
    return schedule.validateDate();
  }

  String validateTime(){
    return schedule.validateTime();
  }
  

}
