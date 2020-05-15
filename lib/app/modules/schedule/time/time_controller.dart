import 'package:app_schedule_now/app/models/professional_model.dart';
import 'package:app_schedule_now/app/models/scheduled_model.dart';
import 'package:app_schedule_now/app/repositories/professional_repository.dart';
import 'package:mobx/mobx.dart';

part 'time_controller.g.dart';

class TimeController = _TimeControllerBase with _$TimeController;

abstract class _TimeControllerBase with Store {

  var schedule = ScheduledModel();
  var professional = ProfessionalModel();

  final ProfessionalRepository scheduleRepository;

  _TimeControllerBase(this.scheduleRepository);

  Future getScheduledTime(String date, String profId) async {
    return await scheduleRepository.scheduledTime(date, profId);
  }
}
